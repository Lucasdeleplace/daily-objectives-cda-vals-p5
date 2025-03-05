# GitHub CLI (gh) Cheatsheet

GitHub CLI est un outil en ligne de commande qui permet d'interagir avec GitHub directement depuis votre terminal.

## Installation

```bash
# Sur Ubuntu/Debian
sudo apt install gh

# Sur macOS avec Homebrew
brew install gh
```

## Authentification

```bash
# Connexion à GitHub
gh auth login

# Vérifier le statut de l'authentification
gh auth status
```

## Gestion des dépôts

```bash
# Cloner un dépôt
gh repo clone owner/repo

# Créer un nouveau dépôt
gh repo create [nom] --public/--private

# Forker un dépôt
gh repo fork owner/repo

# Voir les informations d'un dépôt
gh repo view owner/repo

# Lister ses dépôts
gh repo list
```

## Issues

```bash
# Créer une issue
gh issue create --title "Titre" --body "Description"

# Lister les issues
gh issue list

# Voir une issue spécifique
gh issue view [numéro]

# Fermer une issue
gh issue close [numéro]

# Réouvrir une issue
gh issue reopen [numéro]
```

## Pull Requests

```bash
# Créer une pull request
gh pr create --title "Titre" --body "Description"

# Lister les pull requests
gh pr list

# Voir une pull request spécifique
gh pr view [numéro]

# Vérifier une pull request localement
gh pr checkout [numéro]

# Merger une pull request
gh pr merge [numéro]
```

## Gist

```bash
# Créer un gist
gh gist create fichier.txt

# Lister ses gists
gh gist list

# Cloner un gist
gh gist clone [id-du-gist]
```

## Workflows

```bash
# Lister les workflows
gh workflow list

# Voir les runs d'un workflow
gh run list

# Voir le statut d'un run
gh run view [id-du-run]
```

## Configuration

```bash
# Configurer les paramètres par défaut
gh config set editor vim
gh config set git_protocol ssh
```

## Astuces

- Utilisez `gh help [commande]` pour obtenir de l'aide sur une commande spécifique
- La complétion automatique est disponible pour bash/zsh
- La plupart des commandes acceptent des flags pour plus d'options

## Alias utiles

```bash
# Configurer des alias
gh alias set prc 'pr create'
gh alias set prl 'pr list'
gh alias set prv 'pr view'
```

## Environnement

- `GH_TOKEN`: Token d'authentification GitHub
- `GH_ENTERPRISE_TOKEN`: Token pour GitHub Enterprise
- `GH_HOST`: Hôte GitHub personnalisé

## Documentation

Pour plus d'informations, consultez :
- Documentation officielle : https://cli.github.com/manual/
- GitHub CLI Repository : https://github.com/cli/cli 