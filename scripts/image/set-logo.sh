#!/bin/bash

# ===============================================
# set-logo-image.sh
# Définir le logo du site Hugo + Blowfish
# Peut être lancé depuis n'importe où
# ===============================================

# 📂 Trouver le dossier racine du projet (2 niveaux au-dessus du dossier du script)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"

CONFIG_FILE="$PROJECT_ROOT/hugo.toml"
DEST_DIR="$PROJECT_ROOT/static/img"

# Vérification du fichier hugo.toml
if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "❌ Fichier hugo.toml introuvable dans : $PROJECT_ROOT"
  exit 1
fi

# 📥 Demande du chemin de l'image source
echo "🖼️  Définition du logo du site"
read -p "Chemin complet de l'image source : " IMG_PATH

# Vérifie que l'image existe
if [[ ! -f "$IMG_PATH" ]]; then
  echo "❌ Image introuvable : $IMG_PATH"
  exit 1
fi

# 📛 Nom du fichier image
IMG_NAME=$(basename "$IMG_PATH")

# 📂 Crée le dossier static/img si nécessaire
mkdir -p "$DEST_DIR"

# 📤 Copie l'image
cp "$IMG_PATH" "$DEST_DIR/$IMG_NAME" && \
echo "✅ Image copiée dans : $DEST_DIR/$IMG_NAME"

# 💾 Sauvegarde du hugo.toml
cp "$CONFIG_FILE" "$CONFIG_FILE.bak"
echo "💾 Sauvegarde créée : $CONFIG_FILE.bak"

# 🧹 Supprime toute ancienne ligne "logo = ..."
grep -v '^logo\s*=' "$CONFIG_FILE" > "$CONFIG_FILE.tmp"

# 📝 Ajout propre du logo dans [params]
if grep -q "^\[params\]" "$CONFIG_FILE.tmp"; then
  # Ajouter après [params] si déjà présent
  awk -v logo="  logo = \"/img/$IMG_NAME\"" '
    /^\[params\]/ { print; added=1; print logo; next }
    { print }
  ' "$CONFIG_FILE.tmp" > "$CONFIG_FILE.tmp2" && mv "$CONFIG_FILE.tmp2" "$CONFIG_FILE.tmp"
else
  # Créer un bloc [params] si inexistant
  echo "" >> "$CONFIG_FILE.tmp"
  echo "[params]" >> "$CONFIG_FILE.tmp"
  echo "  logo = \"/img/$IMG_NAME\"" >> "$CONFIG_FILE.tmp"
fi

# Remplace le fichier config par le nouveau
mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"

echo "🎯 Logo défini sur : /img/$IMG_NAME"
echo "🚀 Relance Hugo avec : hugo server -D --disableFastRender"
