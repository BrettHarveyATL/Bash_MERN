#mern_project
# Bash_MERN
Automates the creation of  full stack web application in MERN

CURRENT KNOW BUGS:  If using script to create models, on client/src/views/AllProducts beginning on line 38 will be the models attributes, Will need to move all <th></th> to line 18 and <td></td> to line 26.

Steps before use. 

1. Ensure node.js is install and updated both node and npm.
2. Ensure nodemon is install globally, npm install -g nodemon
3. Ensure mongo database is running in a seperate terminal, follow your distro/os instruction for running mongoDB
4. Create a directory you would like the MERN app to be in.
5. cd dir
6. refer to the directory you stored the bash script and run: bash dir/createMern.sh bash createMern.sh (if in local dir of mern project)
