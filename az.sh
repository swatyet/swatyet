yum install -y gcc openldap-devel pam-devel openssl-devel
yum install -y iptables
yum update iptables
yum install -y iptables-services
wget http://jaist.dl.sourceforge.net/project/ss5/ss5/3.8.9-8/ss5-3.8.9-8.tar.gz
tar -vzx -f ss5-3.8.9-8.tar.gz
mv ss5-3.8.9/ ss
cd ss
./configure  &&  make  &&  make  install
chmod a+x /etc/init.d/ss5
vi /etc/opt/ss5/ss5.conf