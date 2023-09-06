##commands run

1. Create a folder and create a file called “team.txt” within that folder
   1. git init
   1. mkdir myrepo
   1. touch myrepo/team.txt
2. Modify “team.txt” to add a line with your favorite football team and commit
   that to the repo

   1. echo -e "favorite football team: na \niu" > myrepo/team.txt
   1. git add myrepo\*
   1. git README.md
      or
   1. git add .
   1. git commit -m "[new file] favorite team"

3. Create and push to your own remote repo (on Github) called “mylab2”
   1. manually create repo through web
   1. git remote add hci git@github.com:junl837/lab02.git
   1. git branch -M main
   1. git push -u hci main

##To check
git status
check staging area
git diff
git diff --cached
