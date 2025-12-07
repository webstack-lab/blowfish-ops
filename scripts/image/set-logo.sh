#!/bin/bash

# ===============================================
# set-logo.sh (version corrigée Blowfish)
# Définir automatiquement le logo dans assets/img
# ===============================================

# 📂 Localiser la racine du projet
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$(dirname "$SCRIPT_DIR")")"

CONFIG_FILE="$PROJECT_ROOT/hugo.toml"
DEST_DIR="$PROJECT_ROOT/assets/img"

# Vérifier l'existence du fichier de config
if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "❌ Fichier hugo.toml introuvable : $CONFIG_FILE"
  exit 1
fi

echo "🖼️  Définition du logo du site"
read -p "Chemin complet de l'image source : " IMG_PATH

# Vérifie que l'image existe
if [[ ! -f "$IMG_PATH" ]]; then
  echo "❌ Image introuvable : $IMG_PATH"
  exit 1
fi

IMG_NAME=$(basename "$IMG_PATH")

# 📂 Création du dossier assets/img si nécessaire
mkdir -p "$DEST_DIR"

# 📥 Copier le fichier source dans assets/img/
cp "$IMG_PATH" "$DEST_DIR/$IMG_NAME" && \
echo "✅ Image copiée dans : $DEST_DIR/$IMG_NAME"

# 💾 Sauvegarde du hugo.toml
cp "$CONFIG_FILE" "$CONFIG_FILE.bak"
echo "💾 Sauvegarde créée : $CONFIG_FILE.bak"

# 🧹 Supprime toute ancienne ligne 'logo = ...'
grep -v '^logo\s*=' "$CONFIG_FILE" > "$CONFIG_FILE.tmp"

# 📝 Injecte proprement le nouveau logo dans [params]
if grep -q "^\[params\]" "$CONFIG_FILE.tmp"; then
  # Ajouter après [params] si déjà présent
  awk -v logo="  logo = \"img/$IMG_NAME\"" '
    /^\[params\]/ { print; added=1; print logo; next }
    { print }
  ' "$CONFIG_FILE.tmp" > "$CONFIG_FILE.tmp2" && mv "$CONFIG_FILE.tmp2" "$CONFIG_FILE.tmp"
else
  # Créer un bloc [params]
  echo "" >> "$CONFIG_FILE.tmp"
  echo "[params]" >> "$CONFIG_FILE.tmp"
  echo "  logo = \"img/$IMG_NAME\"" >> "$CONFIG_FILE.tmp"
fi

mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"

echo "🎯 Logo défini sur : img/$IMG_NAME (dans assets/img/)"
echo "🚀 Relance Hugo avec : hugo server -D --disableFastRender"
