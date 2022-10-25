# WindowsTroubleshootBATCH

Project Title:

Windows 10/11 Troubleshooting Batch File

Project Summary:

Created a windows batch file on Visual Studio Code that runs windows DISM and SFC corruption restoring commands along with other shortcuts to open typical troubleshooting applications for convenience. (Task Manager, Disk Part, Performance Monitor, etc.). It is a batch script that can be used on Windows 10/11 or Windows Server. This project could be used within Azure Virtual Machines but was demonstrated on my main PC.

Media:

![ITProjectpt1](https://user-images.githubusercontent.com/77220782/197309112-b0619684-cf52-4754-a2ec-590c73585a29.jpg)

The implementation started by adding a start menu for the program to get the user to select what option to proceed with by typing a number from [1-10] (more to be added and restructured in the future). Then the variable 'choicevar' was created to save the number selected.

This variable along with the EQU (to check for equivalency) and a goto command is used to skip to the lines of the project nessessary for your choice instead of doing everything at once with no user input.

If an invalid option is typed, the program prompts the user to select another option and restarts.

![CacheClear](https://user-images.githubusercontent.com/77220782/197309665-354a0e99-5459-4d8d-ab02-870c74f1435c.jpg)

This option deletes the contents of Windows cache folders to clear free storage and speed up the computer using the del commands.

![Scans](https://user-images.githubusercontent.com/77220782/197309728-1f5fb86d-c8a2-47de-a61c-b6570a433fab.jpg)

These options run Windows corruption checking/restoring commands (basic DISM (Deployment Image Servicing and Management)), and advanced DISM (if the windows update service is broken).

The difference between DISM and SFC is that DISM restores problems with the system image, and SFC restores problems with the windows installation. 

![OpenProg](https://user-images.githubusercontent.com/77220782/197309863-7a0c90ea-2be0-4218-9303-0830d2cbf29a.jpg)

These options open useful Windows troubleshooting applications (Disk Cleanup, Defragment and Optimize Drives, Performance Monitor, and Task Manager, respectively).

![dns](https://user-images.githubusercontent.com/77220782/197309919-34cb3e6c-0ccc-42b4-97f1-4272905d9da1.jpg)

The first option flushes, renews, and displays DNS information.
The second option pings the loopback address and then a Cloudflare DNS server on the internet to check for connectivity problems.
It also displays the ipconfig /all command which can be used to check for invalid ip addresses and other issues.

![end](https://user-images.githubusercontent.com/77220782/197309925-53154448-e14f-45b4-bde2-ca9b4994dd59.jpg)

All options jump to this end text which asks the user to press 1 to return to the start or anything else to end the program.

Demonstration:

![Imp1](https://user-images.githubusercontent.com/77220782/197838557-0a09f084-7a20-4edb-a30c-4c346efee915.png)

Once you run the batch file (as an administrator!), the main options menu appears, asking you to select an option to proceed.

![Imp2](https://user-images.githubusercontent.com/77220782/197838572-caf9eb3c-ee55-423a-8b31-dad07d316507.png)

Once a proper option is selected, it runs and then asks if you'd like to run another option or exit the program by pressing anything other than '1'.

![Imp3](https://user-images.githubusercontent.com/77220782/197838587-96e3a622-c640-4cc6-9646-79af9bee7b07.png)

If one is not pressed, the program ends.
