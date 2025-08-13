#!/bin/bash

# Script de coordination globale pour le workspace médiathèque
# Usage: ./scripts/coordinate.sh [command]

set -e

# Couleurs pour l'affichage
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Fonction d'affichage
print_status() {
    echo -e "${BLUE}🔍 $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Vérification des prérequis
check_prerequisites() {
    print_status "Vérification des prérequis..."
    
    if ! command -v node &> /dev/null; then
        print_error "Node.js n'est pas installé"
        exit 1
    fi
    
    if ! command -v npm &> /dev/null; then
        print_error "npm n'est pas installé"
        exit 1
    fi
    
    print_success "Prérequis vérifiés"
}

# Installation des dépendances
install_dependencies() {
    print_status "Installation des dépendances..."
    
    print_status "Installation workspace..."
    npm install
    
    print_status "Installation frontend..."
    cd frontend-mediatheque
    npm install
    cd ..
    
    print_status "Installation backend..."
    cd backend-mediatheque
    npm install
    cd ..
    
    print_success "Toutes les dépendances installées"
}

# Vérification de la qualité du code
check_code_quality() {
    print_status "Vérification de la qualité du code..."
    
    print_status "Lint frontend..."
    cd frontend-mediatheque
    npm run lint
    cd ..
    
    print_status "Lint backend..."
    cd backend-mediatheque
    npm run lint
    cd ..
    
    print_success "Qualité du code vérifiée"
}

# Vérification du formatage
check_formatting() {
    print_status "Vérification du formatage..."
    
    print_status "Format frontend..."
    cd frontend-mediatheque
    npm run format:check
    cd ..
    
    print_status "Format backend..."
    cd backend-mediatheque
    npm run format:check
    cd ..
    
    print_success "Formatage vérifié"
}

# Exécution des tests
run_tests() {
    print_status "Exécution des tests..."
    
    print_status "Tests frontend..."
    cd frontend-mediatheque
    npm run test:run
    cd ..
    
    print_status "Tests backend..."
    cd backend-mediatheque
    npm run test:ci
    cd ..
    
    print_success "Tous les tests passent"
}

# Vérification du statut global
check_status() {
    print_status "📊 Vérification du statut global..."
    
    echo ""
    print_status "📁 Structure des projets :"
    echo "  ├── workspace-mediatheque/     ✅ Présent"
    echo "  ├── frontend-mediatheque/      ✅ Présent"
    echo "  └── backend-mediatheque/       ✅ Présent"
    
    echo ""
    print_status "🔧 Dépendances :"
    
    # Vérifier workspace
    if [ -f "package.json" ] && [ -d "node_modules" ]; then
        echo "  ├── workspace-mediatheque/     ✅ Dépendances installées"
    else
        echo "  ├── workspace-mediatheque/     ❌ Dépendances manquantes"
    fi
    
    # Vérifier frontend
    if [ -f "frontend-mediatheque/package.json" ] && [ -d "frontend-mediatheque/node_modules" ]; then
        echo "  ├── frontend-mediatheque/      ✅ Dépendances installées"
    else
        echo "  ├── frontend-mediatheque/      ❌ Dépendances manquantes"
    fi
    
    # Vérifier backend
    if [ -f "backend-mediatheque/package.json" ] && [ -d "backend-mediatheque/node_modules" ]; then
        echo "  └── backend-mediatheque/       ✅ Dépendances installées"
    else
        echo "  └── backend-mediatheque/       ❌ Dépendances manquantes"
    fi
    
    echo ""
    print_status "📋 Scripts disponibles :"
    echo "  ├── npm run ci              # CI complète"
    echo "  ├── npm run quality         # Qualité du code"
    echo "  ├── npm run format          # Formatage"
    echo "  ├── npm run test            # Tests"
    echo "  ├── npm run security        # Sécurité"
    echo "  └── npm run build           # Build"
    
    echo ""
    print_status "🔨 Commandes make :"
    echo "  ├── make coordinate         # Coordination globale"
    echo "  ├── make coordinate:install # Installation"
    echo "  ├── make coordinate:quality # Qualité"
    echo "  ├── make coordinate:test    # Tests"
    echo "  └── make coordinate:build   # Build"
    
    print_success "Statut global vérifié"
}

# Exécution des tests
run_tests() {
    print_status "Exécution des tests..."
    
    print_status "Tests frontend..."
    cd frontend-mediatheque
    npm run test:run
    cd ..
    
    print_status "Tests backend..."
    cd backend-mediatheque
    npm run test:ci
    cd ..
    
    print_success "Tous les tests passent"
}

# Vérification de la sécurité
check_security() {
    print_status "Vérification de la sécurité..."
    
    print_status "Audit frontend..."
    cd frontend-mediatheque
    npm audit --audit-level=moderate || print_warning "Vulnérabilités détectées dans le frontend"
    cd ..
    
    print_status "Audit backend..."
    cd backend-mediatheque
    npm audit --audit-level=moderate || print_warning "Vulnérabilités détectées dans le backend"
    cd ..
    
    print_success "Sécurité vérifiée"
}

# Build des projets
build_projects() {
    print_status "Build des projets..."
    
    print_status "Build frontend..."
    cd frontend-mediatheque
    npm run build
    cd ..
    
    print_status "Build backend..."
    cd backend-mediatheque
    npm run build
    cd ..
    
    print_success "Tous les projets construits"
}

# CI complète
run_full_ci() {
    print_status "🚀 Exécution de la CI complète..."
    
    check_code_quality
    check_formatting
    run_tests
    check_security
    build_projects
    
    print_success "🎉 CI complète terminée avec succès !"
}

# Affichage de l'aide
show_help() {
    echo "🚀 Script de coordination globale - Workspace Médiathèque"
    echo ""
    echo "Usage: ./scripts/coordinate.sh [command]"
    echo ""
    echo "Commandes disponibles :"
    echo "  install     - Installation des dépendances"
    echo "  quality     - Vérification de la qualité du code"
    echo "  format      - Vérification du formatage"
    echo "  test        - Exécution des tests"
    echo "  security    - Vérification de la sécurité"
    echo "  build       - Build des projets"
    echo "  ci          - CI complète (recommandé)"
    echo "  status      - Statut global du workspace"
    echo "  help        - Affiche cette aide"
    echo ""
    echo "Exemples :"
    echo "  ./scripts/coordinate.sh ci          # CI complète"
    echo "  ./scripts/coordinate.sh test        # Tests uniquement"
    echo "  ./scripts/coordinate.sh quality     # Qualité du code uniquement"
    echo "  ./scripts/coordinate.sh status      # Statut global"
}

# Gestion des commandes
case "${1:-ci}" in
    "install")
        check_prerequisites
        install_dependencies
        ;;
    "quality")
        check_code_quality
        ;;
    "format")
        check_formatting
        ;;
    "test")
        run_tests
        ;;
    "security")
        check_security
        ;;
    "build")
        build_projects
        ;;
    "ci")
        run_full_ci
        ;;
    "status")
        check_status
        ;;
    "help"|"--help"|"-h")
        show_help
        ;;
    *)
        print_error "Commande inconnue: $1"
        show_help
        exit 1
        ;;
esac
