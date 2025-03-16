#!/bin/bash

cd ~/dev/quant-www

previous_branch=$(git branch | grep \* | cut -d ' ' -f2)
pending_changes=$(git status --porcelain)

branch="develop"
prefix="dev"

skip_checkout="f"

# Funkcja do stashingu i przywracania zmian
stash_and_pop_changes() {
    local action=$1

    if [ "$action" == "pop" ]; then
        git checkout $previous_branch
    fi

    if [ -n "$pending_changes" ]; then
        if [ "$action" == "stash" ]; then
            git stash push -u -m "Stashed changes before creating a new tag"
        elif [ "$action" == "pop" ]; then
            git stash pop
        fi
    fi
}

while getopts 'drtsf' OPTION; do
  case "$OPTION" in
    d)
      branch='develop'
      ;;
    r)
      branch='release'
      prefix='rel'
      ;;
    f)
      branch='future'
      prefix='future'
      ;;
    t)
      branch='release'
      prefix='rel'
      ;;
    s)
      skip_checkout='t'
      ;;
  esac
done

# Stash zmian przed przełączeniem na inny branch
stash_and_pop_changes "stash"

if [ "$skip_checkout" == 'f' ]; then 
    git checkout "$branch" || { echo "Błąd: Nie można przełączyć na branch $branch"; stash_and_pop_changes "pop"; exit 1; }
    git pull || { echo "Błąd: Nie można pobrać najnowszego kodu z brancha $branch"; stash_and_pop_changes "pop"; exit 1; }
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
        stash_and_pop_changes "pop"
        exit 1
    fi

    # Dodaj nowy tag na aktualnym commicie
    git tag "$new_tag"
    if [ $? -eq 0 ]; then
        # Odkomentuj poniższą linię, aby automatycznie przesłać nowy tag do zdalnego repozytorium
        git push origin "$new_tag"
        echo "Utworzono nowy tag: $new_tag"
    else
        echo "Błąd podczas tworzenia tagu."
    fi
else
    echo "Anulowano tworzenie tagu."
fi



git checkout $previous_branch

# Przywróć zmiany ze stash'a po zakończeniu skryptu
stash_and_pop_changes "pop"
