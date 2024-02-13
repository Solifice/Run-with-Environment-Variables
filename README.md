# Run with Environment Variables

## **Use at your own risk. I am not responsible for any consequences.**

## About
Today, there are multiple software and apps available for use, either through installers or as standalone versions. Installer versions require undergoing a formal installation process, resulting in permanent changes to the Windows registry and program files. However, uninstalling these versions may not always remove all components properly, leading to unnecessary space consumption and occasional system slowdowns. Regularly engaging in this process can potentially corrupt the Windows system in the future.

On the other hand, portable or standalone versions of software and apps offer significant advantages over installer versions. They do not make any changes to the operating system; they only occupy space where the files are extracted. This simplicity allows for easy usage. When no longer needed, users can simply delete the extracted files. Another major advantage is that we can take these apps on a USB drive and use them on any PC.

However, some apps provide a portable version or zip distribution, yet they are not entirely portable. They might still save certain dependent files on the system.

**Run with Environment Variables** is a batch script designed to address these issues, but it can only resolve them if they can be fixed by modifying environment variables.

## Limitations
- Since it's a batch file, it will only work on Windows systems.

## Download
The script can be downloaded by either cloning it or downloading it from the releases section.

## Installation & Quick Start
1. This script does not require any formal installation process.
2. Feel free to copy and paste the batch script anywhere you'd like.
3. Open the batch file using any text editor of your choice.
4. Navigate to the "USER CONFIGURATION PART I" section and specify the values for "PROGRAM_EXECUTABLE_PATH" and "PROGRAM_NAME".
5. Scroll down to the "USER CONFIGURATION PART II" section and configure the necessary environment variables according to your requirements.
6. Refer to the examples provided in the batch file itself to set the environment variables as required in the "USER CONFIGURATION PART I" and "USER CONFIGURATION PART II" section.
7. Save the changes and close the file.
8. If any invalid environment variables are detected, the script will display appropriate errors upon execution, and the application will not start until the issue is resolved.
9. Now, simply double-click the batch file, and you're all set! The program will start with the modified environment variables.

## Contributions
- Report bugs, ask questions and suggest new features by creating a new issue.
- Donate to [**Solifice**](https://linktr.ee/solifice).

## Credits
This script is written in batch and utilizes batch scripting for automation. We acknowledge and appreciate the functionality provided by batch scripting.
