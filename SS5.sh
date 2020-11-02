#!/bin/bash
sed -i 's/\r//' ip.txt
y=$(cat ip.txt|head -n1)
n=$[(y-1)*6+1]
ip1=$(cat ip.txt|sed -n 2p)
ip2=$(cat ip.txt|sed -n 3p)
service ss5 stop
for((x=1;x<=2;x++));
do
    for((i=4;i<=6;i++));
        do
            for((j=n;j<n+3;j++));
                do
                pa=$(shuf -n1 pass.txt)
                        if [ $n -lt 10 ]
then
 us=$i'00'$j
useradd $us -p $pa
	     
                    echo $us $pa >>/etc/opt/ss5/ss5.passwd.txt
                        else
 us=$i'0'$j
useradd $us -p $pa
echo $us >>user.txt
 echo $us $pa >>/etc/opt/ss5/ss5.passwd.txt
fi
                done
       done
n=$[n+3]
done
for ((i=1;i<=18;i++));
do
users=$(cat user.txt|sed -n $i'p')
iptables -t mangle -A OUTPUT -m owner --uid-owner '100'$i -j MARK --set-mark '100'$i
if [ $i -lt 10 ]
then
iptables -t nat -A POSTROUTING -m mark --mark '100'$i -j SNAT --to-source $ip1
  ss5 -u $users -b $ip1
else
iptables -t nat -A POSTROUTING -m mark --mark '100'$i -j SNAT --to-source $ip2
   ss5 -u $users -b $ip2
fi
done
service ss5 start
service iptables save
systemctl restart iptables.service