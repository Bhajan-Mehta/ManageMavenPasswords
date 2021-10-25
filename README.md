# Maven Setting Passwords

You might need to store some passwords in settings.xml file to download required dependencies from non-publiic repositories, which can be downloaded from authorised persons only. 

It is highly recommended that you should store passwords in the encrypted format rather in the plain text. Because:
1. You might need to share setting.xml file to any other team mate,
2. Sometimes, you need to screen share with some one and if you need to share/show setting.xml file.

In both of the above cases, you don't need to worry about your passwords, if those are stored in the encrypted formats rahter then in the plain texts.

# Pre-Requisite
You need to run this shell script on any linux supported command prompt, if you are using windows machine.
Like: Git Bash.

This scripts needs to run from the .m2 direcroty, so make sure, you do have admin rights to copy file to the .m2 directory.

# How to execute:

1. Copy the 'encrypt-passwords.sh' file from the 'MavenSettingPasswords' directory (in the repo) to .m2 directory in your profile.
2. Open command-line interface (like Git Bash) and change directory to the location where 'encrypt-passwords.sh' exists.
3. Execute 'encrypt-passwords.sh' (For windows, you might need to use **./encrypt-passwords.sh**)

# Issues:
Please share your feedback, if you find any issues with this.
