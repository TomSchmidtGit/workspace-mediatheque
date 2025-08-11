#!/bin/bash

# Script de lancement en mode production
# Usage: ./scripts/prod.sh

set -e

echo "🚀 Lancement de l'environnement de production..."

# Vérifier que le fichier .env existe
if [ ! -f ".env" ]; then
    echo "❌ Le fichier .env n'existe pas"
    echo "   Exécutez d'abord : ./scripts/setup.sh"
    exit 1
fi

# Charger les variables d'environnement
export NODE_ENV=production

echo "📡 Mode: Production"
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

# Lancer les services en mode production
echo "🚀 Lancement des services..."
docker-compose up --build -d

# Attendre que les services soient prêts
echo "⏳ Attente du démarrage des services..."
sleep 10

# Vérifier le statut des services
echo "📊 Statut des services :"
docker-compose ps

echo ""
echo "✅ Environnement de production lancé !"
echo "📱 Frontend: http://localhost:3000"
echo "🔌 API: http://localhost:5001"
echo "📊 MongoDB: localhost:27017"
echo ""
echo "📋 Commandes utiles :"
echo "   Voir les logs: docker-compose logs -f"
echo "   Arrêter: docker-compose down"
echo "   Redémarrer: docker-compose restart"
