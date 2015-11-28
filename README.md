# Global git status script
This script checks if there are any uncommitted changes in any of your local GIT repositories and sends an email with the repository directories that contain uncommitted changes.

## Requirements
In order to work, this script requires that you have `swaks` installed.

## Configuration
To get the script working, you need to rename the `.env.example` file to `.env`and adjust the variables contained in it:
- `GIT_SEARCH` - The base path within to search for local GIT repositories. Set to `/` to search everywhere
- `SMTP_HOST` - The SMTP host from where to send the email.
- `SMTP_USER` - The username used to authenticate with the SMTP host
- `SMTP_PASSWORD` - The password used to authenticate with the SMTP host
- `EMAIL_TO` - The email to send the email to
- `EMAIL_FROM` - The email to send the email from. Usally the same as `SMTP_USER`

## Cron job
To call the script on a daily base (right before you quit work), create a cronjob with `crontab -e` and insert the following line:
```
45 16 * * * sh /full/path/to/script/global-git-status/global-git-status.sh
```
This creates a crob job that executes the script, in this example at 16:45.

In order to work a cron, make sure the script can be execute as sudo without a password promt. To archive this, add a new rule to your sudoers file by typing `sudo visudo` and add the following line:
```
username ALL= NOPASSWD: /full/path/to/script/global-git-status.sh
```
