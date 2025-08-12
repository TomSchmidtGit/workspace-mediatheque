#!/bin/bash

# Script de vérification de la configuration Docker
# Usage: ./scripts/check.sh

set -e

echo "🔍 Vérification de la configuration Docker..."

# Couleurs pour l'affichage
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Fonction pour afficher les résultats
print_status() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✅ $2${NC}"
    else
        echo -e "${RED}❌ $2${NC}"
        EXIT_CODE=1
    fi
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

EXIT_CODE=0

echo ""
echo "🐳 Vérification de Docker..."

# Vérifier Docker
if command -v docker &> /dev/null; then
    DOCKER_VERSION=$(docker --version)
    print_status 0 "Docker installé: $DOCKER_VERSION"
else
    print_status 1 "Docker non installé"
fi

# Vérifier Docker Compose
if command -v docker-compose &> /dev/null; then
    COMPOSE_VERSION=$(docker-compose --version)
    print_status 0 "Docker Compose installé: $COMPOSE_VERSION"
else
    print_status 1 "Docker Compose non installé"
fi

echo ""
echo "📁 Vérification des repos..."

# Vérifier le backend
if [ -d "backend-mediatheque" ]; then
    if [ -f "backend-mediatheque/Dockerfile" ]; then
        print_status 0 "Repo backend présent avec Dockerfile"
    else
        print_status 1 "Repo backend présent mais sans Dockerfile"
    fi
    
    if [ -f "backend-mediatheque/.dockerignore" ]; then
        print_status 0 "Fichier .dockerignore présent dans le backend"
    else
        print_warning "Fichier .dockerignore manquant dans le backend"
    fi
else
    print_status 1 "Repo backend manquant"
fi

# Vérifier le frontend
if [ -d "frontend-mediatheque" ]; then
    if [ -f "frontend-mediatheque/Dockerfile" ]; then
        print_status 0 "Repo frontend présent avec Dockerfile"
    else
        print_status 1 "Repo frontend présent mais sans Dockerfile"
    fi
    
    if [ -f "frontend-mediatheque/.dockerignore" ]; then
        print_status 0 "Fichier .dockerignore présent dans le frontend"
    else
        print_warning "Fichier .dockerignore manquant dans le frontend"
    fi
    
    if [ -f "frontend-mediatheque/nginx.conf" ]; then
        print_status 0 "Configuration Nginx présente"
    else
        print_warning "Configuration Nginx manquante"
    fi
else
    print_status 1 "Repo frontend manquant"
fi

echo ""
echo "⚙️  Vérification de la configuration..."

# Vérifier docker-compose.yml
if [ -f "docker-compose.yml" ]; then
    print_status 0 "docker-compose.yml présent"
    
    # Vérifier la syntaxe
    if docker-compose config > /dev/null 2>&1; then
        print_status 0 "Syntaxe docker-compose.yml valide"
    else
        print_status 1 "Erreur de syntaxe dans docker-compose.yml"
    fi
else
    print_status 1 "docker-compose.yml manquant"
fi

# Vérifier le fichier .env
if [ -f ".env" ]; then
    print_status 0 "Fichier .env présent"
    
    # Vérifier les variables essentielles
    if grep -q "MONGO_URI" .env; then
        print_status 0 "Variable MONGO_URI configurée"
    else
        print_warning "Variable MONGO_URI manquante"
    fi
    
    if grep -q "JWT_SECRET" .env; then
        print_status 0 "Variable JWT_SECRET configurée"
    else
        print_warning "Variable JWT_SECRET manquante"
    fi
else
    print_warning "Fichier .env manquant (exécutez make setup)"
fi

echo ""
echo "🔧 Vérification des scripts..."

# Vérifier les permissions des scripts
if [ -x "scripts/setup.sh" ]; then
    print_status 0 "Script setup.sh exécutable"
else
    print_status 1 "Script setup.sh non exécutable"
fi

if [ -x "scripts/dev.sh" ]; then
    print_status 0 "Script dev.sh exécutable"
else
    print_status 1 "Script dev.sh non exécutable"
fi

if [ -x "scripts/prod.sh" ]; then
    print_status 0 "Script prod.sh exécutable"
else
    print_status 1 "Script prod.sh non exécutable"
fi

echo ""
echo "📊 Résumé de la vérification..."

if [ $EXIT_CODE -eq 0 ]; then
    echo -e "${GREEN}🎉 Configuration valide ! Vous pouvez lancer le projet.${NC}"
    echo ""
    echo "📋 Prochaines étapes :"
    echo "   make dev     - Lancer en mode développement"
    echo "   make prod    - Lancer en mode production"
    echo "   make help    - Voir toutes les commandes"
else
    echo -e "${RED}❌ Des problèmes ont été détectés. Veuillez les corriger avant de continuer.${NC}"
    echo ""
    echo "🔧 Commandes utiles :"
    echo "   make setup   - Configuration initiale"
    echo "   make check   - Relancer la vérification"
fi

echo ""
exit $EXIT_CODE
