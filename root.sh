#!/bin/bash
#[AW01]
sudo -S sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | sudo -S fdisk /dev/sda  >> results.log
 n
 p
 1
    #\n
    #\n
t
8e
w
q
EOF

#sudo -S pvcreate /dev/sdb1 
#sudo -S vgcreate mongodb /dev/sdb1
#sudo -s lvcreate -n node0 -L 10g mongodb 
#sudo -s lvcreate -n node1 -L 10g mongodb 
#sudo -s lvcreate -n node2 -L 10g mongodb 