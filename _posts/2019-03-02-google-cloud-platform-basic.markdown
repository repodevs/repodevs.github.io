---
title: Google Cloud Platform basic
date: 2019-03-02 02:33
categories: [server, gcp, devops]
tags: [gcp, gcloud, devops]
---

_**[Google](https://google.com) [Cloud](https://cloud.google.com) [Platform](https://en.wikipedia.org/wiki/Google_Cloud_Platform)** atau sering disebut **GCP** adalah rangkaian layanan komputasi awan (cloud computing) yang berjalan di infrastruktur yang sama yang digunakan oleh Google secara internal untuk produk-produknya, seperti Google Search dan YouTube._



## Apa saja yang akan dipelajari?
- Google Compute Engine Overview
- Membuat VM Instance dengan Cloud Console
- Membuat VM Instance dengan `gcloud` tools
- Install Nginx web server

## Google Compute Engine Overview
Google Compute Engine adalah salah satu layanan dari Google Cloud Platform yang mana menawarkan layanan untuk kamu bisa membuat _[Virtual Machine](https://en.wikipedia.org/wiki/Virtual_machine)_ dengan berbagai macam Sistem Operasi, seperti Debian, Ubuntu, Suse, Red Hat, CoreOS dan Windows Server. Kamu bisa membuat Virtual Machine sebanyak mungkin didalam sistem yang telah didesain untuk berjalan cepat dan menawarkan performa yang konsisten.

## Membuat VM Instance dengan Cloud Console
Untuk membuat VM Instance melalu Cloud Console, masuk ke [GCP Console](https://console.cloud.google.com) kemudian di pojok kiri atas halaman; pilih Menu Navigasi > **Compute Engine** > **[VM Instances](https://console.cloud.google.com/compute/instances)**

![VM Instances Menu]({{ site.img_url }}/2019-03-02/GCP-VM_Instance_menu.png)

Kemudian membuat VM Instance baru dengan menekan tombol **Create**.

Setelah menekan tombol **Create** akan muncul form seperti berikut, lakukan pengisian form sesuai kebutuhan atau bisa mengisi form seperti contoh berikut:

![VM Instance Create]({{ site.img_url }}/2019-03-02/GCP-VM_Instance_create.png)

Tekan tombol **Create** dan tunggu beberapa saat sampai VM Instance kamu siap untuk digunakan.
Kamu juga bisa melihat status proses pembuatan VM Instance-nya didalam _Notifications_.

![VM Instance Create In Progress]({{ site.img_url }}/2019-03-02/GCP-VM_Instance_create_inprogress.png)

Setelah pembuatan VM Instance selesai, kamu bisa melihat Virtual Machine tersebut di halaman **VM Instances**.

Kamu juga bisa mencoba mengakases VM Instance tersebut dengan menggunakan SSH. Google Cloud menyediakan fasilitas untuk melakukan SSH kedalam Instance langsung dari browser.

Dari daftar VM Instances, pada pilihan **_Connect_** pilih _dropdown_ **SSH** > **Open in browser window**

![Akses VM Instance menggunakan SSH]({{ site.img_url }}/2019-03-02/GCP-VM_Instance_list.png)

Setelah itu akan ada _pop up browser_ yang menampilkan _Shell_ dari Instance tersebut.

![VM Instance Shell]({{ site.img_url }}/2019-03-02/GCP-VM_Instance_ssh.png)

Kita bisa menggunakan shell tersebut layakanya _Terminal_ di dalam komputer kita.

## Membuat VM Instance dengan `gcloud` tools
Selain menggunakan GCP Console, kita juga bisa membuat VM Instance menggunakan _CLI Tools_ dari google yaitu **[gcloud](https://cloud.google.com/sdk/gcloud/)**
yang mana tools tersebut sudah _pre-installed_ didalam _Google Cloud Shell_.
**Google Cloud Shell** adalah _Debian-based_ virtual machine yang mana didalamnya telah terpasang semua development tools dari google dan beberapa tools lainnya seperti [git](https://git-scm.com/).

Buka Cloud Shell dengan cara menekan icon _terminal_ pada pojok kanan atas halaman.

![Activate Cloud Shell]({{ site.img_url }}/2019-03-02/GCP-Activate_cloud_shell.png)


Pada _dialog box_ klik tombol **START CLOUD SHELL**, tunggu beberapa saat hingga cloud shell siap digunakan.

![Cloud Shell Terminal]({{ site.img_url }}/2019-03-02/GCP-Cloud_shell_terminal.png)

_Selain didalam cloud shell kamu juga bisa menggunakan `gcloud` didalam komputermu, silakan baca dokumentasinya [disini](https://cloud.google.com/sdk/gcloud/)_

Didalam Cloud Shell, buat virtual machine instance baru dengan menggunakan command `gcloud`.

```bash
gcloud compute instances create gcelab2 --zone us-central1-c
```

_kamu juga bisa menggunakan `zones` lainnya, untuk lebih detailnya bisa baca [disini](https://cloud.google.com/compute/docs/zones)_

Tunggu beberapa saat sampai VM Instance kamu siap digunakan.

Didalam command diatas akan membuat instance dengan _default values_:
- Sistem Operasi [Debian 9 (stretch)](https://cloud.google.com/compute/docs/images#debian)
- [Tipe _Machine_](https://cloud.google.com/compute/docs/machine-types) `n1-standard-1`
- Sebuah [persistent disks](https://cloud.google.com/compute/docs/disks/add-persistent-disk) instance dengan nama yang sama dengan VM Instance; disk/penyimpanan tersebut otomatis akan terhubung (attached) kedalam VM Instance.

Kita bisa lihat instance yang kita telah buat didalam halaman [VM Instances](https://console.cloud.google.com/compute/instances). kamu akan melihat 2 instance yang telah kita buat tadi di halaman ini.

![GCP VM Instance list]({{ site.img_url }}/2019-03-02/GCP-VM_Instance_list2.png)


Kita bisa mencoba melakukan SSH kedalam instance tersebut dari cloud shell menggunakan `gcloud` command.

```bash
gcloud compute ssh gcelab2 --zone us-central1-c
```

Kamu akan dapatkan sebuah _prompt_ seperti berikut

```bash
WARNING: The public SSH key file for gcloud does not exist.
WARNING: The private SSH key file for gcloud does not exist.
WARNING: You do not have an SSH key for gcloud.
WARNING: [/usr/bin/ssh-keygen] will be executed to generate a key.
This tool needs to create the directory
[/home/xxxxxxxxxxxxx/.ssh] before being able to generate SSH
Keys.
```

```bash
Do you want to continue? (Y/n)
```

ketikan huruf **Y** untuk melanjutkan.
dan kemudian tekan tombol **Enter** pada keyboard didalam _prompt_ berikut

```bash
Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase)
```

Yaps! kamu telah berhasil mengakses VM Instance.

untuk keluar dari SSH, ketikan command berikut

```bash
exit
```

kamu akan kembali kedalam cloud shell.


## Install Nginx web server
Setelah kita membuat VM Instance, saatnya kita coba instance tersebut dengan cara melakukan installasi [nginx](https://nginx.org/).


Lakukan SSH ke VM Instance `gcelab`

```bash
gcloud compute ssh gcelab --zone us-central1-c
```

setelah masuk kedalam Instance nya, lakukan _switch user_ sebagai `root` dengan cara

```bash
sudo su -
```

setelah berhasil menjadi `root` user, lakukan _update OS_

```bash
apt-get update
```

setelah _update OS_ selesai, lakukan install Nginx.

```bash
apt-get install nginx -y
```

setelah selesai, _check_ nginx telah _running_ atau belum dengan cara

```bash
ps auwx | grep nginx
```

jika berhasil terinstall, akan ada _output_ kurang lebih

```bash
root      2104  0.0  0.0  91180  2960 ?     Ss  03:59  ... -g daemon on
; master_process on;
www-data  2105  0.0  0.0  91544  3652 ?     S   03:59  ... worker process
root      2115  0.0  0.0  12784  976 pts/0  S+  02:32  ... grep nginx
```

Setelah berhasil, mari kita lihat hasilnya dengan cara mengakses `External IP` instance tersebut.
masuk ke halaman VM Instances, kemudian klik `IP` pada bagian `External IP`.

![GCP VM Instance External IP]({{ site.img_url }}/2019-03-02/GCP-VM_Instance_external_ip.png)

kamu akan melihat _default web page_ dari nginx seperti berikut

![GCP Nginx default page]({{ site.img_url }}/2019-03-02/GCP-Nginx_default_page.png)

Selamat! kamu telah berhasil menggunakan Google Cloud Platform :)

Sampai jumpa di tutorial selanjutnya!
