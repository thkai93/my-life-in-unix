# macOS Terminal Guide

## Basics
1. **Opening Terminal**: You can open Terminal by going to Applications > Utilities > Terminal or by using Spotlight (Cmd + Space and type "Terminal").

2. **Basic Navigation Commands**:
   - `pwd`: Print Working Directory. Shows the current directory path.
   - `ls`: List directory contents.
     - `ls -l`: Long format listing.
     - `ls -a`: Include hidden files.
   - `cd [directory]`: Change directory.
     - `cd ..`: Move up one directory.
     - `cd ~`: Go to the home directory.

3. **File Manipulation Commands**:
   - `touch [filename]`: Create a new empty file.
   - `cat [filename]`: Concatenate and display file contents.
   - `cp [source] [destination]`: Copy files or directories.
   - `mv [source] [destination]`: Move or rename files or directories.
   - `rm [filename]`: Remove (delete) files.
     - `rm -r [directory]`: Remove directories and their contents recursively.

4. **Text Editing**:
   - `nano [filename]`: Open a simple text editor within the terminal.
   - `vi [filename]` or `vim [filename]`: Open the Vi or Vim text editor.

## Advanced Commands
1. **Searching and Finding Files**:
   - `find [directory] -name [filename]`: Search for files by name.
   - `grep [pattern] [file]`: Search for a specific pattern within a file.
     - `grep -r [pattern] [directory]`: Search recursively in a directory.

2. **Permissions**:
   - `chmod [permissions] [file]`: Change file permissions.
     - Example: `chmod 755 [file]`: Read, write, and execute for the owner, and read and execute for others.
   - `chown [owner]:[group] [file]`: Change file owner and group.

3. **Networking**:
   - `ping [hostname]`: Check connectivity to a host.
   - `ifconfig`: Display network interfaces.
   - `ssh [user]@[host]`: Connect to a remote host via SSH.

4. **Process Management**:
   - `ps`: Display currently running processes.
   - `top`: Display and manage running processes.
   - `kill [PID]`: Kill a process by its Process ID (PID).
     - `kill -9 [PID]`: Force kill a process.

5. **Package Management with Homebrew**:
   - Install Homebrew: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
   - `brew install [package]`: Install a package.
   - `brew update`: Update Homebrew.
   - `brew upgrade`: Upgrade all installed packages.

6. **Scripting**:
   - Create a script: Use a text editor to write a script and save it with a `.sh` extension.
   - Make it executable: `chmod +x [script.sh]`
   - Run the script: `./[script.sh]`

## Customization
1. **Profiles**: Customize Terminal appearance and behavior by going to Terminal > Preferences > Profiles.
2. **Aliases**: Create shortcuts for commands by adding `alias [name]='[command]'` to your `~/.bash_profile` or `~/.zshrc` file.
3. **Environment Variables**: Set environment variables in `~/.bash_profile` or `~/.zshrc`:
   - `export PATH=$PATH:/new/path`: Add a directory to the PATH.

## Useful Shortcuts
1. **Cmd + T**: Open a new tab.
2. **Cmd + N**: Open a new window.
3. **Cmd + K**: Clear the screen.
4. **Ctrl + C**: Cancel the current command.
5. **Ctrl + A**: Move the cursor to the beginning of the line.
6. **Ctrl + E**: Move the cursor to the end of the line.
7. **Tab**: Auto-complete file and directory names.

## Learning Resources
1. **Man Pages**: Use the `man [command]` to read the manual for a command.
2. **Online Tutorials**: Websites like Codecademy, freeCodeCamp, and others offer tutorials on shell scripting and Unix commands.
3. **Books**: Books like "The Linux Command Line" by William Shotts provide comprehensive guides.

