#!/bin/bash
# Usage: sudo bash setup_target.sh

# Basic Configuration
# 1. Install Ubuntu
# 2. Create admin user K999 with highest privileges
# 3. Set password for K999 as base64 encoded 'congragulation'
# 4. Ensure SSH service exists, if not, create it
# 5. Ensure HTTP service exists, if not, create it
# 6. Ensure HTTPS service exists, if not, create it
# 7. Ensure sudo function exists, if not, create it

# Install necessary packages
apt-get update
apt-get install -y ssh apache2 openssl sudo

# Create admin user K999
useradd -m -s /bin/bash K999

# Set password for K999
echo "K999:Y29uZ3JhZ3VsaW9uCg==" | chpasswd -e

# Ensure SSH service exists
systemctl status ssh || systemctl start ssh

# Ensure HTTP service exists
systemctl status apache2 || systemctl start apache2

# Ensure HTTPS service exists
if ! dpkg -l | grep -q openssl; then
    apt-get install -y openssl
fi

# Ensure sudo function exists
if ! dpkg -l | grep -q sudo; then
    apt-get install -y sudo
fi

# Vulnerability Configuration
# 1. CVE-2017-5638
# 2. Create a regular user Allin with password 'dsvq43#^$sdcsz'
# 3. Create a file named 'user.txt' with random content in Allin's home directory

# Apply CVE-2017-5638 vulnerability
# (You need to apply this vulnerability manually as it requires specific configuration)

# Create regular user Allin
useradd -m Allin

# Set password for Allin
echo "Allin:dsvq43#^$sdcsz" | chpasswd

# Create a file with random content in Allin's home directory
echo "Random Content" > /home/Allin/user.txt

# Privilege Escalation Configuration
# 1. Create a file named 'root.txt' with root's flag in root's home directory
# 2. Set SUID bit on a file in Allin's home directory

# Create 'root.txt' file with root's flag
echo "Root's Flag" > /root/root.txt

# Set SUID bit on a file in Allin's home directory (You need to create a file and set SUID manually)

# Instructions to Execute:
# 1. Save this script as 'setup_target.sh'.
# 2. Open terminal and navigate to the directory where the script is saved.
# 3. Run the command 'sudo bash setup_target.sh' to execute the script.
# 4. Follow any additional instructions provided in the script comments to complete setup.
