#!/bin/bash

# Plik zawierający pary plików
config_locations="config_locations.txt"

echo "Kopiowanie plików konfiguracyjnych"
echo ""

# Kopiowanie plików
while read -r pair; do
  source_file="${pair%% *}"
  target_file="${pair#* }"

  source_file=$(eval echo "$source_file")
  target_file=$(eval echo "$target_file")

  if [ -d "$source_file" ]; then

    if [ -d "$target_file" ]; then
      rm -rf "$target_file"
    fi

    cp -r "$source_file" "$target_file"
    echo "Kopiowanie folderu $source_file -> $target_file"
  elif [ -f "$source_file" ]; then
    cp "$source_file" "$target_file"
    echo "Kopiowanie pliku $source_file -> $target_file"
  else
    echo "Plik $source_file nie istnieje, pomijam..."
  fi

  echo ""
done < "$config_locations"
