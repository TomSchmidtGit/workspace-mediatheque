# Guide Docker - Workspace Parent Médiathèque

## 🏗️ Architecture Workspace Parent

Ce workspace parent agit comme un **orchestrateur centralisé** qui coordonne vos deux repos :
- `backend-mediatheque/` (repo séparé)
- `frontend-mediatheque/` (repo séparé)

## 📁 Structure du Workspace

```
PFE/ (workspace parent)
├── .dockerignore              # Exclusion globale des fichiers
├── docker-compose.yml         # Orchestration des 3 services
├── .env                       # Variables d'environnement
├── env.example                # Template des variables
├── mongo-init.js             # Initialisation MongoDB
├── Makefile                   # Commandes simplifiées
├── scripts/                   # Scripts utilitaires
│   ├── setup.sh              # Configuration initiale
│   ├── dev.sh                # Lancement développement
│   ├── prod.sh               # Lancement production
│   └── clean.sh              # Nettoyage
├── backend-mediatheque/      # Repo backend
│   └── Dockerfile            # Build backend
└── frontend-mediatheque/     # Repo frontend
    ├── Dockerfile            # Build frontend
    └── nginx.conf            # Configuration nginx
```

## 🚀 Démarrage Rapide

### 1. Configuration Initiale

```bash
# Dans le workspace parent PFE/
make setup
# ou
./scripts/setup.sh
```

### 2. Éditer les Variables d'Environnement

```bash
nano .env
# Configurez vos vraies valeurs (voir env.example)
```

### 3. Lancement

```bash
# Mode développement
make dev
# ou
./scripts/dev.sh

# Mode production
make prod
# ou
./scripts/prod.sh
```

## 🛠️ Commandes Make (Recommandées)

```bash
# Aide
make help

# Configuration
make setup          # Configuration initiale
make build          # Construction des images

# Lancement
make dev            # Mode développement
make prod           # Mode production

# Gestion
make status         # Statut des services
make logs           # Affichage des logs
make clean          # Nettoyage
make rebuild        # Reconstruction complète

# Utilitaires
make shell-backend  # Shell dans le backend
make shell-frontend # Shell dans le frontend
make shell-mongodb  # Shell dans MongoDB
make check          # Vérification de l'environnement
```

## 📋 Scripts Disponibles

### `setup.sh` - Configuration Initiale
- Vérifie Docker et Docker Compose
- Vérifie la présence des repos
- Crée le fichier `.env`
- Configure les permissions

### `dev.sh` - Mode Développement
- Lance tous les services en mode dev
- Affiche les logs en temps réel
- Ports : Backend (5001), Frontend (3000), MongoDB (27017)

### `prod.sh` - Mode Production
- Lance tous les services en mode production
- Services en arrière-plan
- Vérification du statut

### `clean.sh` - Nettoyage
- Arrête tous les services
- Nettoie les ressources Docker
- Option `--volumes` pour supprimer les données

## 🌐 Ports et URLs

| Service | Port | URL | Description |
|---------|------|-----|-------------|
| **Backend** | 5001 | http://localhost:5001 | API REST + Swagger |
| **Frontend** | 3000 | http://localhost:3000 | Interface utilisateur |
| **MongoDB** | 27017 | localhost:27017 | Base de données |

## 🔧 Variables d'Environnement

### Configuration Générale
```bash
NODE_ENV=production          # development ou production
BACKEND_PORT=5001            # Port du backend
FRONTEND_PORT=3000           # Port du frontend
```

### MongoDB
```bash
MONGO_ROOT_USERNAME=admin    # Utilisateur root MongoDB
MONGO_ROOT_PASSWORD=password # Mot de passe root
MONGO_DATABASE=mediatheque   # Nom de la base
MONGO_URI=mongodb://...      # URI de connexion
```

### Sécurité
```bash
JWT_SECRET=your-secret       # Clé JWT
JWT_REFRESH_SECRET=refresh   # Clé refresh JWT
```

### Services Externes
```bash
CLOUDINARY_CLOUD_NAME=name   # Cloudinary
CLOUDINARY_API_KEY=key       # API Key Cloudinary
CLOUDINARY_API_SECRET=secret # Secret Cloudinary
MAIL_USER=email@example.com  # Email notifications
MAIL_PASS=password           # Mot de passe email
```

### URLs
```bash
FRONTEND_URL=http://localhost:3000  # URL frontend
VITE_API_URL=http://localhost:5001/api # URL API
```

## 🔄 Workflow de Développement

### 1. **Première Utilisation**
```bash
make setup                    # Configuration initiale
nano .env                     # Éditer les variables
make dev                      # Lancer en dev
```

### 2. **Développement Quotidien**
```bash
make dev                      # Lancer l'environnement
# ... développement ...
make clean                    # Arrêter et nettoyer
```

### 3. **Déploiement Production**
```bash
make prod                     # Lancer en production
make status                   # Vérifier le statut
make logs                     # Surveiller les logs
```

## 🐛 Dépannage

### Problèmes Courants

1. **Ports déjà utilisés**
   ```bash
   make clean                 # Arrêter les services
   # Vérifier qu'aucun service n'utilise 27017, 5001, 3000
   ```

2. **Variables d'environnement manquantes**
   ```bash
   make check                 # Vérifier l'environnement
   nano .env                  # Éditer les variables
   ```

3. **Images Docker corrompues**
   ```bash
   make rebuild               # Reconstruction complète
   ```

### Commandes de Diagnostic

```bash
make check                   # Vérification générale
make status                  # Statut des services
make logs                    # Logs en temps réel
docker-compose ps            # Statut détaillé
docker-compose logs [service] # Logs d'un service spécifique
```

## 📚 Avantages du Workspace Parent

✅ **Orchestration centralisée** - Un seul point de contrôle  
✅ **Repos indépendants** - Chaque repo reste autonome  
✅ **Configuration unifiée** - Variables d'environnement centralisées  
✅ **Déploiement simplifié** - Une seule commande pour tout  
✅ **Maintenance facilitée** - Scripts et Makefile centralisés  
✅ **Équipes séparées** - Chaque équipe peut travailler sur son repo  

## 🔗 Intégration avec Git

### Option 1 : Workspace Simple
```bash
# Cloner les repos dans le workspace
git clone <backend-repo> backend-mediatheque/
git clone <frontend-repo> frontend-mediatheque/
```

### Option 2 : Git Submodules (Recommandé)
```bash
# Ajouter les repos comme submodules
git submodule add <backend-repo> backend-mediatheque
git submodule add <frontend-repo> frontend-mediatheque

# Mettre à jour les submodules
git submodule update --init --recursive
```

## 🚀 Prochaines Étapes

1. **Exécuter** `make setup` pour la configuration initiale
2. **Éditer** le fichier `.env` avec vos vraies valeurs
3. **Lancer** `make dev` pour commencer le développement
4. **Consulter** `make help` pour toutes les commandes disponibles

---

💡 **Astuce** : Utilisez `make help` pour voir toutes les commandes disponibles !
