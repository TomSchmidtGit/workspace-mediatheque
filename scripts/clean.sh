#!/bin/bash

# Script de nettoyage et arrêt des services
# Usage: ./scripts/clean.sh

echo "🧹 Nettoyage de l'environnement médiathèque..."

# Arrêter tous les services
echo "🛑 Arrêt des services..."
docker-compose down

# Supprimer les volumes (optionnel)
if [ "$1" = "--volumes" ] || [ "$1" = "-v" ]; then
    echo "🗑️  Suppression des volumes..."
    docker-compose down -v
    echo "⚠️  Toutes les données MongoDB ont été supprimées !"
fi

# Nettoyer les images non utilisées
echo "🧹 Nettoyage des images Docker..."
docker image prune -f

# Nettoyer les conteneurs arrêtés
echo "🧹 Nettoyage des conteneurs arrêtés..."
docker container prune -f

# Nettoyer les réseaux non utilisés
echo "🧹 Nettoyage des réseaux non utilisés..."
docker network prune -f

echo ""
echo "✅ Nettoyage terminé !"
echo ""
echo "📋 Pour relancer :"
echo "   Développement: ./scripts/dev.sh"
echo "   Production: ./scripts/prod.sh"
