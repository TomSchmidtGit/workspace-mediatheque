# Makefile pour le workspace médiathèque
# Gestion des services Docker et coordination globale

.PHONY: help setup-ci dev prod stop status logs clean rebuild restart shell-backend shell-frontend check quick-check logs-backend logs-frontend clean-smart test test-frontend test-backend lint format ci coordinate coordinate-install coordinate-quality coordinate-test coordinate-security coordinate-build

# Configuration de la CI et coordination globale
setup-ci:
	@echo "Configuration de la CI et coordination globale..."
	@npm install
	@echo "Configuration terminee !"

# Démarrage des services en mode développement
dev:
	@echo "Demarrage des services en mode developpement..."
	docker-compose up -d
	@echo "Services demarres !"

# Démarrage des services en mode production
prod:
	@echo "Demarrage des services en mode production..."
	docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d
	@echo "Services demarres en production !"

# Statut des services
status:
	@echo "Statut des services :"
	docker-compose ps

# Logs des services
logs:
	@echo "Logs des services :"
	docker-compose logs -f

# Nettoyage complet
clean:
	@echo "Nettoyage complet..."
	docker-compose down -v
	docker system prune -af
	@echo "Nettoyage termine !"

# Reconstruction des images
rebuild:
	@echo "Reconstruction des images..."
	docker-compose down
	docker-compose build --no-cache
	docker-compose up -d
	@echo "Reconstruction terminee !"

# Arrêt des services
stop:
	@echo "Arret des services..."
	docker-compose down

# Redémarrage des services
restart:
	@echo "Redemarrage des services..."
	docker-compose restart

# Shell dans un conteneur
shell-backend:
	@echo "Connexion au backend..."
	docker-compose exec backend sh

shell-frontend:
	@echo "Connexion au frontend..."
	docker-compose exec frontend sh

# Vérification de l'environnement
check:
	@echo "Verification de l'environnement..."
	@echo "Docker: $(shell docker --version 2>/dev/null || echo 'Non installe')"
	@echo "Docker Compose: $(shell docker-compose --version 2>/dev/null || echo 'Non installe')"
	@echo "Node.js: $(shell node --version 2>/dev/null || echo 'Non installe')"
	@echo "npm: $(shell npm --version 2>/dev/null || echo 'Non installe')"
	@echo "Fichier .env: $(shell if [ -f .env ]; then echo 'Present'; else echo 'Absent'; fi)"
	@echo "Backend: $(shell if [ -d backend-mediatheque ]; then echo 'Present'; else echo 'Absent'; fi)"
	@echo "Frontend: $(shell if [ -d frontend-mediatheque ]; then echo 'Present'; else echo 'Absent'; fi)"
	@echo "Pre-commit: $(shell if [ -f .git/hooks/pre-commit ]; then echo 'Installe'; else echo 'Non installe'; fi)"

# Vérification rapide Docker Compose
quick-check:
	@echo "Verification rapide Docker Compose..."
	@docker-compose config > /dev/null && echo "Configuration valide" || echo "Erreur de configuration"

# Logs par service
logs-backend:
	@echo "Logs du backend :"
	docker-compose logs -f backend

logs-frontend:
	@echo "Logs du frontend :"
	docker-compose logs -f frontend

# Nettoyage intelligent
clean-smart:
	@echo "Nettoyage intelligent..."
	docker-compose down
	docker system prune -f
	@echo "Nettoyage termine"

# Tests et qualité
test:
	@echo "Execution de tous les tests..."
	@npm run test

test-frontend:
	@echo "Tests du frontend..."
	@npm run test:frontend

test-backend:
	@echo "Tests du backend..."
	@npm run test:backend

lint:
	@echo "Verification du code (lint)..."
	@npm run lint

format:
	@echo "Formatage automatique du code..."
	@npm run format

ci:
	@echo "Execution complete de la CI..."
	@npm run ci

# Coordination globale
coordinate:
	@echo "Coordination globale du workspace..."
	@./scripts/coordinate.sh ci

coordinate-install:
	@echo "Installation des dependances..."
	@./scripts/coordinate.sh install

coordinate-quality:
	@echo "Verification de la qualite..."
	@./scripts/coordinate.sh quality

coordinate-security:
	@echo "Verification de la securite..."
	@./scripts/coordinate.sh security

coordinate-build:
	@echo "Build des projets..."
	@./scripts/coordinate.sh build

coordinate-test:
	@echo "Execution des tests..."
	@./scripts/coordinate.sh test

# Aide
help:
	@echo "Workspace Mediatheque - Makefile"
	@echo ""
	@echo "Commandes principales :"
	@echo "  setup-ci     - Configuration de la CI et coordination globale"
	@echo "  dev          - Demarrage des services en mode developpement"
	@echo "  prod         - Demarrage des services en mode production"
	@echo "  stop         - Arret des services"
	@echo "  status       - Statut des services"
	@echo "  logs         - Affichage des logs"
	@echo "  clean        - Nettoyage complet"
	@echo "  rebuild      - Reconstruction des images"
	@echo ""
	@echo "Tests et qualite :"
	@echo "  test         - Execution de tous les tests"
	@echo "  test-frontend - Tests du frontend uniquement"
	@echo "  test-backend  - Tests du backend uniquement"
	@echo "  lint         - Verification du code (lint)"
	@echo "  format       - Formatage automatique du code"
	@echo "  ci           - Execution complete de la CI"
	@echo ""
	@echo "Coordination globale :"
	@echo "  coordinate           - Coordination globale du workspace"
	@echo "  coordinate-install   - Installation des dependances"
	@echo "  coordinate-quality   - Verification de la qualite"
	@echo "  coordinate-test      - Execution des tests"
	@echo "  coordinate-security  - Verification de la securite"
	@echo "  coordinate-build     - Build des projets"
	@echo ""
	@echo "Docker :"
	@echo "  check        - Verification de l'environnement"
	@echo "  quick-check  - Verification rapide Docker Compose"
	@echo "  shell-backend  - Connexion au backend"
	@echo "  shell-frontend - Connexion au frontend"
