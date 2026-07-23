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

rm -rf build
mkdir build

if [ ! -d ${build_folder} ]; then 
  echo "Error: failed to create build folder"
  exit 1
fi

cp ../foreword/*.*           ${build_folder}; mv ${build_folder}/README.md ${build_folder}/README_00.md
cp ../books/book_1/*.*       ${build_folder}; mv ${build_folder}/README.md ${build_folder}/README_01.md
cp openscad_book_style.theme ${build_folder}

cd "${build_folder}" || exit 41

{ \
  cat README_00.md ; echo " " ; echo "\pagebreak" ; echo " "; \
  cat README_01.md ; echo " " ; echo "\pagebreak" ; echo " "; \
} >> README.md

# Table of Content
# Code has highlights following the tango color scheme
# Thinner margin of 0.5 inch
# Do not cut code blocks
pandoc README.md -o book_contents.pdf --toc --toc-depth=1 --highlight-style=arduino_book_style.theme -V geometry:margin=0.5in

cp book_contents.pdf ../../books/book_1/book_contents.pdf

cd ../../books/book_1 || exit 42
pdfunite front_page.pdf book_contents.pdf book.pdf

# Make booklet
bookletimposer -a book.pdf -o booklet.pdf

# Cleanup
rm book_contents.pdf
