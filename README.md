##Questions :

Q1. Si on supprime Expanded autour de la Column,la Column prend seulement la largeur necessaire
a son contenu .l'avatar reste apres la column dans la row, mais sa position horizontale peut changer
car la Column ne prend plus tout l'espace disponible.

Q2. prenom est final car sa valeur est definie une seule fois lors de la création de HomeHeader.
Elle ne peut plus etre modifiee ensuite.

Q3. cs.primary est une couleur issue du theme material 3. Elle s'adapte a la seedColor du theme.
Colors.teal est une couleur fixe : elle ne change pas automatiquement si seedColor change.

Q4 : Si DecoratedBox est placé en premier, le dégradé se trouve derrière l'image. L'image le recouvre donc entièrement.

Q5 : Sans ClipRRect les coins de l'image ne sont plus decoupees selon
rayon de 24 pixels. l'image peut avoir des coins carres.

Q6 : right: 130 reserve de l'espace a droite pour le bouton decouvrir et evite que
le texte ne se superpose au bouton.
