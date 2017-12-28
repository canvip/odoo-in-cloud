#!/bin/bash
################################################################################
# Script for installing Odoo on Ubuntu 14.04, 15.04 and 16.04 (could be used for other version too)
# Author: Yenthe Van Ginneken
#-------------------------------------------------------------------------------
# This script will install Odoo on your Ubuntu 16.04 server. It can install multiple Odoo instances
# in one Ubuntu because of the different xmlrpc_ports
#-------------------------------------------------------------------------------
# Make a new file:
# sudo nano odoo-install.sh
# Place this content in it and then make the file executable:
# sudo chmod +x install.sh
# Execute the script to install Odoo:
# ./install.sh 
################################################################################

##fixed parameters
#odoo
OE_USER="odoo"
OE_HOME="./$OE_USER"
OE_HOME_EXT="./$OE_USER/${OE_USER}"
#/usr/lib/python2.7/dist-packages/openerp/addons
#The default port where this Odoo instance will run under (provided you use the command -c in the terminal)
#Set to true if you want to install it, false if you don't need it or have it already installed.
INSTALL_WKHTMLTOPDF="True"
#Set the default Odoo port (you still have to use -c /etc/odoo-server.conf for example to use this.)
OE_PORT="8080"
#Choose the Odoo version which you want to install. For example: 11.0, 10.0, 9.0 or saas-18. When using 'master' the master version will be installed.
#IMPORTANT! This script contains extra libraries that are specifically needed for Odoo 11.0
OE_VERSION="10.0"
# Set this to True if you want to install Odoo 11 Enterprise!
IS_ENTERPRISE="False"
#set the superadmin password
OE_SUPERADMIN="admin"
OE_CONFIG="${OE_USER}"

##
###  WKHTMLTOPDF download links
## === Ubuntu Trusty x64 & x32 === (for other distributions please replace these two links,
## in order to have correct version of wkhtmltox installed, for a danger note refer to 
## https://www.odoo.com/documentation/8.0/setup/install.html#deb ):
WKHTMLTOX_X64=https://downloads.wkhtmltopdf.org/0.12/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb
WKHTMLTOX_X32=https://downloads.wkhtmltopdf.org/0.12/0.12.1/wkhtmltox-0.12.1_linux-trusty-i386.deb
#sudo npm install -g less less-plugin-clean-css -y && sudo ln -s /usr/bin/nodejs /usr/bin/node

echo -e "\n---- Creating the ODOO PostgreSQL User  ----"
sudo su - postgres -c "createuser -s $OE_USER" 2> /dev/null || true
sudo su - postgres -c "psql -c \"update pg_database set datallowconn = TRUE where datname = 'template0';\""
sudo su - postgres -c "psql -c \"drop database template1;\""
sudo su - postgres -c "psql -c \"create database template1 with template = template0 encoding = 'unicode';\""
sudo su - postgres -c "psql -d template0 -c \"update pg_database set datistemplate = TRUE where datname = 'template1';\""
sudo su - postgres -c "psql -c  \"\c template1;\""
sudo su - postgres -c "psql -d template0 -c \" vacuum freeze;\""
								
#--------------------------------------------------
# Install Wkhtmltopdf if needed
#--------------------------------------------------
if [ $INSTALL_WKHTMLTOPDF = "True" ]; then
  echo -e "\n---- Install wkhtml and place shortcuts on correct place for ODOO 10 ----"
  #pick up correct one from x64 & x32 versions:
  if [ "`getconf LONG_BIT`" == "64" ];then
      _url=$WKHTMLTOX_X64
  else
      _url=$WKHTMLTOX_X32
  fi
  sudo apt-get install gdebi-core
  sudo wget $_url
  sudo gdebi --n `basename $_url`
  sudo ln -s /usr/local/bin/wkhtmltopdf /usr/bin
  sudo ln -s /usr/local/bin/wkhtmltoimage /usr/bin
else
  echo "Wkhtmltopdf isn't installed due to the choice of the user!"
fi

#echo -e "\n---- Create ODOO system user ----"
#sudo adduser --system --quiet --shell=/bin/bash --home=$OE_HOME --gecos 'ODOO' --group $OE_USER
#The user should also be added to the sudo'ers group.
#sudo adduser $OE_USER sudo



#echo -e "\n---- Setting permissions on home folder ----"
#sudo chown -R $OE_USER:$OE_USER $OE_HOME/*

echo -e "* Create server config file"

sudo touch /etc/odoo/${OE_CONFIG}.conf
echo -e "* Creating server config file"

sudo su root -c "printf 'xmlrpc_port = ${OE_PORT}\n' >> /etc/odoo/${OE_CONFIG}.conf"
#sudo su root -c "printf 'addons_path=/home/ubuntu/workspace/backend_theme' >> /etc/${OE_CONFIG}.conf"


echo -e "* Start ODOO on Startup"
sudo service odoo stop && sudo service postgresql stop && sudo service odoo start && sudo service postgresql start


echo -e "* Starting Odoo Service"

echo "-----------------------------------------------------------"
echo "Done! The Odoo server is up and running. Specifications:"
echo "Port: $OE_PORT"
echo "User service: $OE_USER"
echo "User PostgreSQL: $OE_USER"
echo "Code location: $OE_USER"
echo "Addons folder: $OE_USER/$OE_CONFIG/addons/"
echo "Start Odoo service: sudo service $OE_CONFIG start"
echo "Stop Odoo service: sudo service $OE_CONFIG stop"
echo "Restart Odoo service: sudo service $OE_CONFIG restart"
echo "-----------------------------------------------------------"
