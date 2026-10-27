#!/bin/bash
#
# Create the Markdown for book 1
#
# Usage:
#
#   ./scripts/create_book_1_markdown.sh

if [[ "$PWD" =~ scripts$ ]]; then
    echo "FATAL ERROR."
    echo "Please run the script from the project root. "
    echo "Present working director: $PWD"
    echo " "
    echo "Tip: like this"
    echo " "
    echo "  ./scripts/create_book_1_markdown.sh"
    echo " "
    exit 42
fi

# Work in the docs folder
cd books/book_1 || exit 42

# Use 'extractmedia' to get the images too
# Tip from https://stackoverflow.com/questions/39956497/pandoc-convert-docx-to-markdown-with-embedded-images#comment88380070_39961440
pandoc -o README.md --extract-media=media 10_mars_bok_1.docx

# Pandoc creates some ugly annotation for picture size
sed -i -e 's/{width=".*in"//g' -e 's/height=".*in"}//g' README.md 
