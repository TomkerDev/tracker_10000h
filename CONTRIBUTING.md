# 🤝 Guide de contribution

Merci de votre intérêt pour **Tracker 10000h** ! Nous accueillons toutes les contributions, qu'il s'agisse de corrections de bugs, d'améliorations de fonctionnalités ou de suggestions.

---

## 📋 Table des matières

1. [Code de conduite](#code-de-conduite)
2. [Commencer](#commencer)
3. [Workflow de contribution](#workflow-de-contribution)
4. [Conventions de code](#conventions-de-code)
5. [Conventions de commits](#conventions-de-commits)
6. [Structure des branches](#structure-des-branches)
7. [Tests](#tests)
8. [Processus de review](#processus-de-review)
9. [Signaler un bug](#signaler-un-bug)
10. [Suggérer une amélioration](#suggérer-une-amélioration)

---

## Code de conduite

En participant à ce projet, vous vous engagez à maintenir un environnement respectueux et inclusif. Voici quelques règles simples :

- **Soyez respectueux** — Les désaccords sont normaux, restez constructif.
- **Acceptez les critiques** — Les retours sur le code font partie du processus d'apprentissage.
- **Concentrez-vous sur l'essentiel** — Ce qui est le mieux pour le projet et la communauté.
- **Faites preuve d'empathie** — Tout le monde a un niveau différent, soyez bienveillant.

---

## Commencer

### 1. Fork et clone

```bash
# Forkez le projet sur GitHub, puis clonez votre fork
git clone https://github.com/VOTRE_PSEUDO/tracker_10000h.git
cd tracker_10000h

# Ajoutez le dépôt officiel comme remote upstream (s'il n'existe pas déjà)
git remote add upstream https://github.com/TomkerDev/tracker_10000h.git 2>/dev/null || echo "upstream déjà configuré"
```

### 2. Installez les dépendances

```bash
flutter pub get
```

### 3. Créez une branche

```bash
git checkout -b feat/ma-nouvelle-fonctionnalite
```

Voir [Structure des branches](#structure-des-branches) pour les conventions de nommage.

---

## Workflow de contribution

```
1. Choisissez une tâche ──> 2. Créez une branche ──> 3. Codez ──> 4. Testez
                                                        │
                        6. Merge / Clôture <── 5. Pull Request <──┘
```

### Étapes détaillées

1. **Choisissez une tâche** — Parcourez les [issues](https://github.com/TomkerDev/tracker_10000h/issues) ouvertes ou créez-en une nouvelle.
2. **Créez une branche** — Suivez la convention de nommage décrite plus bas.
3. **Codez** — Respectez les conventions de code et les bonnes pratiques Flutter/Dart.
4. **Testez** — Vérifiez que tout fonctionne et que les tests passent.
5. **Ouvrez une Pull Request** — Vers la branche `main` avec une description claire.
6. **Review** — Un mainteneur examinera votre code. Soyez réactif aux retours.

---

## Conventions de code

### Dart / Flutter

Ce projet suit les conventions officielles de Dart et Flutter :

- **Style** : Suivez le [style guide officiel Dart](https://dart.dev/guides/language/effective-dart/style)
- **Formatage** : Utilisez `dart format` avant chaque commit
- **Lint** : Respectez les règles définies dans `analysis_options.yaml`

```bash
# Vérifier le lint
flutter analyze

# Formater le code
dart format .
```

### Règles spécifiques

| Règle | Exemple ✅ | Exemple ❌ |
|---|---|---|
| Nommage des fichiers | `snake_case.dart` | `camelCase.dart` |
| Classes et types | `PascalCase` | `pascal_case` |
| Variables et fonctions | `camelCase` | `snake_case` |
| Constantes | `camelCase` | `UPPER_CASE` |
| Imports | Ordre : dart, flutter, packages, projet | Désordonné |

### Architecture

- **Provider** pour la gestion d'état
- **Separation of concerns** : UI / Logique / Données
- **Ne pas mélanger** la logique métier dans les widgets

```
lib/
├── core/        # Configuration partagée
├── logic/       # Providers (état + logique métier)
├── models/      # Modèles de données
├── services/    # Services (API, stockage, etc.)
└── ui/          # Widgets et écrans
```

---

## Conventions de commits

Nous utilisons [Conventional Commits](https://www.conventionalcommits.org/) pour structurer les messages de commit.

### Format

```
<type>(<scope>): <description>

[corps optionnel]

[pied optionnel]
```

### Types

| Type | Utilisation |
|---|---|
| `feat` | Nouvelle fonctionnalité |
| `fix` | Correction de bug |
| `docs` | Documentation uniquement |
| `style` | Formatage, espaces, virgules manquantes (pas de changement de code) |
| `refactor` | Refactorisation de code (ni feature ni fix) |
| `perf` | Amélioration de performance |
| `test` | Ajout ou correction de tests |
| `chore` | Tâches diverses (dépendances, config build, etc.) |
| `ci` | Configuration CI/CD |

### Exemples

```
feat(timer): add pause button with animation
fix(session): correct total hours calculation
docs(readme): update installation instructions
refactor(provider): extract level logic into dedicated class
test(chart): add widget test for activity chart
```

### Règles

- Utilisez l'impératif ("add" pas "added" ni "adds")
- Pas de point final dans le titre
- Gardez le titre en minuscules
- 50 caractères max pour le titre, 72 pour le corps

---

## Structure des branches

```
main          ────── Branche principale (production)
  │
  ├── feat/ma-fonctionnalite     ─── Nouvelle fonctionnalité
  ├── fix/correction-bug         ─── Correction de bug
  ├── docs/ajout-documentation   ─── Documentation
  ├── refactor/nettoyage         ─── Refactorisation
  ├── test/ajout-tests           ─── Tests
  └── chore/mise-a-jour          ─── Tâches diverses
```

### Conventions

- Utilisez des préfixes : `feat/`, `fix/`, `docs/`, `refactor/`, `test/`, `chore/`
- Utilisez le kebab-case : `feat/dark-mode-toggle`
- Gardez les noms courts mais descriptifs

---

## Tests

### Exécuter les tests

```bash
# Tous les tests
flutter test

# Un fichier spécifique
flutter test test/widget_test.dart

# Avec couverture
flutter test --coverage
```

### Règles

- **Toute nouvelle fonctionnalité** doit être accompagnée de tests
- **Toute correction de bug** doit d'abord reproduire le bug via un test
- Maintenez une couverture de code > 70%

### Types de tests attendus

1. **Widget tests** — Testent le rendu et les interactions UI
2. **Unit tests** — Testent la logique métier (providers, services, modèles)
3. **Integration tests** — Testent les flows complets (optionnel pour les petites contributions)

---

## Processus de review

### Pour l'auteur de la PR

- Assurez-vous que tous les tests passent (CI verte)
- Ajoutez une description claire : _quoi_, _pourquoi_, _comment_
- Liez l'issue concernée : `Closes #42`
- Gardez les PR petites (< 400 lignes idéalement)
- Répondez aux commentaires rapidement

### Pour le reviewer

- Vérifiez la logique métier et les edge cases
- Assurez-vous que les conventions de code sont respectées
- Testez la fonctionnalité en local si nécessaire
- Restez constructif et bienveillant dans vos commentaires

### Checklist de review

- [ ] Le code suit les conventions de style
- [ ] Les tests passent
- [ ] La documentation est à jour
- [ ] Les noms de variables/fonctions sont explicites
- [ ] Pas de code mort ou commenté
- [ ] Les messages de commit sont propres

---

## Signaler un bug

Avant d'ouvrir une issue, vérifiez que le bug n'a pas déjà été signalé.

### Template de bug report

```
**Description**
[Description claire et concise du bug]

**Étapes pour reproduire**
1. Aller sur l'écran '...'
2. Cliquer sur '...'
3. Constater l'erreur

**Comportement attendu**
[Ce qui devrait se passer]

**Captures d'écran**
[Si applicable]

**Environnement**
- Appareil : [ex: Pixel 7]
- OS : [ex: Android 14]
- Version de l'app : [ex: 1.0.0]

**Contexte supplémentaire**
[Tout autre élément pertinent]
```

---

## Suggérer une amélioration

Les suggestions sont les bienvenues ! Ouvrez une issue avec le label `enhancement`.

### Template de feature request

```
**Problème rencontré**
[Décrivez le problème ou le besoin]

**Solution souhaitée**
[Ce que vous voudriez voir implémenté]

**Alternatives considérées**
[Autres solutions envisagées]

**Contexte supplémentaire**
[Maquettes, références, etc.]
```

---

## 📝 Rappel

> **La perfection est atteinte, non pas lorsqu'il n'y a plus rien à ajouter, mais lorsqu'il n'y a plus rien à retirer.**
> — Antoine de Saint-Exupéry

Merci de contribuer à faire de **Tracker 10000h** un outil toujours meilleur ! 🚀