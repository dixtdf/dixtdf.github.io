cp -a /etc/apt/sources.list /etc/apt/sources.list.bak
sed -i "s@http://.*archive.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list
sed -i "s@http://.*security.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list
apt update
apt install -y vim curl openssh-server
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl restart sshd
cp /etc/pam.d/gdm-password /etc/pam.d/gdm-password.bak
cp /etc/pam.d/gdm-autologin /etc/pam.d/gdm-autologin.bak
sed -i "s/^[^#].*quiet_success$/#&/g" /etc/pam.d/gdm-password
sed -i "s/^[^#].*quiet_success$/#&/g" /etc/pam.d/gdm-autologin
cp /root/.profile /root/.profile.bak
sed -i '/mesg/s/^/#/' /root/.profile
{
  echo "tty -s && mesg m || true"  
} >> /root/.profile
