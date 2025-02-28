# Objectifs journaliers

### Jeudi 27/02/2025 :

- [x] Faire le wargame bandit jusqu'au niveau 5 (anglais)
> Réalisation des exercices de sécurité sur OverTheWire pour apprendre les commandes Linux et la sécurité de base.

Seulement si le wargame bandit est au niveau 5 minimum :
niveau 0 => 1 : ZjLjTmM6FvvyRnrb2rfNWOZOTa6ip5If
> Première connexion SSH au serveur du wargame.

niveau 1 => 2 : 263JGJPfgU6LtdEvgfWU1XP5yac29mFx
> Apprentissage de la lecture de fichiers avec des noms spéciaux.

niveau 2 => 3 : MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx
> Utilisation des caractères d'échappement pour les espaces.

niveau 3 => 4 : 2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ
> Découverte des fichiers cachés avec ls -al.

niveau 4 => 5 : 2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ
> Utilisation de la commande file pour identifier le type de fichier.

niveau 5 => 6 : 4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw
> Recherche de fichiers avec des critères spécifiques.

niveau 6 => 7 : HWasnPhtq9AVKe0dmk45nxy20cvUa6EG
> Utilisation avancée de la commande find.

niveau 1 => 2  : 263JGJPfgU6LtdEvgfWU1XP5yac29mFx
> Apprentissage de la lecture de fichiers avec des noms spéciaux.

niveau 0 => 3  : MNk8KNH3Usiio41PRUEoDFPqfxLPlSmx
> Utilisation des caractères d'échappement pour les espaces.

niveau 0 => 4 : 2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ
> Découverte des fichiers cachés avec ls -al.

niveau 0 => 5 : 2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ
> Utilisation de la commande file pour identifier le type de fichier.

niveau 0 => 6  : 4oQYVPkxZOOEOO5pTW81FB8j8lxXGUQw
> Recherche de fichiers avec des critères spécifiques.

niveau 0 => 1 : HWasnPhtq9AVKe0dmk45nxy20cvUa6EG
> Utilisation avancée de la commande find.

#### Git

- [x] Création de compte + configuration Github
> Mise en place d'un compte GitHub et configuration des paramètres de base.

- [x] Installation et configuration de Git
> Installation de Git sur la machine locale et configuration des paramètres utilisateur.

- [x] Comprendre le versionning
> Apprentissage des principes de gestion de versions et leur importance dans le développement.

- [x] Comprendre le fonctionnement de Git
  - [x] Comprendre le staging de Git
  > Maîtrise de la zone de staging et son rôle dans le processus de commit.
  
  - [x] Comprendre le fonctionnent et l'utilité des commandes de bases de Git :
    - [x] git init
    > Initialisation d'un nouveau dépôt Git.
    ```bash
    # Créer un nouveau dépôt
    git init mon-projet
    cd mon-projet
    ```
    
    - [x] git add
    > Ajout de fichiers à la zone de staging.
    ```bash
    # Ajouter un fichier spécifique
    git add index.html
    # Ajouter tous les fichiers
    git add .
    ```
    
    - [x] git status
    > Vérification de l'état des fichiers.
    ```bash
    git status
    # Affichage court
    git status -s
    ```
    
    - [x] git commit
    > Enregistrement des modifications dans le dépôt.
    ```bash
    git commit -m "feat: ajout de la page d'accueil"
    # Ajouter et commiter en même temps
    git commit -am "fix: correction du bug #123"
    ```
    
    - [x] git pull
    > Récupération et fusion des modifications distantes.
    ```bash
    git pull origin main
    # Avec rebase
    git pull --rebase origin main
    ```
    
    - [x] git push
    > Envoi des modifications locales vers le dépôt distant.
    ```bash
    git push origin main
    # Pousser une nouvelle branche
    git push -u origin nouvelle-feature
    ```
    
    - [x] git clone
    > Copie d'un dépôt distant en local.
    ```bash
    git clone https://github.com/utilisateur/repo.git
    # Cloner une branche spécifique
    git clone -b develop https://github.com/utilisateur/repo.git
    ```
    
    - [x] git remote
    > Gestion des connexions avec les dépôts distants.
    ```bash
    # Lister les remotes
    git remote -v
    # Ajouter un remote
    git remote add origin https://github.com/utilisateur/repo.git
    ```

- [x] Faire le parcours Git-it pour les débutants (Nodeschool.io)
> Réalisation du tutoriel interactif pour maîtriser les bases de Git.

- [x] Faire ses premiers commits sur les daily objectives
> Mise en pratique des commandes Git sur les objectifs quotidiens.

- [x] Faire ses premiers pushs des daily-objectives sur son compte Github
> Publication des modifications sur le dépôt distant GitHub.

- [x] Faire ses première manipulations de versionning en CLI only
> Pratique des commandes Git exclusivement en ligne de commande.

* [x] Comprendre les termes "local", "origin" et "upstream"
> Apprentissage des différents types de dépôts et leurs relations.
```bash
# Local : votre copie de travail
git status

# Origin : votre fork/dépôt distant
git push origin main

# Upstream : dépôt source/parent
git pull upstream main
```

* [x] Faire ses premiers commits sur les daily objectives
> Application pratique des connaissances Git sur les objectifs quotidiens.

* [x] Faire ses premiers pushs des daily-objectives sur son compte Github
> Synchronisation du travail local avec le dépôt distant.

* [x] Découvrir les conventions de nommage de son versionning avec la convention Angular
> Apprentissage des bonnes pratiques de nommage des commits selon la convention Angular.

* [x] Comprendre le fonctionnement des branches dans Git
> Maîtrise de la gestion des branches pour le développement parallèle.
```bash
# Créer une nouvelle branche
git branch feature/login
# Changer de branche
git checkout feature/login
# Créer et changer en une commande
git checkout -b feature/login
```

* [x] Comprendre le merge dans Git
> Compréhension du processus de fusion des branches et résolution des conflits.
```bash
# Fusionner une branche dans main
git checkout main
git merge feature/login
# En cas de conflit
git status
git add . # après résolution
git merge --continue
```

#### Github

- [x] Pimper son profile Github (belle du village)
- [x] Configurer un tunnel SSH entre son local et son Github
- [x] Découvrir l'interface de Github :
  - [x] Pull Requests
  - [x] Branches
  - [x] Issues
  - [x] Settings projet
  - [x] Settings profile
