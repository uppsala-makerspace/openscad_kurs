#!/bin/bash
#
# Create the Markdown version of the books
#
# Usage:
#
#   ./scripts/create_markdown_books.sh

if [[ "$PWD" =~ scripts$ ]]; then
    echo "FATAL ERROR."
    echo "Please run the script from the project root. "
    echo "Present working director: $PWD"
    echo " "
    echo "Tip: like this"
    echo " "
    echo "  ./scripts/create_markdown_books.sh"
    echo " "
    exit 42
fi

pandoc -o docs/generated_10_mars_bok_1.md docs/10_mars_bok_1.docx
pandoc -o docs/generated_18_mars_bok_2.md docs/18_mars_bok_2.docx
pandoc -o docs/generated_21_Juni_bok_3.md docs/21_Juni_bok_3.docx

