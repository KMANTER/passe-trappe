# NEALBOG #

Nealbog-dev-canvas met à votre disposition un canvas de développement vous permettant de
tester votre mini-jeu dans un environnement identique à celui du jeu complet.

Vous trouverez dans le code une class MyMiniGame, contenant le template de base d'un mini-jeu.

Nous vous invitons à reprendre ce fichier, le renommer selon vos envies, et renommer la classe
de façon adéquate.

## IMiniGame ##

Votre classe est une classe-fille de MiniGame, qui implémente elle-même IMiniGame.

Les méthodes de IMiniGame a définir sont les suivantes:


```
#!java

interface IMiniGame {
  void init();
  void handleInput(InputHandler inputHandler);
  IState update(float delta);
  void draw();
}
```

### init ###

Contient la logique d'initialisation d'une partie de votre mini-jeu.

** ATTENTION **

Le constructeur de votre classe ne sera appelé qu'une seule fois sur toute la vie de l'application, au chargement de celle-ci.
La logique d'initialisation d'une partie (emplacement par défaut des éléments, scores, etc...) doit être contenus dans init(), laquelle est
appelée chaque fois que le mini-jeu commence.

### handleInput ###

Contient la logique de traitement des inputs utilisateur.

Le paramètre inputHandler vous offre une interface identique à celle d'SMT, mais livre directement des coordonnées calibrées.

### update ###

Contient la logique du jeu.

Doit retourner obligatoirement un IState (représentant le prochain état -screen- de l'application).

Trois méthodes vous sont fournies pour cela:

* KeepOn()   : Renvoit l'état présent (la boucle du mini-jeu continue)
* lose()     : Renvoit l'état "Plateau de jeu" de l'application.
* win()      : Renvoit l'état "Plateau de jeu" de l'application après avoir enregistré la victoire du joueur.

Dans le cadre du canvas de test, retourner lose() ou win() réinitialise seulement le mini-jeu.

## Boucle de jeu ##

Les méthodes sont appelées en boucle durant la vie du mini-jeu dans l'ordre suivant:


```
#!java

handleInput();
update();
draw();
```

## Enregistrer le mini-jeu ##
Dans la classe NealbogTest, au sein de la méthode registerMiniGames(), enregistrez votre classe de mini-jeu de la façon suivante:


```
#!java

game.registerMiniGame(new MyMiniGame());
```