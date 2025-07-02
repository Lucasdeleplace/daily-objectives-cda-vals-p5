# Objectifs journaliers

## Mardi 24/06/2025 :

### Les Tests Unitaires (TU)
- [X] Comprendre l'objectif des tests unitaires : tester la plus petite partie de code (une fonction, une méthode) de manière isolée.
- [X] Savoir comment "mocker" (simuler) les dépendances externes (BDD, API, etc.) pour garantir l'isolation.
- [X] Écrire des assertions pertinentes pour valider le comportement attendu.

### Mise en pratique par technologie
- [X] **Pour tous :** Écrire des tests unitaires pour une fonction pure (ex: une fonction de calcul simple).

- [ ] **Java (avec JUnit) :**
  - [ ] Configurer JUnit dans un projet Maven ou Gradle.
  - [ ] Utiliser les annotations `@Test`, `@BeforeEach`, `@AfterEach`.
  - [ ] Utiliser une librairie de mock (ex: Mockito) pour simuler des dépendances.
  - [ ] Écrire des assertions avec AssertJ ou les assertions de JUnit.

- [ ] **C# (avec xUnit ou NUnit) :**
  - [ ] Configurer un projet de test dans une solution .NET.
  - [ ] Utiliser les attributs `[Fact]` ou `[Test]`.
  - [ ] Utiliser une librairie de mock (ex: Moq) pour simuler des dépendances.
  - [ ] Écrire des assertions avec FluentAssertions ou les assertions natives.

- [ ] **PHP (avec PHPUnit) :**
  - [ ] Configurer PHPUnit pour un projet (via `phpunit.xml`).
  - [ ] Étendre la classe `TestCase`.
  - [ ] Créer des mocks avec `createMock()` ou Prophecy.
  - [ ] Écrire des assertions (ex: `assertEquals`, `assertTrue`).

- [x] **TypeScript (avec Jest ou Vitest) :**
  - [x] Configurer Jest ou Vitest dans un projet Node.js/frontend.
  - [x] Utiliser les fonctions `describe`, `it` (ou `test`).
  - [x] Simuler des modules ou des fonctions avec `jest.mock()` ou `vi.mock()`.
  - [x] Écrire des assertions avec `expect()`. 