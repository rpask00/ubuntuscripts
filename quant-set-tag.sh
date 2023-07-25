#!/bin/bash

cd ~/dev/quant-www

branch="develop"
prefix="dev"

skip_checkout="f"

while getopts 'drts' OPTION; do
  case "$OPTION" in
    d)
      branch='develop'
      ;;
    r)
      branch='relcan'
      ;;
    t)
      prefix='test'
      ;;
    s)
      skip_checkout='t'
      ;;
  esac
done

if [ "$skip_checkout" == 'f' ]; then 
    git checkout "$branch" || { echo "Błąd: Nie można przełączyć na branch $branch"; exit 1; }
    git pull || { echo "Błąd: Nie można pobrać najnowszego kodu z brancha $branch"; exit 1; }
fi
    
get_next_tag_number() {
    local pref=$1
    local date_today=$2
    local last_tag=$(git tag | grep "$prefix/$date_today" | tail -n 1)

    if [ -z "$last_tag" ]; then
        echo "1"
    else
        local last_number=$(echo "$last_tag" | awk -F/ '{print $NF}')
        local next_number=$((last_number + 1))
        echo "$next_number"
    fi
}


today=$(date +"%d-%m-%Y")
next_number=$(get_next_tag_number "$prefix" "$today")
new_tag="$prefix/$today/$next_number"

echo "Czy chcesz ustawić tag: $new_tag ? (t/n)"
read confirm

if [ "$confirm" == "t" ]; then
    # Sprawdź, czy tag już nie istnieje
    if git rev-parse "$new_tag" >/dev/null 2>&1; then
        echo "Błąd: Tag $new_tag już istnieje. Nie można go ponownie utworzyć."
        exit 1
    fi

    # Dodaj nowy tag na aktualnym commicie
    git tag "$new_tag"
    if [ $? -eq 0 ]; then
        git push origin "$new_tag"
        echo "Utworzono nowy tag: $new_tag"
    else
        echo "Błąd podczas tworzenia tagu."
    fi
else
    echo "Anulowano tworzenie tagu."
fi
