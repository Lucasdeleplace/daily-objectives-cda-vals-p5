# Objectifs journaliers

## Mardi 24/06/2025 :

### Les Tests Unitaires (TU)
- [ ] Comprendre l'objectif des tests unitaires : tester la plus petite partie de code (une fonction, une méthode) de manière isolée.
- [ ] Savoir comment "mocker" (simuler) les dépendances externes (BDD, API, etc.) pour garantir l'isolation.
- [ ] Écrire des assertions pertinentes pour valider le comportement attendu.

### Mise en pratique par technologie
- [ ] **Pour tous :** Écrire des tests unitaires pour une fonction pure (ex: une fonction de calcul simple).

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

- [ ] **TypeScript (avec Jest ou Vitest) :**
  - [ ] Configurer Jest ou Vitest dans un projet Node.js/frontend.
  - [ ] Utiliser les fonctions `describe`, `it` (ou `test`).
  - [ ] Simuler des modules ou des fonctions avec `jest.mock()` ou `vi.mock()`.
  - [ ] Écrire des assertions avec `expect()`. 