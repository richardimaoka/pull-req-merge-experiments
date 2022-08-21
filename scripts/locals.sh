#!/bin/sh

MAIN_BRANCH="main"
FILE="local-no-ff.txt"
BRANCH="local-no-ff-1"
cat << STEP 
touch $FILE
git add --all
git commit -m "create $FILE"

git switch -c $BRANCH
echo a > $FILE
git add --all
git commit -m "add a in branch $BRANCH"
echo b >> $FILE
git add --all
git commit -m "add b in branch $BRANCH"

git switch $MAIN_BRANCH
git merge --no-ff --no-edit $BRANCH # ローカル環境でのno-ffマージ
git branch -d $BRANCH

git push origin $MAIN_BRANCH

git log --oneline --decorate --graph
STEP

FILE="local-ff.txt"
BRANCH="local-ff-1"
cat << STEP
touch $FILE
git add --all
git commit -m "create $FILE"

git switch -c $BRANCH
echo a > $FILE
git add --all
git commit -m "add a in branch $BRANCH"
echo b >> $FILE
git add --all
git commit -m "add b in branch $BRANCH"

git switch $MAIN_BRANCH
git merge $BRANCH # ローカル環境でのfast-forwardマージ
git branch -d $BRANCH

git push origin $MAIN_BRANCH

git log --oneline --decorate --graph
STEP