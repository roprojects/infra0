#**************************************
#Run it in case of Debian clean install
#**************************************
su root -c "apt update && apt install sudo"

export PATH="/sbin:"$PATH

echo "export PATH=\"/sbin:\"\$PATH" >> $HOME/.bashrc
echo "export PATH=\"/sbin:\"\$PATH" | sudo tee -a /root/.bashrc

sudo usermod -a -G sudo debian
#**************************************
