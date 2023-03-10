#!/bin/bash

# Plik zawierający pary plików
config_locations="config_locations.txt"

echo "Przywracanie plików konfiguracyjnych"
echo ""

# Kopiowanie plików
while read -r pair; do
  source_file="${pair#* }"
  target_file="${pair%% *}"

  source_file=$(eval echo "$source_file")
  target_file=$(eval echo "$target_file")

  cp "$source_file" "$target_file"
  echo "$source_file -> $target_file"
  echo ""
done < "$config_locations"

