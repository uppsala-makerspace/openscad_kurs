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

# Use 'extractmedia' to get the images too
# Tip from https://stackoverflow.com/questions/39956497/pandoc-convert-docx-to-markdown-with-embedded-images#comment88380070_39961440
pandoc -o docs/generated_10_mars_bok_1.md --extract-media=docs/media docs/10_mars_bok_1.docx
pandoc -o docs/generated_18_mars_bok_2.md --extract-media=docs/media docs/18_mars_bok_2.docx
pandoc -o docs/generated_21_Juni_bok_3.md --extract-media=docs/media docs/21_Juni_bok_3.docx

