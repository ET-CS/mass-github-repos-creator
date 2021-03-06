#!/bin/bash

# This script sync folder to repository at GitHub using parameters - FOLDER & USER & REPO.

# This bash script name
ME=`basename $0`

# Folder
FOLDER=$1
# GitHub User
USER=$2
# Name of repo to create
REPO=$3

if [ -z "$USER" ] || [ -z "$REPO" ] || [ -z "$FOLDER" ];
then
echo
echo "Usage: sh "$ME" <FOLDER> <USER> <REPO>"
echo "example: sh "$ME" my_folder ET-CS new-repo"
echo
echo "returns GitHub JSON output"
exit
fi;

#Create repo
echo "Create GitHub repo"
sh create-github-repo.sh $USER $REPO

#Sync to folder
cd $FOLDER
if [ -d ".git" ]; then
echo "Syncing exist git"
git remote add origin git@github.com:$USER/$REPO.git
git push origin master
else
if [ ! -f "README.md" ]; then
echo "no README.md found."
# Uncomment to generate README.md for each new repo who don't have README.md file
#echo "generating README.md..."
#echo "$REPO"  > README.md 
#echo "========" >> README.md
fi;
if [ ! -f "LICENSE" ]; then
echo "no LICENSE found."
# Uncomment to download GPL3 LICENSE for each new repo who don't have LICENSE file
#echo "download GPL3 LICENSE..."
#wget http://www.gnu.org/licenses/gpl.txt
#mv gpl.txt LICENSE
fi;
echo "Creating new git and syncing"
git init
git remote add origin git@github.com:$USER/$REPO.git
git add .
git commit -a -m "Initial commit"
git push origin master

# uncomment to set tag for all the folders
#git tag -a 1.0 -m 'verion 1.0'
#git push origin master --tags

fi
