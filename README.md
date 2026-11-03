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

Q7 : Expanded donne a la Column la largeur disponible dans la Row. la Row contenant la note et le prix dispose d'un espace
horizontal libre. Sans largeur disponible il peut provoquer une erreur de contraintes.

Q8 : Aucune ligne supplementaire dans HomeScreen ,il suffit d'ajouter une destination a la liste destinations,
dans le fichier ou cette liste est declaree. La boucle for afficher automatiquement la nouvelle carte.

Q9 : Si on écrit _categorie = c; sans setState(), la valeur de _categorie change en mémoire, Flutter ne relance pas automatiquement build().
alors l'écran ne se met pas forcement à jour immediatement.

Q10 : _filtrees est un getter recalculé à chaque build() parce que la liste filtrée dépend de _categorie. quand la catégorie change et setState() relance build(), le getter renvoie automatiquement la bonne liste.

Q11 : HeroBanner peut rester un StatelessWidget parce qu'il ne gère pas d'état interne qui change. C'est HomeScreen qui gère l'état avec setState().
Flutter reconstruit les widgets nécessaires lorsque l'état change.

Q12 : Oui, le filtre est conservé. Navigator.push() ajoute l'écran DetailScreen au-dessus de HomeScreen dans la pile de navigation. Quand on utilise Navigator.pop(), DetailScreen est retiré et on retrouve HomeScreen dans son état précédent, donc le filtre " Désert" est toujours actif.

Q13:DetailScreen reçoit la destination grace a son constructeur. Lorsqu on ouvre l'écran, on transmet l'objet destination de la carte sélectionnee. On réutilise le mecanisme de passage de parametres par constructeur étudiee au TP3.

Q14: L'effet animation tactile "InkWell" peut dépasser les coins arrondis de la carte. Avec Clip.antiAlias, l'effet est découpe pour respecter les bordures arrondies.

Q15 : formKey.currentState!.validate() cette méthode vérifie tous les champs du Form en exécutant leurs fonctions validator. elle renvoie true si tous les champs sont valides.elle renvoie false si au moins un champ contient une erreur.

Q16 : inputFormatters controle la saisie pendant que l'utilisateur écrit. par exemple il empechent de saisir des lettres et limitent le téléphone à 8 chiffres. validator vérifie si la valeur saisie est correcte lorsque la validation du formulaire est déclenchée. Par exemple, il vérifie que le numéro contient exactement 8 chiffres.

Q17 : dispose() permet de libérer les ressources utilisée par les TextEditingController lorsqu on quitte l'écran.