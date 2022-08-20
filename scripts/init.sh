#!/bin/sh

GIT_ROOT_DIR=pull-req-merge-experiments

cat << STEP
mkdir $GIT_ROOT_DIR
$GIT_ROOT_DIR
git init

gh repo create $GIT_ROOT_DIR \ # GitHub上のレポジトリ名 $GIT_ROOT_DIR
  --public \      # public レポジトリ
  --source=. \    # ローカルレポジトリのパス
  --remote=origin # リモートレポジトリをoriginに指定

STEP
