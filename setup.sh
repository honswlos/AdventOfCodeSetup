#!/usr/bin/env sh

echo " █████╗  ██████╗  ██████╗███████╗███████╗████████╗██╗   ██╗██████╗ "
echo "██╔══██╗██╔═══██╗██╔════╝██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗"
echo "███████║██║   ██║██║     ███████╗█████╗     ██║   ██║   ██║██████╔╝"
echo "██╔══██║██║   ██║██║     ╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝ "
echo "██║  ██║╚██████╔╝╚██████╗███████║███████╗   ██║   ╚██████╔╝██║     "
echo "╚═╝  ╚═╝ ╚═════╝  ╚═════╝╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝"
echo ""

# Create a folder for the git repo.
echo "Creating parent directory."
DATE=$(date +"%Y")
GITDIR="$HOME/src/AdventOfCode$DATE"
mkdir $GITDIR

# Create the repo.
echo "Initializing the git repo."
git init $GITDIR 2>/dev/null
cp resources/gitignore.txt $GITDIR/.gitignore

# Create README.md
README="$GITDIR/README.md"
touch $README
echo "### Advent of Code $DATE" > $README
echo "Python Solutions to [Advent of Code](https://adventofcode.com/)" $DATE>> $README
echo "" >> $README
echo "This repo was setup using [r00's AdventOfCodeSetup script](https://github.com/User-r00/AdventOfCodeSetup)" >> $README

# Setup the folders for each day.
echo "Setting up day folders and template files."
for i in {1..31}
do
    mkdir "$GITDIR/Day $i"
    touch "$GITDIR/Day $i/input.txt"
    for x in {1..2}
    do
        cp resources/python_template.py "$GITDIR/Day $i/part$x.py"
    done
done

# Commit everything to git.

# Attach local repo to remote.
echo "Adding files to git."
cd $GITDIR
git add --all

echo "Creating initial commit."
git commit -m "Setup repo foundation." 1>/dev/null

git branch -M main

# Setup repo online.
echo ""
echo "Go to https://github.com/new and setup a new repository called $GITDIR. A README and gitignore will be provided by this script. Paste the url below."
read URL

if [[ -z "$URL" ]]; then
    echo "No url given, please set up git remote manually."
else
    echo "Modifying git remote."
    git remote add origin $URL

    echo "Pushing."
    git push -u origin main
fi

echo "Done"
