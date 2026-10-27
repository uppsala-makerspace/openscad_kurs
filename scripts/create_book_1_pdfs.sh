#!/bin/bash
#
# Create the PDFs (book and booklet) of book 1.
#
# Usage:
#
#   ./scripts/create_book_1_pdfs.sh

if [[ "$PWD" =~ scripts$ ]]; then
    echo "FATAL ERROR."
    echo "Please run the script from the project root. "
    echo "Present working director: $PWD"
    echo " "
    echo "Tip: like this"
    echo " "
    echo "  ./scripts/create_book_1_pdfs.sh"
    echo " "
    exit 42
fi

build_folder=build
book_number="1"

rm -rf build
mkdir build

if [ ! -d ${build_folder} ]; then 
  echo "Error: failed to create build folder"
  exit 1
fi

cp foreword/*.*                      ${build_folder}; mv ${build_folder}/README.md ${build_folder}/README_00.md
cp chapters/chapter_1/*.*            ${build_folder}; mv ${build_folder}/README.md ${build_folder}/README_01.md
cp scripts/openscad_book_style.theme ${build_folder}

cd "${build_folder}" || exit 41

{ \
  cat README_00.md ; echo " " ; echo "\pagebreak" ; echo " "; \
  cat README_01.md ; echo " " ; echo "\pagebreak" ; echo " "; \
} >> README.md

# Table of Content
# Code has highlights following the tango color scheme
# Thinner margin of 0.5 inch
# Do not cut code blocks
# pandoc README.md -o "book_${book_number}_contents.pdf" --toc --toc-depth=1 --highlight-style=openscad_book_style.theme -V geometry:margin=0.5in
# For fonts 10pt, 11pt, 12pt, add: -V fontsize=12pt
# For fonts 8–20pt, add: -V fontsize=20pt -V documentclass=extarticle
pandoc README.md -o "book_${book_number}_contents.pdf" --toc --toc-depth=1 --highlight-style=openscad_book_style.theme -V geometry:margin=0.5in -V fontsize=20pt -V documentclass=extarticle

cp "book_${book_number}_contents.pdf" "../books/book_${book_number}_contents.pdf"

cd ../books || exit 42
pdfunite "book_${book_number}_front_page.pdf" "book_${book_number}_contents.pdf" "book_${book_number}.pdf"

# Make booklet
bookletimposer -a "book_${book_number}.pdf" -o "booklet_${book_number}.pdf"

# Cleanup
rm "book_${book_number}_contents.pdf"
