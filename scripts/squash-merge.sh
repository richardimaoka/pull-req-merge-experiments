#!/bin/sh
MAIN_BRANCH="development"

FILE="pull-req-squash-merge.txt"
BRANCH1="pr-squash-merge-1"
BRANCH2="pr-squash-merge-2"
PR_MERGE_STYLE="squash"

cat << STEP 
cat << EOF > $FILE
a

b

c
EOF
git add --all
git commit -m "create $FILE"
git push origin $MAIN_BRANCH


git switch -c $BRANCH1
sed -i 's/a/aaaaa/' $FILE # ファイル中のaをaaaaaに置き換え
git add --all
git commit -m "update a in $BRANCH1"

# GitHubにPull Requestを作成
git push --set-upstream origin $BRANCH1
gh pr create --title $BRANCH1 --body "" --base $MAIN_BRANCH --head $BRANCH1

git switch -c $BRANCH2 $MAIN_BRANCH
sed -i 's/b/bbbbb/' $FILE # ファイル中のcをcccccに置き換え
git add --all
git commit -m "update b in $BRANCH2"
sed -i 's/c/ccccc/' $FILE # ファイル中のcをcccccに置き換え
git add --all
git commit -m "update c in $BRANCH2"

# GitHubにPull Requestを作成
git push --set-upstream origin $BRANCH2
gh pr create --title $BRANCH2 --body "" --base $MAIN_BRANCH --head $BRANCH2

gh pr merge $BRANCH1 --$PR_MERGE_STYLE --delete-branch

gh pr merge $BRANCH2 --$PR_MERGE_STYLE --delete-branch

# GitHub 側で更新された main ブランチを pull
git switch $MAIN_BRANCH
git pull origin $MAIN_BRANCH

git log --oneline --decorate --graph
STEP