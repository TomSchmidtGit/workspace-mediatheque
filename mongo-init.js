// Script d'initialisation MongoDB
db = db.getSiblingDB('mediatheque');

// Créer l'utilisateur pour la base de données
db.createUser({
  user: process.env.MONGO_ROOT_USERNAME,
  pwd: process.env.MONGO_ROOT_PASSWORD,
  roles: [
    {
      role: "readWrite",
      db: "mediatheque"
    }
  ]
});

// Créer les collections de base
db.createCollection('users');
db.createCollection('media');
db.createCollection('categories');
db.createCollection('tags');
db.createCollection('borrows');

// Créer des index pour optimiser les performances
db.users.createIndex({ "email": 1 }, { unique: true });
db.media.createIndex({ "title": 1 });
db.media.createIndex({ "category": 1 });
db.media.createIndex({ "tags": 1 });
db.borrows.createIndex({ "user": 1 });
db.borrows.createIndex({ "media": 1 });
db.borrows.createIndex({ "dueDate": 1 });

print('✅ Base de données médiathèque initialisée avec succès');
