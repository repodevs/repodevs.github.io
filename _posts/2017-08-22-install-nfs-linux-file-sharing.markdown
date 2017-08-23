---
title:  "Tutorial Install NFS Linux File Sharing di CentOS & Ubuntu"
date: 2017-08-22 08:00
categories: [linux, server]
tags: [sharing, linux, servering]
---

Assalamu'alaykum   
Saya kali ini akan berbagi catatan tentang sharing file antar linux dengan berbeda jaringan.

Sebenarnya ada beberapa cara untuk sharing file yang berbeda jaringan pada linux, tetapi kali ini saya akan menulis tentang sharing file menggunakan NFS.

Apa sih sebenarnya NFS itu?

*[Network File System (NFS)](https://en.wikipedia.org/wiki/Network_File_System)* is a distributed file system protocol originally developed by Sun Microsystems in 1984,[1] allowing a user on a client computer to access files over a computer network much like local storage is accessed. NFS, like many other protocols, builds on the Open Network Computing Remote Procedure Call (ONC RPC) system. The NFS is an open standard defined in Request for Comments (RFC), allowing anyone to implement the protocol.

Jadi bahasa mudahnya, NFS adalah sebuah system yang di rancang oleh Sun Microsystems pada tahun 1984. yang fungsinnya digunakan untuk sharing files antar jaringan komputer.

Pada tutorial kali ini saya menggunakan CentOS untuk master nya, dan menggunakan Ubuntu untuk slave nya, kurang lebih begini:

 - NFS Server:
    - OS: **CentOS 7**
    - IP: **45.76.163.12**

 - NFS Client:
   - OS: **Ubuntu 16.04**
   - IP: **45.76.113.15**

Untuk merubah konfigurasi saya akan menggunakan text editor ```nano```, jadi pastikan terinstall terlebih dahulu pada kedua server

```bash
# Pada CentOS
[root@master ~]# yum -y install nano

# Pada Ubuntu
root@slave1:~# apt-get install nano -y
```

### konfigurasi Firewall pada CentOS
Disini saya akan menggunakan firewall di server (CentOS), jika firewall belum terinstall maka install terlebih dahulu

```bash
[root@master ~]# yum -y install firewalld
```

Setelah terinstall, jalankan servicenya dan tambahkan autostart saat booting.

```bash
[root@master ~]# systemctl start firewalld.service
[root@master ~]# systemctl enable firewalld.service
```

Selanjutnya buka port untuk SSH dan NFS port agar client kita bisa terhubung dengan server nantinya.

```bash
[root@master ~]# firewall-cmd --permanent --zone=public --add-service=ssh
[root@master ~]# firewall-cmd --permanent --zone=public --add-service=nfs
[root@master ~]# firewall-cmd --reload
```

### Menginstall NFS pada CentOS

lakukan install nfs dengan menjalankan perintah

```bash
[root@master ~]# yum -y install nfs-utils
```

kemudian jalankan servicenya

```bash
[root@master ~]# systemctl enable nfs-server.service
[root@master ~]# systemctl start nfs-server.service
```

### konfigurasi folder yang akan di share

Disini saya akan meng-share 2 folder, yaitu ```/home/repodevs``` dan ```/var/nfs```.

Ketika client kita mengkases komputer server, secara default akan menggunakan user ```nfsnobody```. kecuali folder ```/home/repodevs``` ini biasanya folder tersebut tidak dimiliki atau dibuat oleh ```nfsnobody``` (dan saya tidak menyarakan untuk merubah owner nya menjadi ```nfsnobody```). dan karena disini kita akan membaca dan menulis di folder ```/home/repodevs``` maka kita akan memerintahkan NFS untuk mengkases folder tersebut sebagai ```root```. dan pada contoh ini folder ```/var/nfs``` belum ada. maka kita buat terlebih dahulu

```bash
[root@master ~]# mkdir /var/nfs
[root@master ~]# chown nfsnobody:nfsnobody /var/nfs/
[root@master ~]# chmod 755 /var/nfs/
```
Kemudian kita konfigurasi ```/etc/exports```, di file inilah kita akan menentukan folder mana yang akan di share.

```bash
[root@master ~]# nano /etc/exports

### ISI FILE `/etc/exports`
...
/home/repodevs        45.32.113.15(rw,sync,no_root_squash,no_subtree_check)
/var/nfs        45.32.113.15(rw,sync,no_subtree_check)
...
```

IP yang dimasukan disana, adalah IP target / IP client kita.   
Dan opsi ```no_root_squash``` adalah yang membuat folder kita akan di akses sebagai root

Setiap kali kita merubah file ```/etc/exports``` kita harus menjalankan perintah berikut, ini perlukan agar konfigurasi kita berjalan secara efektif.

```bash
[root@master ~]# exportfs -a
```

## Melakukan Konfigurasi Client (Ubuntu 16.04)

Install NFS pada client

```bash
root@slave1:~# apt install nfs-common
```

selanjutnya kita buat folder tempat dimana kita akan ```mount``` NFS kita.

```bash
root@slave1:~# mkdir -p /mnt/nfs/home/repodevs
root@slave1:~# mkdir -p /mnt/nfs/var/nfs
```

Setelah itu lakukan ```mount``` NFS kita ke folder tersebut.

```bash
root@slave1:~# mount 45.76.163.12:/home/repodevs /mnt/nfs/home/repodevs
root@slave1:~# mount 45.76.163.12:/var/nfs /mnt/nfs/var/nfs/
```

Sekarang kita cek hasil ```mount``` kita.

```bash
root@slave1:~# df -h
Filesystem             Size  Used Avail Use% Mounted on
udev                   477M     0  477M   0% /dev
tmpfs                  100M  3.1M   97M   4% /run
/dev/vda1               25G  1.8G   22G   8% /
tmpfs                  497M     0  497M   0% /dev/shm
tmpfs                  5.0M     0  5.0M   0% /run/lock
tmpfs                  497M     0  497M   0% /sys/fs/cgroup
tmpfs                  100M     0  100M   0% /run/user/0
45.76.163.12:/var/nfs   25G  1.3G   23G   6% /mnt/nfs/var/nfs
```

### TESTING

Setelah semua konfigurasi sudah selesai, selanjutnya kita lakukan testing.

```bash
root@slave1:~# cd /mnt/nfs/var/nfs/
root@slave1:/mnt/nfs/var/nfs# ls
root@slave1:/mnt/nfs/var/nfs# touch hallooo
root@slave1:/mnt/nfs/var/nfs# ls
hallooo
[root@master ~]# ls
hallooo
```

### Mount NFS pada setiap boot

selanjutnya kita akan membuat NFS kita _automount_ setiap server kita booting.

```bash
root@slave1:/mnt/nfs/var/nfs# nano /etc/fstab

....
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
# / was on /dev/vda1 during installation
....
45.76.163.12:/home/repodevs	/mnt/nfs/home/repodevs/	nfs	rw,sync,hard,intr  0	0
45.76.163.12:/var/nfs	/mnt/nfs/var/nfs/	nfs	rw,sync,hard,intr  0	0
....
```
selain pilihan  _rw,sync,hard,intr_ kamu dapat memilih cara mounting yang lain.
silahkan lihat ```man mount``` untuk melihat pilihan yang lain


untuk menguji apakah automount mu sudah berjalan atau belum. lakukan reboot server (ubuntu 16.04) mu.


```bash
root@slave1:/mnt/nfs/var/nfs# reboot
```

cek hasilnya menggunakan

```
root@slave1:/mnt/nfs/var/nfs# df -h
Filesystem             Size  Used Avail Use% Mounted on
udev                   477M     0  477M   0% /dev
tmpfs                  100M  3.1M   97M   4% /run
/dev/vda1               25G  1.8G   22G   8% /
tmpfs                  497M     0  497M   0% /dev/shm
tmpfs                  5.0M     0  5.0M   0% /run/lock
tmpfs                  497M     0  497M   0% /sys/fs/cgroup
tmpfs                  100M     0  100M   0% /run/user/0
45.76.163.12:/var/nfs   25G  1.3G   23G   6% /mnt/nfs/var/nfs
```

Selesai !!!

Sekian Tutorial kali ini, See you and stay tune !!! :D
