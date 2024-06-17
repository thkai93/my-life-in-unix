# Source SEED project

To create a custom directory and helper functions that can be replicated on all unix based machine

### Proposed directory structure

myProject 
\_`assets/`: additional assets like images, style sheets, etc 
\_`bin/`: executable scripts and binaries
\_`config/`: configuration files
\_`docs/`: documents like pdf xlsx docx
\_`logs/`: log files
\_`tmp/`: temporary file storage for all incoming files
\_`lib/`: external libraries or dependencies
\_`dist/`: distribution or build outputs
\_`notes/`: personal or project notes
\_`secret/`: secret files 


### Helper scripts
1. git fetch all
	- the script reside in /bin directory and will auto fetch all repo in git
2. move tmp
	- the script reside in /bin directory and will move all file in the tmp folder in to respective folder depending on the file type
3. create markdown notes
4. list all notes that match the follow pattern in desc order
5. open any pdf excel word from docs using a function in docs dir
6. check tmp dir if there is any file and alert me
