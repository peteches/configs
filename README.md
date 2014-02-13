simple enough execute the setup.sh script with the install argument eg:

    ./setup.sh install

from the repo root. This will set up symlinks to the relevant bits and peices.

    ./setup.sh update

will update any new configs brought in after git pull

Any existing configs you have will be backed up to a backups dir at the root of
the repo.

running

    ./setup.sh uninstall 

Will restore them to their correct location.
