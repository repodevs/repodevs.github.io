---
title:  "Real-Time monitoring linux server menggunakan netdata"
date: 2017-08-20 20:00
categories: [linux, server]
tags: [monitoring, linux, servering]
---

Halo apakabar temen-temen? Semoga baik-baik saja ya.
Kali ini saya akan menulis tentang monitoring linux server menggunakan netdata.

Sebenarnya apa sih netdata itu? kalau boleh saya kutipkan dari web resminya.

_**netdata** is a system for **distributed real-time performance and health monitoring**. It provides **unparalleled insights, in real-time**, of everything happening on the system it runs (including applications such as web and database servers), using **modern interactive web dashboards.**_

Jadi untuk bahasa mudahnya, netdata ini adalah sebuah system yang dibuat untuk monitoring / pemantuan sebuah performa system server, yang menampilkan laporan dengan menggunakan web dashboard yang interaktif.

netdata ini selain mempunyai tampilan yang interaktif, system aplikasi ini juga open source. bisa dilihat langsung untuk repositorynya di [https://github.com/firehol/netdata](https://github.com/firehol/netdata)

untuk dokumentasinya sendiri pun cukup lengkap, tetapi disini saya akan sedikit menulis ulang untuk bagian instalasi dan konfigurasi yang saya gunakan untuk memonitoring beberapa server yang saya gunakan.

ditulisan ini server yang saya gunakan yaitu ubuntu 16.04, yang sudah saya pasang nginx didalamnya, untuk tutorial instalasi & konfigurasi nginx mungkin lain waktu akan saya tuliskan di blog saya ini.

baiklah, pertama kita login ke vps / server kita, setelah itu kita install dependencies yang dibutuhkan

```bash
$ sudo apt-get install zlib1g-dev uuid-dev libmnl-dev gcc make autoconf autoconf-archive autogen automake pkg-config curl
```
untuk dependencies dibawah ini adalah sebetulnya hanya opsional, tetapi ini disarankan untuk di install oleh netdata itu sendiri.

```bash
$ sudo apt-get install python python-yaml python-mysqldb python-psycopg2 nodejs lm-sensors netcat
```

Selanjutnya kita clone project's netdata dari repositorynya.

```sh
$ git clone https://github.com/firehol/netdata.git --depth=1 ~/netdata

# setelah projects selesai di clone, kita masuk kedalam foldernya tersebut
$ cd ~/netdata
```

setelah masuk kedalam folder ```netdata``` kita install aplikasi menggunakan script ```netdata-installer.sh``` yang sudah ada.

```bash
$ sudo ./netdata-installer.sh
```

akan ada contoh output seperti berikut:

```bash
Installer Output
. . .
  It will be installed at these locations:

   - the daemon    at /usr/sbin/netdata
   - config files  at /etc/netdata
   - web files     at /usr/share/netdata
   - plugins       at /usr/libexec/netdata
   - cache files   at /var/cache/netdata
   - db files      at /var/lib/netdata
   - log files     at /var/log/netdata
   - pid file      at /var/run
. . .
```

_jika ingin merubah folder instalasi bisa menggunakan command_

```bash
$ sudo ./netdata-installer.sh --install /opt
```

Jika target folder penginstalan sudah benar, tekan ```ENTER``` untuk melanjutkan prosess instalasi.
setelah itu akan keluar seperti berikut

```bash

Installer Output
. . .
  ^
  |.-.   .-.   .-.   .-.   .-.   .  netdata                          .-.   .-
  |   '-'   '-'   '-'   '-'   '-'   is installed and running now!  -'   '-'  
  +----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+--->

  enjoy real-time performance and health monitoring...
```

Sekarang netdata sudah berhasil di install, sekarang kita bisa lihat hasilnya di ```http://YOUR_SERVER_ADDRESS:19999```


### Custom Configuration

Setelah selesai melakukan penginstalan dan aplikasi sudah berjalan, kita akan mencoba melakukan custom konfigurasi.

pertama buka file ```/etc/netdata/netdata.conf``` dari folder install netdata tadi, dari contoh ini tadi, saya install netdata saya di folder ```/opt```, berarti untuk mengakses path penuh dari aplikasi netdata ini berada di ```/opt/netdata/etc/netdata/netdata.conf```

Pada contoh custom konfigurasi ini saya akan merubah lamanya history yang di simpan oleh netdata, secara default netdata akan menyimpan history selama 1 jam atau 3600 detik.

untuk penyimpanan history ini juga akan memepengaruhi terhadap RAM kita, berikut gambaran RAM yang akan digunakan untuk menyimpan history kita ini

  - 3600 seconds (1 hour of chart data retention) uses 15 MB of RAM
  - 7200 seconds (2 hours of chart data retention) uses 30 MB of RAM
  - 14400 seconds (4 hours of chart data retention) uses 60 MB of RAM
  - 28800 seconds (8 hours of chart data retention) uses 120 MB of RAM
  - 43200 seconds (12 hours of chart data retention) uses 180 MB of RAM
  - 86400 seconds (24 hours of chart data retention) uses 360 MB of RAM

----

setelah mendapatkan gambaran RAM yang akan kita gunakan, kita langsung saja lakukan konfigurasinya.  
Buka file ```/etc/netdata/netdata.conf```

```bash
$ sudo nano /opt/netdata/etc/netdata/netdata.conf
```

cari parameter ```history``` pada bagian ```[global]```

```bash
# file `/etc/netdata/netdata.conf`
. . .   
[global]   
        # glibc malloc arena max for plugins = 1   
. . .   
        # hostname = test-netdata   
        # history = 3600 # BARIS YANG AKAN KITA RUBAH
        # update every = 1   
. . .   
```

hilangkan tanda ```#``` di depan ```history``` dan rubah value nya menjadi ```14400```, sehingga konfigurasinya akan menjadi seperti ini.

```bash
# file `/etc/netdata/netdata.conf`
. . .   
[global]   
        # glibc malloc arena max for plugins = 1   
. . .   
        # hostname = test-netdata   
        history = 14400 # BARIS YANG KITA RUBAH
        # update every = 1   
. . .
```

simpan dan keluar setelah melakukan perubahan.

### Mengaktifkan Kernel Same-page Merging atau KSM

Dengan mengaktifkan fitur KSM ini. netdata akan meningkan optimasi dan mengurangi penggunaan RAM antara 40-60%.

untuk mengkatifkan fitur KSM ini secara permanent kita akan masukan kedalam file ```/etc/rc.local```

```bash
$ sudo nano /etc/rc.local
```

tambahkan command berikut sebelum command ```exit 0```   

```echo 1 > /sys/kernel/mm/ksm/run```   
```echo 1000 > /sys/kernel/mm/ksm/sleep_millisecs```

jadi secara lengkap file ```/etc/rc.local``` akan menjadi seperti berikut

```bash
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

echo 1 > /sys/kernel/mm/ksm/run
echo 1000 > /sys/kernel/mm/ksm/sleep_millisecs

exit 0
```

setelah kita selesai melakukan konfigurasi kita lakukan restart pada netadata kita.

```bash
$ sudo systemctl restart netdata
```

kita cek kembali pada dashboard untuk melihat hasilnya.

----

Setelah kita sudah melakukan sedikit konfigurasi, selanjutnya kita akan mencoba menampilkan dashboard dengan menggunakan ```nginx```

kita install dependencies terlebih dahulu, dependencies ini akan digunakan untuk encrypt password.

```bash
$ sudo apt-get install apache2-utils nginx
```

setelah kita install dependencies, kita buat hash username & password yang akan kita gunakan untuk mengakses nginx kita

```bash
$ sudo htpasswd -c /etc/nginx/netdata-access repodevs
```

masukan password yang akan kita gunakan, pada prompt yang ada.

setelah itu kita konfigurasi nginx kita

```bash
$ sudo nano /etc/nginx/sites-available/default
```

```bash
upstream netdata-backend {
    server 127.0.0.1:19999;
    keepalive 64;
}

server {
    listen 80;
    # server_name monitor.domainmu.com;
    server_name _;

    auth_basic "Authentication Required";
    auth_basic_user_file netdata-access;

    location / {
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-Server $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass http://netdata-backend;
        proxy_http_version 1.1;
        proxy_pass_request_headers on;
        proxy_set_header Connection "keep-alive";
        proxy_store off;
    }
}
```

selanjutnya kita restart nginx kita

```bash
$ sudo service nginx restart
```

setelah kita restart nginx, kita akses dashboard dengan url yang sudah kita konfigurasi tadi.

```monitor.domainmu.com```

Sekian catatan kali ini, InsyaAllah akan ada pembahasan selanjutnya :)
