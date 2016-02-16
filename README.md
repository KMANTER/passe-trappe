# passe-trappe
un jeu pour tablette multi-touch dans le cadre d'un projet d'école INSTA

But du jeu : 

Le gagnant est le premier qui parvient à vider son camp de tous les palets.

Règles du jeu : 

Chacun se place d'un coté du jeu et pose 5 palets dans son camp. Chaque joueur tente de faire passer le plus rapidement possible tous les palets situés dans son camp vers le camp adverse, en les propulsant avec la partie élastique. Il n'y a pas de tour de jeu, les joueurs lancent leurs palets en même temps le plus vite possible. Tous les palets doivent être lancés par l'élastique. 

Par soucis de détection du tactile par le matériel, le joueur devra utiliser un cylindre en bois  pour attraper les palets.

Spécifications : 

Partie client :
La partie se joue en 2 manches gagnantes.
Chaque partie sera limitée à 2’30. Le jeu s’arrête dès qu’un joueur passe tous ses palets de l’autre coté. Passé la limite de temps, le joueur gagnant sera désigné par le nombre de palets passé de l’autre coté (l’égalité étant possible).
Les palets seront au nombre de 10 (5 par camp) et ils seront éjectables via un élastique situé en bas du camp.
Le palet mesure 8 cm de diamètre.
Le joueur pourra choisir son niveau de difficulté : Facile, Moyen, Warrior ( plus le niveau est élevé plus la fente sera petite). : 
Facile : 11 cm
Moyen: 10 cm
Warrior: 9 cm
L’aire de jeu mesure : ce qui correspond à la surface tactile de l’écran.
Il existe plusieurs modes de jeu :
Solo : 1 joueur, 30 secondes pour en passer un maximum de palets à travers la fente
2 joueurs : 2 camps, 5 palets chacun et 2’30 maximum de jeu.
Le niveau de difficulté est disponible avec les deux modes.
Si le palet est situé en milieu de table (où le joueur aura du mal à le bouger en le touchant à cause des infrarouges moins présents), un bouton sera disponible pour ramener les palets inaccessibles vers le joueur.

A la fin de chaque manche, le joueur gagnant pourra entrer son nom/pseudo pour s’inscrire dans le tableau d’honneur

Partie Serveur:

Récupération des noms/pseudos des joueurs pour l’ajout dans le tableau d’honneur.
Tri des joueurs selon le mode de jeu
Mode Solo : Tri descendant sur le nombre de palets passés
Mode 2 joueurs : Tri descendant sur le nombre de victoires

Affichage
Respect de l’ambiance du jeu de base (pirate)
Bords du plateau boisés

