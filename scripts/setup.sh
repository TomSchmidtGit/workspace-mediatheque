#!/bin/bash

# Script de configuration pour le workspace parent médiathèque
# Usage: ./scripts/setup.sh

set -e

echo "🚀 Configuration du workspace parent médiathèque..."

# Vérifier que Docker est installé
if ! command -v docker &> /dev/null; then
    echo "❌ Docker n'est pas installé. Veuillez l'installer d'abord."
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose n'est pas installé. Veuillez l'installer d'abord."
    exit 1
fi

echo "✅ Docker et Docker Compose sont installés"

# Vérifier que les repos sont présents
if [ ! -d "backend-mediatheque" ]; then
    echo "❌ Le dossier backend-mediatheque n'existe pas"
    echo "   Veuillez cloner le repo backend ou le placer ici"
    exit 1
fi

if [ ! -d "frontend-mediatheque" ]; then
    echo "❌ Le dossier frontend-mediatheque n'existe pas"
    echo "   Veuillez cloner le repo frontend ou le placer ici"
    exit 1
fi

echo "✅ Les repos backend et frontend sont présents"

# Créer le fichier .env s'il n'existe pas
if [ ! -f ".env" ]; then
    echo "📝 Création du fichier .env..."
    cp env.example .env
    echo "⚠️  Veuillez éditer le fichier .env avec vos vraies valeurs"
    echo "   nano .env"
else
    echo "✅ Le fichier .env existe déjà"
fi

# Vérifier les permissions des scripts
chmod +x scripts/*.sh

echo ""
echo "🎉 Configuration terminée !"
echo ""
echo "📋 Prochaines étapes :"
echo "   1. Éditer le fichier .env avec vos vraies valeurs"
echo "   2. Lancer en mode développement : ./scripts/dev.sh"
echo "   3. Lancer en mode production : ./scripts/prod.sh"
echo ""
echo "📚 Consultez README-Docker.md pour plus d'informations"
