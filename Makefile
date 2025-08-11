# Makefile pour le workspace parent médiathèque
# Usage: make [target]

.PHONY: help setup dev prod clean logs status build rebuild

# Variables
COMPOSE_FILE = docker-compose.yml

# Aide
help:
	@echo "🚀 Workspace Parent Médiathèque - Commandes disponibles :"
	@echo ""
	@echo "📋 Configuration :"
	@echo "  setup     - Configuration initiale de l'environnement"
	@echo "  build     - Construction des images Docker"
	@echo ""
	@echo "🚀 Lancement :"
	@echo "  dev       - Lancement en mode développement"
	@echo "  prod      - Lancement en mode production"
	@echo ""
	@echo "🔧 Gestion :"
	@echo "  status    - Statut des services"
	@echo "  logs      - Affichage des logs"
	@echo "  clean     - Nettoyage et arrêt des services"
	@echo "  rebuild   - Reconstruction complète des images"
	@echo ""
	@echo "📚 Documentation :"
	@echo "  help      - Affiche cette aide"

# Configuration initiale
setup:
	@echo "🔧 Configuration de l'environnement..."
	@chmod +x scripts/*.sh
	@./scripts/setup.sh

# Construction des images
build:
	@echo "🔨 Construction des images Docker..."
	docker-compose build

# Mode développement
dev:
	@echo "🔧 Lancement en mode développement..."
	@./scripts/dev.sh

# Mode production
prod:
	@echo "🚀 Lancement en mode production..."
	@./scripts/prod.sh

# Statut des services
status:
	@echo "📊 Statut des services :"
	docker-compose ps

# Affichage des logs
logs:
	@echo "📋 Logs des services :"
	docker-compose logs -f

# Nettoyage
clean:
	@echo "🧹 Nettoyage de l'environnement..."
	@./scripts/clean.sh

# Nettoyage complet (avec volumes)
clean-all:
	@echo "🧹 Nettoyage complet (avec volumes)..."
	@./scripts/clean.sh --volumes

# Reconstruction complète
rebuild:
	@echo "🔨 Reconstruction complète des images..."
	docker-compose down
	docker-compose build --no-cache
	@echo "✅ Reconstruction terminée !"

# Arrêt des services
stop:
	@echo "🛑 Arrêt des services..."
	docker-compose down

# Redémarrage des services
restart:
	@echo "🔄 Redémarrage des services..."
	docker-compose restart

# Shell dans un conteneur
shell-backend:
	@echo "🐚 Connexion au backend..."
	docker-compose exec backend sh

shell-frontend:
	@echo "🐚 Connexion au frontend..."
	docker-compose exec frontend sh

shell-mongodb:
	@echo "🐚 Connexion à MongoDB..."
	docker-compose exec mongodb mongosh

# Vérification de l'environnement
check:
	@echo "🔍 Vérification de l'environnement..."
	@echo "Docker: $(shell docker --version 2>/dev/null || echo 'Non installé')"
	@echo "Docker Compose: $(shell docker-compose --version 2>/dev/null || echo 'Non installé')"
	@echo "Fichier .env: $(shell if [ -f .env ]; then echo '✅ Présent'; else echo '❌ Absent'; fi)"
	@echo "Backend: $(shell if [ -d backend-mediatheque ]; then echo '✅ Présent'; else echo '❌ Absent'; fi)"
	@echo "Frontend: $(shell if [ -d frontend-mediatheque ]; then echo '✅ Présent'; else echo '❌ Absent'; fi)"
