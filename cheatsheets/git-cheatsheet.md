# Git Cheat Sheet

## Configuration initiale

```bash
# Configurer son identité
git config --global user.name "Votre Nom"
git config --global user.email "votre@email.com"

# Configurer l'éditeur par défaut
git config --global core.editor "code --wait"  # Pour VS Code

# Afficher la configuration
git config --list
```

## Commandes de base

### Initialisation et clonage
```bash
# Créer un nouveau dépôt
git init

# Cloner un dépôt existant
git clone <url_du_depot>
git clone <url_du_depot> <nom_dossier>
```

### Gestion des modifications

```bash
# Voir l'état des fichiers
git status

# Ajouter des fichiers
git add <fichier>          # Ajouter un fichier spécifique
git add .                  # Ajouter tous les fichiers
git add *.js              # Ajouter tous les fichiers .js

# Valider les modifications
git commit -m "Message du commit"
git commit -am "Message"   # Add + commit pour les fichiers déjà suivis

# Voir l'historique
git log                    # Historique complet
git log --oneline         # Format condensé
git log --graph           # Avec graphique des branches
```

### Branches

```bash
# Gestion des branches
git branch                 # Liste des branches
git branch <nom>          # Créer une branche
git checkout <nom>        # Changer de branche
git checkout -b <nom>     # Créer et changer de branche
git branch -d <nom>       # Supprimer une branche
git branch -D <nom>       # Forcer la suppression

# Fusion
git merge <branche>       # Fusionner une branche dans la branche courante
git merge --abort         # Annuler une fusion en cours
```

### Travail avec le remote

```bash
# Gestion des remotes
git remote -v                     # Liste des remotes
git remote add origin <url>       # Ajouter un remote
git remote remove <nom>           # Supprimer un remote

# Synchronisation
git fetch origin                  # Récupérer les modifications sans fusion
git pull origin <branche>        # Récupérer et fusionner
git push origin <branche>        # Envoyer les modifications
git push -u origin <branche>     # Premier push d'une branche
```

## Commandes avancées

### Gestion des modifications

```bash
# Annuler des modifications
git restore <fichier>            # Annuler les modifications non indexées
git restore --staged <fichier>   # Désindexer un fichier
git reset --hard HEAD~1          # Annuler le dernier commit
git revert <commit>              # Créer un commit d'annulation

# Sauvegarder temporairement
git stash                        # Mettre de côté les modifications
git stash list                   # Liste des stash
git stash pop                    # Récupérer le dernier stash
git stash drop                   # Supprimer le dernier stash
```

### Manipulation de l'historique

```bash
# Modifier le dernier commit
git commit --amend              # Modifier le message ou ajouter des fichiers
git commit --amend --no-edit    # Ajouter au dernier commit sans changer le message

# Rebase
git rebase -i HEAD~3           # Rebase interactif sur les 3 derniers commits
git rebase <branche>           # Rebase sur une branche
git rebase --abort            # Annuler un rebase en cours
```

### Tags

```bash
# Gestion des tags
git tag                        # Liste des tags
git tag -a v1.0 -m "Version 1.0"  # Créer un tag annoté
git tag -d v1.0               # Supprimer un tag
git push origin --tags        # Pousser tous les tags
```

### Diagnostic et maintenance

```bash
# Recherche et diagnostic
git blame <fichier>           # Voir qui a modifié chaque ligne
git bisect start             # Démarrer une recherche binaire
git grep "texte"             # Rechercher dans les fichiers

# Maintenance
git gc                       # Nettoyer le dépôt
git prune                    # Supprimer les objets orphelins
git fsck                     # Vérifier l'intégrité
```

## Workflows courants

### Feature Branch Workflow
```bash
git checkout -b feature/nouvelle-fonctionnalite
# Travailler sur la fonctionnalité
git add .
git commit -m "Ajout de la nouvelle fonctionnalité"
git push -u origin feature/nouvelle-fonctionnalite
# Créer une Pull Request sur GitHub/GitLab
```