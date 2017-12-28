#nstall odoo
README
sudo service odoo start && sudo service postgresql start
sudo service odoo restart && sudo service postgresql restart
# wget -O - https://nightly.odoo.com/odoo.key | apt-key add -
# echo "deb http://nightly.odoo.com/10.0/nightly/deb/ ./" >> /etc/apt/sources.list.d/odoo.list
# apt-get update && apt-get install odoo

netstat -panut | grep LISTEN
sudo service odoo start
odoo.py scaffold blog  ./blog/

#OPEN ROOT 
sudo su

#bash cd /etc/odoo
cd /etc/odoo

#edit add
vi openerp-server.conf
--xmlrpc-port <port>
    xmlrpc_port = 8080
    
#bash in root    <_
cd /var/log/odoo/  |
tail odoo-server.log       |
                   |
#psql             _|
psql postgres


#start db in root frest ( sudo su ) and teyp in bash command
service postgresql start

su - postgres

/etc/odoo

psql postgres
sql> \du
                             List of roles
 Role name |                   Attributes                   | Member of 
-----------+------------------------------------------------+-----------
 postgres  | Superuser, Create role, Create DB, Replication | {}
 ubuntu    | Superuser, Create role, Create DB              | {}
 
CREATE ROLE odoo WITH PASSWORD 'odoo01' SUPERUSER;
sql> ALTER ROLE odoo WITH LOGIN; & Superuser
\q
exit
in root 
service postgresql stop
service postgresql start

#################

#edit add
vi openerp-server.conf
--xmlrpc-port <port>
    xmlrpc_port = 8080
    
[options] 
; This is the password that allows database operations:
; admin_passwd = admin
db_host = False
db_port = False
db_user = odoo
db_password = odoo01
addons_path = /usr/lib/python2.7/dist-packages/openerp/addons 
xmlrpc_port = 8080 

### utf-8 Error

    su - postgres
    psql postgres
    
sql> UPDATE pg_database  set datistemplate = FALSE WHERE datname = 'template1';
sql> DROP  database template1 ;
sql> CREATE DATABASE template1 with template = template0 encoding = 'unicode';
sql> UPDATE pg_database  set datistemplate = true WHERE datname = 'template1';
sql> \c template1
sql> vacuum freeze;
\q