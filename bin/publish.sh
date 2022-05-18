echo 'Removing build/blg_handbook/ folder...'
rm -rf build/blg_handbook
echo 'Creating empty build/blg_handbook/ folder...'
mkdir -p build/blg_handbook/www

echo 'Compiling single file.html....'
asciidoctor -o build/blg_handbook/blg_handbook.html content/index.adoc

echo 'Compiling DocBook format....'
asciidoctor -b docbook5 -o build/blg_handbook/blg_handbook.xml content/index.adoc

echo 'Compiling PDF Format....'
asciidoctor --trace -r asciidoctor-pdf -b pdf -o build/blg_handbook/blg_handbook.pdf content/index.adoc
# asciidoctor -a route-style=monokai --trace -r asciidoctor-pdf -b pdf -o build/all_in_one/all_in_one.pdf content/books/all_in_one/index.adoc

echo 'Compiling EPUB Format .....'
asciidoctor-epub3 -o build/blg_handbook/blg_handbook.epub content/index.adoc
# asciidoctor -r asciidoctor-epub3 -b epub3 -o docs/all_in_one.epub pub/all_in_one.adoc

echo 'Compiling Multipage HTML .....'
asciidoctor --trace -r asciidoctor-multipage -b multipage_html5 -o index.html -D build/blg_handbook/www content/index.adoc
cp -r content/assets build/blg_handbook/www

echo 'Cleaning up "docs/* folder....'
rm -rf docs/*
echo 'Copying files to docs folder for github pages publishing .... '
cp -r build/blg_handbook/www/* docs
cp -r content/assets  docs
cp ./build/blg_handbook/blg_handbook* docs
cp ./content/CNAME docs

echo 'Pushing to github...'
git add .
git commit -m "Compiled and commit .."
open docs
