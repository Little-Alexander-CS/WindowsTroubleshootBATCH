# WindowsTroubleshootBATCH

Project Title:

Windows 10/11 Troubleshooting shortrcut file

Project Sujmmary:

Created a windows batch file on Visual Studio Code that runs windows DISM and SFC corruption restoring commands along with other shortcuts to open common troubleshooting applications for convenience purposes. (Task Manager, Disk Part, Performance Monitor, etc). It is a batch script that utilizes Windows 10/11 or Windows Server. This project could be used within Azure Virtual Machines but was demonstrated on my main PC.

Media:

![ITProjectpt1](https://user-images.githubusercontent.com/77220782/197309112-b0619684-cf52-4754-a2ec-590c73585a29.jpg)

The implementation was started by adding a start menu for the program for getting the user to select what option to proceed with by typing a number from [1-10] (more to be added and restructured in the future). Then the variable 'choicevar' was created to save the number selected.

This variable along with the EQU (to check for equivalency) and a goto command is used to skip to the lines of the project nessessary for your choice instead of doing everything at once with no user input.

If an invalid option is typed, the program prompts the user to select another option and restarts.

Demonstration:
