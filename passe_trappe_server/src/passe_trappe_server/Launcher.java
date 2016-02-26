package passe_trappe_server;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


public class Launcher {
	static ServerSocket ss;
	protected final static int port = 19999;
	static Socket connection;

	static boolean first;
	static StringBuffer process;
	static String TimeStamp;

	protected LinkedList<String> single_playersScores;
	protected LinkedList<String> multi_playersScores;
	protected File f_score1;
	protected File f_score2;

	public Launcher() {
		try {
			ss = new ServerSocket(19999);
			single_playersScores = new LinkedList<String>();
			multi_playersScores = new LinkedList<String>();

			f_score1 = new File("scores_1.txt");
			f_score2 = new File("scores_2.txt");

			if(!f_score1.exists()){
				f_score1.createNewFile();
				System.out.println("> f_score1 created");
			}else{
				FileReader fr = new FileReader(f_score1);
				BufferedReader br = new BufferedReader(fr);

				// Filling the list
				while(br.read() != -1){
					String line = br.readLine();
					this.addToScoreList(line);
					System.out.println(line + " added");
				}
				br.close();
			}

			if(!f_score2.exists()){
				f_score2.createNewFile();
				System.out.println("> f_score2 created");
			}else{
				FileReader fr = new FileReader(f_score2);
				BufferedReader br = new BufferedReader(fr);

				// Filling the list
				while(br.read() != -1){
					String line = br.readLine();
					this.addToScoreList(line);
					System.out.println(line + " added");
				}
				br.close();
			}

		} catch (IOException ex) {
			Logger.getLogger(Launcher.class.getName()).log(Level.SEVERE, null, ex);
		}
	}

	public static void main(String[] args) {
		try{
			Launcher l = new Launcher();
			System.out.println("SocketServer Initialized");
			int character;
			while (true) {
				connection = ss.accept();
				System.out.println(">Connection founded");
				BufferedInputStream is = new BufferedInputStream(connection.getInputStream());
				InputStreamReader isr = new InputStreamReader(is);
				process = new StringBuffer();

				while((character = isr.read()) != 13) {
					process.append((char)character);
				}

				// TODO : Add process in playersScores list
				l.addToScoreList(process.toString());

				//need to wait 10 seconds for the app to update database
				try {
					Thread.sleep(2000);

					PrintWriter writer = new PrintWriter(l.f_score1, "UTF-8");
					for(String s : l.single_playersScores){
						System.out.println("writing : " + s);
						writer.println(s);
					}
					writer.close();
					
					PrintWriter writer2 = new PrintWriter(l.f_score2, "UTF-8");
					for(String s : l.multi_playersScores){
						System.out.println("writing : " + s);
						writer2.println(s);
					}
					writer2.close();

				}
				catch (Exception e){}
			}
		}
		catch (IOException e) {}
		try {
			connection.close();
		}
		catch (IOException e) {}
	}

	private void addToScoreList(String process) {
		System.out.println("Adding : " + process);
		String[] line = process.split(" : ");
		int type = Integer.parseInt(line[0]);
		if(type == 1){
			this.addToScore1(process);
		}else if(type == 2){
			this.addToScore2(process);
		}
	}

	private void addToScore1(String process){
		System.out.println("Adding : " + process);
		String[] line = process.split(" : ");
		String curr_name = line[1];
		int curr_time = Integer.parseInt(line[2]);
		System.out.println(" >> " + curr_name +" : " + curr_time);
		if(this.single_playersScores.size() == 0){
			this.single_playersScores.add(curr_name+" : "+curr_time);
		}else{
			for(int i = 0; i < this.single_playersScores.size(); i++){
				String[] tmp_line = single_playersScores.get(i).split(" : ");
				int tmp_time = Integer.parseInt(tmp_line[1]);
				System.out.println(curr_time +" or " + tmp_time);
				if(curr_time <= tmp_time){
					this.single_playersScores.add(i, curr_name+" : "+curr_time);
					System.out.println("added before");
					break;
				}else if(i == this.single_playersScores.size() - 1){
					this.single_playersScores.addLast(curr_name+" : "+curr_time);
					System.out.println("added to the end");
					break;
				}
			}
		}
		System.out.println("There's now "+ this.single_playersScores.size() + " players in SINGLE MODE");
	}
	
	private void addToScore2(String process){
		System.out.println("Adding : " + process);
		String[] line = process.split(" : ");
		String curr_name = line[1];
		int curr_time = Integer.parseInt(line[2]);
		System.out.println(" >> " + curr_name +" : " + curr_time);
		if(this.multi_playersScores.size() == 0){
			this.multi_playersScores.add(curr_name+" : "+curr_time);
		}else{
			for(int i = 0; i < this.multi_playersScores.size(); i++){
				String[] tmp_line = multi_playersScores.get(i).split(" : ");
				int tmp_time = Integer.parseInt(tmp_line[1]);
				System.out.println(curr_time +" or " + tmp_time);
				if(curr_time <= tmp_time){
					this.multi_playersScores.add(i, curr_name+" : "+curr_time);
					System.out.println("added before");
					break;
				}else if(i == this.multi_playersScores.size() - 1){
					this.multi_playersScores.addLast(curr_name+" : "+curr_time);
					System.out.println("added to the end");
					break;
				}
			}
		}
		System.out.println("There's now "+ this.multi_playersScores.size() + " players in MULTI MODE");
	}

	private String toString(List<String> l){
		StringBuffer sb = new StringBuffer();
		for(String s : l){
			sb.append(s + "\n");
		}

		return sb.toString();
	}

}
