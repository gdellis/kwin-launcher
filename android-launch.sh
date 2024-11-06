 #!/bin/bash

TOP=$(dirname $0)
APP="$1"

pre_check() {
    echo "Running pre_check..."

    echo "Check if waydroid exists"
    if [ ! -f /usr/bin/waydroid ]; then
        kdialog --sorry "Cannot start Waydroid. Waydroid does not exist! \
        \nIf you recently performed a SteamOS update, then you also need to re-install Waydroid! \
        \nLaunch the Waydroid install script again to re-install Waydroid! \
        \nSteamOS version: $(cat /etc/os-release | grep -i VERSION_ID | cut -d "=" -f 2) \
        \nKernel version: $(uname -r | cut -d "-" -f 1-5)"
        exit
    fi

    # stop and start the waydroid container
    sudo /usr/bin/waydroid-container-stop
    sudo /usr/bin/waydroid-container-start
    echo "Checking the status of the waydroid container service.."
    systemctl status waydroid-container.service | grep -i running
    if [ $? -eq 0 ]; then
        echo All good continue with the script.
    else
        kdialog --sorry "Something went wrong. Waydroid container did not initialize correctly."
        exit
    fi
}

pre_check 
sudo waydroid session start
/usr/bin/startplasma-steamos-oneshot "/usr/bin/waydroid app $APP"
sudo waydroid session stop
