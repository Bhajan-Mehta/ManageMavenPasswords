# Encrypt plain texts passwords in settings.xml file for maven

You might need to store some passwords in settings.xml file to download required dependencies from non-publiic repositories, which can be downloaded from authorised persons only. 

It is highly recommended that you should store passwords in the encrypted format rather in the plain text. Because:
1. You might need to share setting.xml file to any other team mate,
2. Sometimes, you need to screen share with some one and if you need to share/show setting.xml file.

In both of the above cases, you don't need to worry about your passwords, if those are stored in the encrypted formats rahter then in the plain texts.

# Pre-Requisite
You need to run this shell script on any linux supported command prompt, if you are using windows machine.
Like: Git Bash.

This scripts needs to run from the .m2 direcroty, so make sure, you do have enough rights to copy file to the .m2 directory.

# How to execute?
Clone the repo and execute the script, simple as that.

Here are the steps, you need to follow:

1. Clone the repo _OR_ Copy the 'encrypt-passwords.sh' file from the 'MavenSettingPasswords' directory (in the repo) to .m2 directory in your profile.
2. Open command-line interface (like Git Bash) and change directory to the location where 'encrypt-passwords.sh' exists.
3. Execute 'encrypt-passwords.sh' (For windows, you might need to use **./encrypt-passwords.sh**) and follow the instructions.
4. And, it is done :)

```sh
git clone git@github.com:Bhajan-Mehta/MavenSettingPasswords.git
cd MavenSettingPasswords/
./encrypt-passwords.sh
```
## What would you expect after this?

Once execuution of the scripts completes:
1.  Backup file would be created in the .m2 directory. So, that you can use this if something doesn't work as expected.
2.  You should be able to see passwords of settings.xml files are changed to encrypted values in enclosed withn {}.
3.  You should be able to run maven build commands without any issues.

# Future Passwords change:
Update the password in the settings.xml file in the plain text (make sure '{' and '}' are removed/replaced with encrypted password) and re-run this script again. It will only update passwords those are in the plain text.

# Issues:
Please share your feedback, if you find any issues with this.
