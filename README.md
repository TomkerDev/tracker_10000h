# 🎯 Tracker 10000h

> **Atteignez la maîtrise en suivant vos 10 000 heures de pratique.**

Tracker 10000h est une application Flutter conçue pour vous aider à suivre votre progression vers l'excellence. Inspirée par la règle des 10 000 heures popularisée par Malcolm Gladwell, cette application vous permet d'enregistrer vos sessions de pratique, de visualiser votre progression et de rester motivé grâce à un système de niveaux.

---

## ✨ Fonctionnalités

| Fonctionnalité | Description |
|---|---|
| ⏱️ **Chronomètre intelligent** | Lancez un chrono par catégorie (Flutter, Dart, Design, Firebase, Algo) |
| 📊 **Tableau de bord** | Visualisez vos heures totales, votre niveau et votre progression |
| 🏆 **Système de niveaux** | 6 rangs de Novice à Légende pour gamifier votre apprentissage |
| 📈 **Graphique d'activité** | Suivez vos 7 derniers jours d'activité |
| 📝 **Journal de bord** | Consultez et gérez l'historique de vos sessions |
| 🌓 **Thème sombre/clair** | Basculez entre les modes selon votre préférence |
| 💾 **Stockage local** | Vos données sont sauvegardées automatiquement sur votre appareil |

### 🏅 Système de niveaux

| Niveau | Icône | Heures requises |
|---|---|---|
| Novice | 🔰 | 0 h |
| Apprenti | 🔨 | 500 h |
| Compagnon | ⚔️ | 1 500 h |
| Expert | 🏆 | 3 000 h |
| Maître | 💎 | 6 000 h |
| Légende | 👑 | 9 000 h |

---

## 🚀 Pour commencer

### Prérequis

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.11.5 ou supérieure)
- [Dart SDK](https://dart.dev/get-dart) (version 3.11.5 ou supérieure)
- Un éditeur de code (VS Code, Android Studio, etc.)

### Installation

```bash
# 1. Clonez le dépôt
git clone https://github.com/TomkerDev/tracker_10000h.git

# 2. Accédez au répertoire
cd tracker_10000h

# 3. Installez les dépendances
flutter pub get

# 4. Lancez l'application
flutter run
```

### Build

```bash
# APK Android
flutter build apk

# iOS
flutter build ios

# Web
flutter build web

# Windows
flutter build windows

# Linux
flutter build linux

# macOS
flutter build macos
```

---

## 🏗️ Architecture du projet

```
lib/
├── main.dart                    # Point d'entrée de l'application
├── core/
│   └── theme.dart               # Configuration des thèmes
├── logic/
│   ├── session_provider.dart    # Gestion des sessions et niveaux
│   ├── timer_provider.dart      # Logique du chronomètre
│   └── settings_provider.dart   # Gestion des paramètres
├── models/
│   └── session.dart             # Modèle de données Session
├── services/
│   └── storage_service.dart     # Service de persistance locale
└── ui/
    ├── screens/
    │   ├── main_screen.dart     # Navigation principale (BottomNavigationBar)
    │   ├── home_screen.dart     # Tableau de bord
    │   ├── timer_screen.dart    # Écran chronomètre
    │   └── log_screen.dart      # Journal des sessions
    └── widgets/
        ├── progress_circle.dart # Cercle de progression custom paint
        └── activity_chart.dart  # Graphique d'activité hebdomadaire
```

### Stack technique

- **Framework** : Flutter (Material 3)
- **Langage** : Dart
- **State Management** : Provider
- **Stockage** : SharedPreferences
- **Graphiques** : fl_chart
- **Polices** : Google Fonts (Syne, DM Sans)
- **Dates** : intl

---

## 🧪 Tests

```bash
# Exécuter tous les tests
flutter test

# Avec couverture
flutter test --coverage
```

---

## 🤝 Contribution

Les contributions sont les bienvenues ! Consultez notre [guide de contribution](CONTRIBUTING.md) pour savoir comment participer.

---

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier [LICENSE](LICENSE) pour plus d'informations.

---

## 👤 Auteur

**TomkerDev** - [GitHub](https://github.com/TomkerDev)

---

<p align="center">
  <i>« Pour devenir vraiment bon dans quelque chose, il faut y consacrer 10 000 heures. »</i><br>
  <b>— Malcolm Gladwell</b>
</p>