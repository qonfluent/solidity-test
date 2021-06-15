shopt -s globstar

for f in ./**/*.sol ; do
	solc --allow-paths . "$f"
done
