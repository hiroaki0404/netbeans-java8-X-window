#!/bin/bash
echo 'pgrep uim-fep || uim-fep' >> /etc/skel/.bashrc
export LANG=C
CONUSER=${CUSER:-"docker"}
CONPASSWD=${CPASSWD:-"docker"}
/usr/sbin/useradd -m $CONUSER -G sudo -s /bin/bash
echo $CONUSER:"$CONPASSWD" | /usr/sbin/chpasswd
echo "Created user: $CONUSER"
IP=$(/sbin/ifconfig eth0 | awk -F : '/inet addr/{print $2;}' | cut -d ' ' -f 1)
echo "Container ip address: $IP"
/etc/init.d/dbus start
mkdir -m 0700 /home/$CONUSER/.ssh
mkdir /home/$CONUSER/.fonts
cp /tmp/font/Ricty*.ttf /home/$CONUSER/.fonts/
sudo -u $CONUSER fc-cache -vf

mkdir /var/run/sshd && /usr/sbin/sshd -D
