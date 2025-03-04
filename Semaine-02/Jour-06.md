# Objectifs journaliers

## Mardi(Gras) 04/03/2025 :

### Git fondamentaux avancés

- [ ] Comprendre le fonctionnement des références et pointeurs dans Git
> Les références dans Git sont des pointeurs vers des commits spécifiques. HEAD, branches et tags sont des exemples de références.
```bash
# Voir où pointe HEAD
cat .git/HEAD

# Voir les références des branches
ls -la .git/refs/heads/

# Voir le commit pointé par une branche
git rev-parse main
```

- [ ] Comprendre le merge dans Git (approfondissement)
> Le merge combine les modifications de différentes branches.
```bash
# Merge classique
git checkout main
git merge feature
# Merge avec --no-ff pour forcer un commit de merge
git merge --no-ff feature
# Voir la structure des merges
git log --graph --oneline
```

- [ ] Comprendre le rebase dans Git (quelle différence avec le merge ?)
> Le rebase réécrit l'historique en déplaçant une série de commits vers une nouvelle base.
```bash
# Rebase basique
git checkout feature
git rebase main

# Rebase interactif pour nettoyer l'historique
git rebase -i HEAD~3
```

- [ ] Comprendre la différence entre `git reset` et `git revert`
> Reset modifie l'historique, revert crée un nouveau commit d'annulation.
```bash
# Reset : supprime les commits (dangereux sur branches partagées)
git reset --hard HEAD~1  # Supprime le dernier commit
git reset --soft HEAD~1  # Garde les modifications en staging

# Revert : crée un nouveau commit d'annulation (sûr pour branches partagées)
git revert HEAD         # Annule le dernier commit
git revert abc123..def456  # Annule une série de commits
```

- [ ] Savoir annuler des `commits` et/ou `merge commits`
> Plusieurs façons d'annuler des modifications selon le contexte.
```bash
# Annuler un merge commit
git reset --hard HEAD~1  # Si le merge n'est pas poussé
git revert -m 1 HEAD     # Si le merge est déjà poussé

# Revenir à un état précédent
git reflog               # Voir l'historique des actions
git reset --hard HEAD@{2}  # Revenir 2 actions en arrière
```

- [ ] Comprendre l'utilité et le fonctionnement de `git stash`
> Stash permet de mettre de côté des modifications temporairement.
```bash
# Stocker les modifications
git stash push -m "Modifications en cours sur la feature login"

# Lister les stash
git stash list

# Récupérer les modifications
git stash pop   # Applique et supprime le dernier stash
git stash apply # Applique sans supprimer

# Gérer plusieurs stash
git stash save "message"
git stash apply stash@{2}
git stash drop stash@{2}
```

- [ ] Comprendre et utiliser le `git diff`
> Diff permet de voir les différences entre différents états.
```bash
# Différences dans le working directory
git diff

# Différences en staging
git diff --staged

# Différences entre branches
git diff main..feature

# Différences pour un fichier
git diff HEAD -- path/to/file
```

- [ ] Comprendre la différence entre `git log` et `git show`
> Log montre l'historique, show montre les détails d'un commit.
```bash
# Log avec différents formats
git log --oneline
git log --graph 

# Show pour voir les détails
git show HEAD        # Dernier commit
git show abc123      # Commit spécifique
git show HEAD~3      # 3ème commit avant HEAD
```

- [ ] Comprendre et utiliser le `git fetch`
> Fetch récupère les modifications du remote sans les fusionner.
```bash
# Récupérer toutes les branches
git fetch origin

# Récupérer une branche spécifique
git fetch origin feature

# Voir les différences après fetch
git log HEAD..origin/main
```

- [ ] `.gitignore` global ou pas ?
> Le .gitignore peut être global ou local selon les besoins.
> En général, on utilise un .gitignore global pour ne pas avoir à le configurer pour chaque projet.
```bash
# .gitignore global
git config --global core.excludesfile ~/.gitignore_global

# Contenu type d'un .gitignore
*.log
node_modules/
.env
.DS_Store
```

- [ ] Comprendre quelle est la différence entre `git pull` et `git fetch`
> Pull = fetch + merge, fetch récupère sans fusionner.
```bash
# Fetch seul
git fetch origin
git diff main origin/main  # Voir les différences
git merge origin/main      # Fusionner si ok

# Pull (équivalent à fetch + merge)
git pull origin main

# Pull avec rebase au lieu de merge
git pull --rebase origin main
```

### Git avancé

- [ ] Comprendre l'utilité et savoir utiliser `git cherry-pick`
> Cherry-pick permet de prendre un commit spécifique et de l'appliquer ailleurs.
```bash
# Appliquer un commit spécifique
git cherry-pick abc123

# Appliquer plusieurs commits
git cherry-pick abc123..def456

# Cherry-pick sans commiter
git cherry-pick -n abc123
```

- [ ] Comprendre l'utilité et savoir utiliser `git bisect`
> Bisect aide à trouver le commit qui a introduit un bug par recherche binaire.
```bash
# Démarrer la recherche
git bisect start
git bisect bad    # Version actuelle avec le bug
git bisect good v1.0  # Dernière version connue sans le bug

# Git fait une recherche binaire
# Pour chaque commit, tester et marquer
git bisect good  # Si le bug n'est pas présent
git bisect bad   # Si le bug est présent

# Quand terminé
git bisect reset
```
