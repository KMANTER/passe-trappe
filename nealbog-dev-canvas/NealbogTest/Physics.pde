//standard library imports
import java.awt.TextArea;
import java.util.Vector;

public class Physics extends Thread {
  //constants
  public final int ticksPerSecond = 250;
  public final long nanosecondsPerSecond = 1000000000;
  public final float jiggle = 0.001;
  public final float friction = 0.985;
  public double secondsPerTick;
  //public variables
  public boolean terminate = false;
  //private variables
  private long second;
  private long time;
  private long time_old;
  private double dtime;
  private int ticks;
  private PasseTrappe game;
  //constructor
  public Physics(PasseTrappe pt){
    //basic initialization
    this.game = pt;
    secondsPerTick = 1.0/ticksPerSecond;
    time = System.nanoTime();
    second = time/nanosecondsPerSecond;
    updateTime();
  }

  //methods
  public void run(){
    while( !terminate){
      tick();
    }
  }

  public void tick(){
    updateTime();
    
    for( Puck puck : game.getPucks()){
      PVector step = new PVector( puck.velocity.x, puck.velocity.y);
      step.x *= dtime;
      step.y *= dtime;
      puck.position.add( step);
      puck.velocity.mult( friction);
    }
    int i = 0;
    for( Puck puck : game.getPucks()){
      handlePuckCollisions(puck, i);
      handleWallCollisions(puck);
      i++;
    }
    
    applyTickLimit();
  }

  //collision functions
  public void handlePuckCollisions( Puck puck, int index){
    
    for( int i = index + 1; i < game.getPucks().size(); i++){
      Puck other = game.getPucks().get( i);

      PVector difference = PVector.sub(other.position, puck.position);
      float distance = difference.mag() - puck.radius - other.radius;
      //println( String.format("%f %f", difference.x, difference.y));
      if( distance < 0){
        difference.normalize();
        
        //push the pucks apart
        difference.mult( distance / 2 - jiggle);
        puck.position.add( difference);
        other.position.sub( difference);
        
        //bounce the pucks off each other
        //mass calculations
        double totalMass = puck.mass + other.mass;
        double puck_massTerm1 = ( puck.mass - other.mass) / totalMass;
        double puck_massTerm2 = ( other.mass * 2.0) / totalMass;
        double other_massTerm1 = ( other.mass - puck.mass) / totalMass;
        double other_massTerm2 = ( puck.mass * 2.0) / totalMass;

        //velocity calculations
        // these velocities are relative to the direction of the collision
        PVector puck_v = game.projection( puck.velocity, difference);
        PVector other_v = game.projection( other.velocity, difference);
        puck.velocity.sub( puck_v);
        other.velocity.sub( other_v);
        
        PVector puck_force = game.scale( puck_v, puck_massTerm1);
        PVector other_force = game.scale( other_v, other_massTerm1);
        
        puck_force.add( game.scale( other_v, puck_massTerm2));
        other_force.add( game.scale( puck_v, other_massTerm2));

        puck.velocity.add( puck_force);
        other.velocity.add( other_force);
      }
    }
  }

  public void handleWallCollisions( Puck puck){
    for( Wall wall : game.getWalls()){
      //get puck to wall distance
      PVector posPuck= puck.position;
      PVector middleTopCorner = game.getmiddleTopCorner();
      PVector middleBottomCorner = game.getmiddleBottomCorner();

      if( ( posPuck.y > middleBottomCorner.y || posPuck.y < middleTopCorner.y) || (posPuck.x< 550 || posPuck.x >650) ){ 

        PVector distanceVector = wall.distanceVector(puck.position);
        float distance = distanceVector.mag();
        //print( String.format( "%f %f ", distanceVector.x, distanceVector.y));
        //print( String.format( "%f ", distance));
        if( distance < puck.radius){
          distanceVector.normalize();
          //push the puck away from the wall
          PVector push = PVector.mult(
            distanceVector, puck.radius - distance + jiggle);
          puck.position.add( push);
          //bounce the puck off the wall
          PVector force = game.projection( puck.velocity, distanceVector);
          force.mult( -2);
          puck.velocity.add( force);
        }
      }
    }
    //println();
  }

  public void handleElasticCollision(Elastic elastic, Puck puck){
    PVector impact = null;
    if(puck.position.x < game.marge){
      print("Impact");
      impact = new PVector(puck.position.x, puck.position.y + puck.radius);
    }else if(puck.position.x > game.window_width - game.marge){
      impact = new PVector(puck.position.x + puck.radius, puck.position.y + puck.radius);
    } 
    elastic.editCurve(impact);
    /* 
      PVector touchPosition = new PVector(t.x, t.y);
      PVector difference = PVector.sub(touchPosition, puck.position);
      float distance = difference.mag() - puck.radius - force;
      //println( String.format("%f %f", difference.x, difference.y));
      if( distance < 0){
        difference.normalize();
        
        //push the pucks apart
        difference.mult( distance / 2 - jiggle);
        puck.position.add( difference);
        
        //bounce the pucks off each other
        //mass calculations
        double totalMass = puck.mass + 100;
        double puck_massTerm1 = ( puck.mass - 100) / totalMass;
        double puck_massTerm2 = ( 100 * 2.0) / totalMass;

        //velocity calculations
        // these velocities are relative to the direction of the collision
        PVector puck_v = game.projection( puck.velocity, difference);
        puck.velocity.sub(puck_v);
        
        PVector puck_force = game.scale( puck_v, puck_massTerm1);
        puck_force.add( game.scale(touchPosition, puck_massTerm2));
        puck.velocity.add( puck_force);
      }
       */
  }
  
  //utility functions
  private void updateTime(){
    time_old = time;
    time = System.nanoTime();
    dtime = (time - time_old)/1e9;
    if( second != time/nanosecondsPerSecond){
      //println( String.format("tps: %d", ticks));
      ticks = 0;
      second = time/nanosecondsPerSecond;
    }
    ticks++;
  }

  private void applyTickLimit(){
    try {
      long time2 = System.nanoTime();
      double dtime2 = (time2 - time)/1e9;
      double timeLeft = secondsPerTick - dtime2;
      //println(timeLeft);
      if( timeLeft > 0){
        Thread.sleep( Math.round( timeLeft*1000));
      }
    } catch( InterruptedException e){}
  }
}
