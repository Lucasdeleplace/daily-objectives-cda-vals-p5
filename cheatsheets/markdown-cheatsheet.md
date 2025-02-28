# Markdown Cheat Sheet

## Titres

```markdown
# Titre niveau 1
## Titre niveau 2
### Titre niveau 3
#### Titre niveau 4
##### Titre niveau 5
###### Titre niveau 6
```

## Formatage de texte

```markdown
**Texte en gras**
*Texte en italique*
***Texte en gras et italique***
~~Texte barré~~
```

## Listes

### Liste non ordonnée
```markdown
- Premier élément
- Deuxième élément
  - Sous-élément
  - Autre sous-élément
- Troisième élément
```

### Liste ordonnée
```markdown
1. Premier élément
2. Deuxième élément
   1. Sous-élément
   2. Autre sous-élément
3. Troisième élément
```

## Liens et Images

### Liens
```markdown
[Texte du lien](URL)
[Lien avec titre](URL "Titre au survol")
```

### Images
```markdown
![Texte alternatif](URL_de_l_image)
![Alt text](URL_de_l_image "Titre de l'image")
```

## Citations

```markdown
> Ceci est une citation
> Sur plusieurs lignes
>> Citation imbriquée
```

## Code

### Code en ligne
```markdown
`code en ligne`
```

### Bloc de code
````markdown
```javascript
function hello() {
    console.log("Hello, World!");
}
```
````

## Tableaux

```markdown
| En-tête 1 | En-tête 2 | En-tête 3 |
|-----------|:---------:|-----------:|
| Gauche    | Centré    | Droite     |
| Texte     | Texte     | Texte      |
```

## Ligne horizontale

```markdown
---
***
___
```

## Cases à cocher

```markdown
- [ ] Tâche non complétée
- [x] Tâche complétée
```

## Fonctionnalités Avancées

### Définitions
```markdown
Terme
: Définition du terme
: Autre définition

HTML
: HyperText Markup Language
: Langage de balisage pour le web
```

### Notes de bas de page
```markdown
Voici une phrase avec une note[^1].
Et une autre avec une note nommée[^note].

[^1]: Contenu de la première note
[^note]: Contenu de la note nommée
```

### Identifiants personnalisés pour titres
```markdown
### Mon titre {#mon-id-personnalise}
[Lien vers le titre](#mon-id-personnalise)
```

### Surlignage de texte (GitHub Flavored Markdown)
```markdown
Je veux ==mettre en évidence== ce texte
```

### Abréviations
```markdown
*[HTML]: HyperText Markup Language
*[W3C]: World Wide Web Consortium

Le HTML est standardisé par le W3C.
```

### Listes de définitions
```markdown
Terme 1
: Définition 1
: Définition 2

Terme 2
: Définition
```

### Diagrammes avec Mermaid (supporté par GitHub)
````markdown
```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```
````
```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```

### Emojis
```markdown
:smile: :heart: :thumbsup:
😄 ❤️ 👍
```

### Touches de clavier
```markdown
Appuyez sur <kbd>Ctrl</kbd> + <kbd>C</kbd> pour copier
```

### Détails dépliables (supporté par GitHub)
```markdown
<details>
<summary>Cliquez pour voir plus</summary>

Contenu caché qui apparaît lors du clic !
</details>
```

### Coloration syntaxique avec indication de lignes
````markdown
```javascript {.line-numbers}
function exemple() {
  let x = 1;
  let y = 2;
  return x + y;
}
```
````

### Tableaux avec alignement et formatage
```markdown
| Gauche | Centre | Droite | Formaté |
|:-------|:------:|-------:|---------|
| A1 | B1 | C1 | **Gras** |
| A2 | *B2* | C2 | ~~Barré~~ |
```

### Liens avec références
```markdown
[Site web][1]
[Autre lien][site]

[1]: https://example.com
[site]: https://example.org "Titre optionnel"
```

### Commentaires cachés
```markdown
[//]: # (Ce commentaire ne sera pas visible dans le rendu)
[//]: # "Autre façon d'écrire un commentaire"
```

### Échappement de caractères spéciaux
```markdown
\* Texte avec astérisque \*
\` Code \`
\# Pas un titre
\[ Pas un lien \]
``` 