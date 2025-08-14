# 🏛️ Workspace Médiathèque

Workspace parent simple pour orchestrer le frontend et backend de la médiathèque avec Docker.

## 🎯 Objectif

Ce workspace sert de **pont Docker** entre vos deux projets :
- **Frontend** : Application React/TypeScript
- **Backend** : API Node.js/Express

Il permet de lancer l'ensemble avec une seule commande Docker Compose.

## 📁 Structure

```
workspace-mediatheque/
├── 📁 backend-mediatheque/        # Votre repo backend
├── 📁 frontend-mediatheque/       # Votre repo frontend
├── 📁 scripts/                    # Scripts de gestion
├── docker-compose.yml             # Orchestration Docker
├── Makefile                       # Commandes simplifiées
└── package.json                   # Scripts workspace
```

## ⚙️ Prérequis

- **Docker** et **Docker Compose** installés
- Les repos `backend-mediatheque` et `frontend-mediatheque` clonés **au même niveau**
- Configuration des variables d'environnement dans chaque repo individuel

## 🚀 Démarrage rapide

### 1. Vérifier la structure
```bash
# Vérifier que les repos sont présents
ls -la
# Doit afficher : backend-mediatheque/ et frontend-mediatheque/
```

### 2. Lancer les services
```bash
# Démarrage simple
make dev

# Ou avec npm
npm run dev
```

### 3. Accéder aux services
- **Frontend** : http://localhost:3000
- **Backend API** : http://localhost:5001

## 🔧 Commandes disponibles

### 🚀 Démarrage et arrêt
```bash
make dev          # Démarrage développement
make prod         # Démarrage production
make stop         # Arrêt des services
make status       # Statut des services
```

### 📊 Monitoring
```bash
make logs         # Logs en temps réel
make logs-backend # Logs backend uniquement
make logs-frontend # Logs frontend uniquement
```

### 🧹 Maintenance
```bash
make clean        # Nettoyage complet
make rebuild      # Reconstruction des images
make check        # Vérification de l'environnement
```

### 🐳 Docker avancé
```bash
make shell-backend  # Connexion au backend
make shell-frontend # Connexion au frontend
```

## 📋 Scripts npm

```bash
# Développement
npm run dev              # Démarrage Docker
npm run dev:down         # Arrêt des services
npm run dev:logs         # Affichage des logs
npm run dev:rebuild      # Reconstruction

# Tests (exécutés dans chaque repo)
npm run test             # Tests frontend + backend
npm run test:frontend    # Tests frontend uniquement
npm run test:backend     # Tests backend uniquement

# Qualité du code
npm run lint             # Linting global
npm run format           # Formatage global
npm run ci               # CI complète
```

## 🐳 Configuration Docker

### Services orchestrés
- **Backend** : Port 5001, mode développement avec nodemon
- **Frontend** : Port 3000, mode production avec Nginx

### Volumes montés
- **Backend** : Logs et fichier `.env`
- **Frontend** : Code source et fichier `.env`

## ⚠️ Important

### Configuration des variables d'environnement
- **Ne pas créer** de fichier `.env` dans ce workspace
- Les variables sont gérées dans chaque repo individuel :
  - `backend-mediatheque/.env`
  - `frontend-mediatheque/.env`

### Dépendances
- Ce workspace n'installe **aucune dépendance** des projets
- Chaque repo gère ses propres `node_modules`
- Utilisez `npm run install:all` pour installer tout

## 🔍 Dépannage

### Services qui ne démarrent pas
```bash
# Vérifier l'environnement
make check

# Vérifier les logs
make logs

# Redémarrer complètement
make dev:rebuild
```

### Problèmes de ports
```bash
# Vérifier les ports utilisés
lsof -i :3000
lsof -i :5001

# Arrêter et relancer
make stop
make dev
```

### Vérification complète
```bash
# Diagnostic automatique
./scripts/check.sh

# Statut des services
make status
```

## 🤝 Contribution

1. **Fork** du repository
2. **Clone** avec les repos frontend/backend
3. **Développement** dans chaque repo individuel
4. **Test** avec `make dev` et `make test`
5. **Pull Request** sur ce workspace

---

**Simple pont Docker entre vos projets médiathèque** 🚀