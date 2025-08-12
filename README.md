# 🚀 Workspace Parent Médiathèque

Ce workspace permet de gérer et lancer facilement votre projet médiathèque complet avec Docker, incluant le backend Node.js et le frontend React. **Configuration optimisée pour le développement avec MongoDB Atlas.**

## 📁 Structure du projet

**Structure des repos :**
```
├── backend-mediatheque/     # Repo backend (Node.js/Express) → MongoDB Atlas
├── frontend-mediatheque/    # Repo frontend (React/Vite)
└── workspace-mediatheque/   # Repo workspace (ce repo)
```

**Structure du workspace :**
```
workspace-mediatheque/
├── backend-mediatheque -> ../backend-mediatheque    # Lien symbolique
├── frontend-mediatheque -> ../frontend-mediatheque  # Lien symbolique
├── .env                     # Configuration Docker (ports, URLs)
├── docker-compose.yml       # Orchestration des services
├── Makefile                 # Commandes de gestion optimisées
└── scripts/                 # Scripts d'automatisation
```

## 🛠️ Prérequis

- Docker et Docker Compose installés
- Les repos `backend-mediatheque` et `frontend-mediatheque` clonés **au même niveau** que ce workspace
- Configuration backend avec MongoDB Atlas (JWT, Cloudinary, etc.)

## 🚀 Démarrage rapide

### 1. Configuration initiale
```bash
make setup
# ou
./scripts/setup.sh
```

### 2. Lancer en mode développement
```bash
make dev
# ou
./scripts/dev.sh
```

**C'est tout !** Votre application est maintenant accessible.

## 🌐 Accès aux services

- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:5001
- **MongoDB**: Atlas (externe, pas de base locale)

## 📋 Commandes disponibles

```bash
# 🚀 Lancement
make dev           # Mode développement
make prod          # Mode production (pour tests locaux)

# 🔧 Gestion
make status        # Statut des services
make logs          # Logs de tous les services
make logs-backend  # Logs du backend uniquement
make logs-frontend # Logs du frontend uniquement

# 🏗️ Construction
make build         # Construction des images
make rebuild       # Reconstruction complète

# 🧹 Nettoyage
make clean         # Nettoyage et arrêt
make clean-smart   # Nettoyage intelligent avec prune

# 🔍 Diagnostic
make check         # Vérification de l'environnement
make quick-check   # Vérification rapide Docker Compose

# 🐚 Accès aux conteneurs
make shell-backend # Connexion au backend
make shell-frontend # Connexion au frontend

# 📚 Aide
make help          # Affiche cette aide
```

## 🔧 Configuration

### Variables d'environnement (workspace-mediatheque/.env)

```bash
# Configuration Docker
NODE_ENV=development
BACKEND_PORT=5001
FRONTEND_PORT=3000

# URLs de connexion
FRONTEND_URL=http://localhost:3000
VITE_API_URL=http://localhost:5001/api
```

### Configuration des repos

- **Backend** : `backend-mediatheque/.env` → MongoDB Atlas, JWT, Cloudinary, Email
- **Frontend** : `frontend-mediatheque/.env` → API URL

## 🐳 Architecture Docker

- **Backend**: Node.js 18 Alpine, mode développement avec nodemon
- **Frontend**: Node.js 20 Alpine, mode développement avec Vite
- **Base de données**: MongoDB Atlas (externe, pas de conteneur local)
- **Réseau**: Bridge Docker dédié
- **Volumes**: Montage des .env et logs

## 🎯 Avantages de cette configuration

- ✅ **Données persistantes** : MongoDB Atlas (pas de perte de données)
- ✅ **Configuration partagée** : .env versionné pour l'équipe
- ✅ **Démarrage immédiat** : Pas de configuration manuelle
- ✅ **Développement optimisé** : Hot-reload et logs en temps réel
- ✅ **Sécurité** : Secrets dans les repos individuels, pas dans le workspace

## 🆘 Dépannage

### Problèmes courants

1. **Ports déjà utilisés**: Vérifiez qu'aucun service n'utilise les ports 3000, 5001
2. **Permissions Docker**: Assurez-vous d'avoir les droits pour exécuter Docker
3. **Connexion MongoDB**: Vérifiez votre configuration Atlas dans `backend-mediatheque/.env`

### Commandes de diagnostic

```bash
make check          # Vérification complète de l'environnement
make quick-check    # Vérification rapide Docker Compose
make status         # Statut des services
make logs           # Logs en temps réel
```

### Vérifications rapides

```bash
# Vérifier la configuration Docker
make quick-check

# Vérifier les logs d'un service
make logs-backend
make logs-frontend

# Vérifier le statut
make status
```

## 🤝 Contribution

1. **Clonez ce workspace**
   ```bash
   git clone <votre-repo-workspace>
   cd workspace-mediatheque
   ```

2. **Créez les liens vers vos repos**
   ```bash
   ln -sf ../backend-mediatheque ./backend-mediatheque
   ln -sf ../frontend-mediatheque ./frontend-mediatheque
   ```

3. **Lancez l'environnement**
   ```bash
   make setup
   make dev
   ```

4. **C'est parti !** 🎉

## 📚 Documentation

- **Makefile** : Commandes disponibles et leur utilisation
- **scripts/** : Scripts d'automatisation
- **docker-compose.yml** : Configuration des services

## 📄 Licence

Ce projet est sous licence ISC.
