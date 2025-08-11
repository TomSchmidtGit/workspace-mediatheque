# Workspace Médiathèque

Projet complet de gestion de médiathèque avec architecture backend/frontend séparée.

## 🏗️ Architecture

```
workspace-mediatheque/
├── backend-mediatheque/     # API Node.js/Express
├── frontend-mediatheque/    # Application React/TypeScript
├── docker-compose.yml       # Orchestration des services
└── README.md               # Ce fichier
```

## 🚀 Services

- **Backend** : API REST sur le port 5001
- **Frontend** : Interface utilisateur sur le port 3000
- **MongoDB** : Base de données sur le port 27017

## 🛠️ Technologies

### Backend
- Node.js + Express
- MongoDB avec Mongoose
- JWT pour l'authentification
- Cloudinary pour la gestion des médias
- Nodemailer pour les emails

### Frontend
- React 19 + TypeScript
- Vite 7 pour le build
- Tailwind CSS pour le styling
- React Query pour la gestion d'état
- React Router pour la navigation

## 🐳 Démarrage rapide

### Prérequis
- Docker et Docker Compose
- Variables d'environnement configurées (voir `env.example`)

### Commandes
```bash
# Démarrer tous les services
make dev

# Ou avec Docker Compose
docker-compose up -d

# Arrêter tous les services
docker-compose down

# Reconstruire les images
docker-compose build --no-cache
```

## 📁 Structure des dossiers

### Backend (`backend-mediatheque/`)
- `controllers/` : Logique métier
- `models/` : Modèles Mongoose
- `routes/` : Définition des endpoints
- `middlewares/` : Middlewares Express
- `utils/` : Utilitaires et templates d'emails

### Frontend (`frontend-mediatheque/`)
- `components/` : Composants React réutilisables
- `pages/` : Pages de l'application
- `services/` : Appels API et logique métier
- `types/` : Définitions TypeScript
- `utils/` : Fonctions utilitaires

## 🔧 Configuration

Copiez `env.example` vers `.env` et configurez :
- Variables MongoDB
- Clés JWT
- Configuration Cloudinary
- Paramètres d'email

## 📚 Fonctionnalités

- Gestion des utilisateurs et authentification
- Catalogue de médias (livres, films, etc.)
- Système d'emprunts et de retours
- Notifications par email
- Interface d'administration
- Recherche et filtrage avancés

## 🧪 Tests

```bash
# Backend
cd backend-mediatheque
npm test

# Frontend
cd frontend-mediatheque
npm test
```

## 📝 Déploiement

Le projet inclut des configurations Docker pour :
- Développement local
- Production avec Nginx
- Base de données MongoDB

## 🤝 Contribution

1. Fork le projet
2. Créez une branche feature
3. Committez vos changements
4. Poussez vers la branche
5. Ouvrez une Pull Request

## 📄 Licence

Ce projet est sous licence MIT.
