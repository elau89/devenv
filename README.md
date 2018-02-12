Eric's custom Docker development environment

Usage
===============
Only two manual steps are needed for setup:
- Create a file named gituser.txt and set it with your user name and email to
  append to your .gitconfig file
- (optional) Create an alias to this repository and call make with it to start
  up the environment: `cd ~/.devenv && make 2>&1 | tee make.out`
