cp -a /etc/apt/sources.list /etc/apt/sources.list.bak
sed -i "s@http://.*archive.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list
sed -i "s@http://.*security.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list
apt update
apt install -y vim curl openssh-server ca-certificates gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose
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
