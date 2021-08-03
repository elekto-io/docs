#Copyright 2018 Google LLC
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#
#    https://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.
#

set -e  # If a command fails then the deploy stops
printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

if [ "`git status -s`" ]
then
    echo "The working directory is dirty. Please commit any pending changes."
    exit 1;
fi

echo "Deleting old publication"
rm -rf docs
mkdir docs
git worktree prune
rm -rf .git/worktrees/docs/

echo "Generating site"
hugo
echo "elekto.dev"> docs/CNAME

echo "Updating gh-pages branch"
git add docs && git commit -m "Publishing to github (deploy.sh)"

echo "Pushing to github"
git push --all
