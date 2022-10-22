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

![CacheClear](https://user-images.githubusercontent.com/77220782/197309665-354a0e99-5459-4d8d-ab02-870c74f1435c.jpg)

This option deletes the contents of Windows cache folders to clear free storage and speed up the computer using the del commands.

![Scans](https://user-images.githubusercontent.com/77220782/197309728-1f5fb86d-c8a2-47de-a61c-b6570a433fab.jpg)

These options run Windows corruption checking/restoring commands (basic DISM (Deployment Image Servicing and Management)), advanced DISM (if the windows update service is broken).

The difference between DISM and SFC is that DISM restores problems with the system image and SFC restores problems with the windows installation. 

![OpenProg](https://user-images.githubusercontent.com/77220782/197309863-7a0c90ea-2be0-4218-9303-0830d2cbf29a.jpg)

These options open useful Windows troubleshooting applications (Disk Cleanup, Defragment and Optimize Drives, Performance Monitor, Task Manager respectively)

![dns](https://user-images.githubusercontent.com/77220782/197309919-34cb3e6c-0ccc-42b4-97f1-4272905d9da1.jpg)



![end](https://user-images.githubusercontent.com/77220782/197309925-53154448-e14f-45b4-bde2-ca9b4994dd59.jpg)

Demonstration:
