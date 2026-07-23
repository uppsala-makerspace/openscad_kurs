#!/bin/bash
#
# Create the front page for book 1
#
# Usage:
#
#   ./scripts/create_book_1_front_page.sh

if [[ "$PWD" =~ scripts$ ]]; then
    echo "FATAL ERROR."
    echo "Please run the script from the project root. "
    echo "Present working director: $PWD"
    echo " "
    echo "Tip: like this"
    echo " "
    echo "  ./scripts/create_book_1_front_page.sh"
    echo " "
    exit 42
fi

cd front_pages || exit 42

pandoc front_page_1.md -o ../books/book_1/front_page.pdf
