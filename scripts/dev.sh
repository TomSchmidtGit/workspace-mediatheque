#!/bin/bash

# Script de lancement en mode développement
# Usage: ./scripts/dev.sh

set -e

echo "🔧 Lancement de l'environnement de développement..."

# Vérifier que le fichier .env existe
if [ ! -f ".env" ]; then
    echo "❌ Le fichier .env n'existe pas"
    echo "   Exécutez d'abord : ./scripts/setup.sh"
    exit 1
fi

# Charger les variables d'environnement
export NODE_ENV=development

echo "📡 Mode: Développement"
echo "🌐 Backend: http://localhost:5001"
echo "🎨 Frontend: http://localhost:3000"
echo "🗄️  MongoDB: localhost:27017"
echo ""

# Arrêter les services existants s'ils tournent
echo "🛑 Arrêt des services existants..."
docker-compose down 2>/dev/null || true

# Nettoyer les images obsolètes
echo "🧹 Nettoyage des images obsolètes..."
docker system prune -f

# Lancer les services en mode développement
echo "🚀 Lancement des services..."
docker-compose up --build

echo ""
echo "✅ Environnement de développement lancé !"
echo "📱 Frontend: http://localhost:3000"
echo "🔌 API: http://localhost:5001"
echo "📊 MongoDB: localhost:27017"
echo ""
echo "🛑 Pour arrêter: Ctrl+C ou docker-compose down"
