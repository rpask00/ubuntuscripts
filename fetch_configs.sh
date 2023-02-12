#!/bin/bash

# Plik zawierający pary plików
config_locations="config_locations.txt"

# Kopiowanie plików
while read -r pair; do
  source_file="${pair%% *}"
  target_file="${pair#* }"
  cp "$source_file" "$target_file"
  file_pairs_file=$(eval echo "$file_pairs_file")
  echo "$file_pairs_file"
  echo "Skopiowano plik $source_file do $target_file"
  echo ""
done < "$config_locations"
