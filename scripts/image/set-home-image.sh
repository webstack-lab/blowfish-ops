#!/bin/bash

# ==========================================================
# set-home-image.sh
# Ajoute une image de hero compatible Blowfish (assets/img)
# ==========================================================

echo "🖼️ Configuration de l’image Hero du site"

# 1. Demande du chemin source
read -p "Chemin complet de l'image locale : " image_path

if [ ! -f "$image_path" ]; then
  echo "❌ Fichier introuvable : $image_path"
  exit 1
fi

# 2. Détection de la racine du projet
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"

CONFIG_FILE="$PROJECT_ROOT/hugo.toml"
ASSETS_DIR="$PROJECT_ROOT/assets/img"
CONTENT_INDEX="$PROJECT_ROOT/content/_index.md"

# 3. Création dossier assets/img
mkdir -p "$ASSETS_DIR"

# 4. Copie image
image_name=$(basename "$image_path")
cp "$image_path" "$ASSETS_DIR/$image_name"

echo "✅ Image copiée dans : $ASSETS_DIR/$image_name"

# 5. Mise à jour de content/_index.md
if [ ! -f "$CONTENT_INDEX" ]; then
  echo "---" > "$CONTENT_INDEX"
  echo "title: \"Accueil\"" >> "$CONTENT_INDEX"
  echo "---" >> "$CONTENT_INDEX"
fi

# 🔥 Supprime bloc hero existant
sed -i '/^hero:/,/^[^ ]/d' "$CONTENT_INDEX"

# 🔥 Ajout du nouveau bloc hero
cat <<EOF >> "$CONTENT_INDEX"

hero:
  enabled: true
  image: "img/$image_name"
  align: center
  headline: "Bienvenue sur le site E-Sport"
  description: "Powered by Hugo + Blowfish"
EOF

echo "🎉 Image Hero configurée avec succès"
echo "🚀 Lance : hugo server -D --disableFastRender"
