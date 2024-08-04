# git commands

# to start switch to inside the folder
git init

# check status
git status

# switch git to main (-b branch)
git checkout -b main

# after you''ve created a file, start tracking it
# this will move it to staging
git add README.md

# to commit (-m message)
git commit -m "Initial commit"

# see commit history
git log

# create a git branch (!!important - NO SPACES!!!!)
git branch <branch_name>

# to view all the git commits in a single line (simplified)
git log # oneline

# to view the branches
git branch

# to merge
git merge <branch_name>

# to delete a branch
git branch -d <branch_name>

# combo => create a new branch and switch to it
git checkout -b feat/add-drop-table-reference

# to switch back to an existing branch i.e. main
git checkout main

# while i was busy with a feature
# a fix went into main
# i need to pull these fixes into my feature that i'm working on

# first we switch to feat branch
git checkout <feat_branch_name>
# then rebase from main
git rebase main

# resolve conflicts in the file by amending it
# then continue
git rebase # continue

# when making changes on a branch you can stash them
git stash

# to view the stash
git stash list

# to add the stash changes back
git stash pop

# to view full changes of the latest stash (-p patch)
git stash show -p

# add the latest stash while keeping it in the list
git stash apply