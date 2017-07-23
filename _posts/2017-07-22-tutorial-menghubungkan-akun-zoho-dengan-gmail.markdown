---
title:  "Tutorial Menghubungkan Zoho Mail dengan Gmail (e-mail forwarding)"
date: 2017-07-22 01:40
categories: [python, mail]
tags: [python, tips]
---

Ini adalah hal yang saya cari beberapa hari yang lalu, ketika saya punya akun e-mail dari zoho, sedangkan saya jarang membuka Zoho,
dari situ saya mempunyai ide "kenapa ini kalau ada e-mail masuk ke zoho ndak di forward otomatis saja ke akun gmail?"

Okelah begini cara menghubungkannya:

Buka akun zoho mail mu, kemudian masuk ke **menu settings** yang terdapat pada pojok kanan atas,
ketika halaman settings telah terbuka, disebelah kiri ada tampilan menu, klik **"Email forwarding and POP/IMAP"**

![menu email forwarding]({{ site.img_url }}/p/1_setting.png)

Setelah itu akan muncul tampilan seperti berikut, catatat informasi seperti yang dilingkari pada gambar,
Karena identitas ini akan kita gunakan untuk setting pada gmail kita nanti

![IMAP config]({{ site.img_url }}/p/2_info_imap.png)


Masuk ke akun gmail kamu, buka menu **setting -> Akun dan Impor -> Tambahkan alamat email lainnya**

![akun dan impor]({{ site.img_url }}/p/3_setting_gmail.png)

Kemudian masukan e-mail yang akan di tambahkan

_**JANGAN LUPA UNTUK MENGHILANGKAN CENTANG PADA "Anggap Sebagai Alias"**_

![penambahan email]({{ site.img_url }}/p/4_tambahkan_email.png)

Setelah itu, kita akan di minta untuk mengkonfigurasi SMTP, masukan SMTP seperti yang sudah kita simpan sebelumnya

![konfigurasi smtp]({{ site.img_url }}/p/5_setting_smtp.png)

Setelah kita selesai mengkonfigurasi SMTP, kita akan di minta untuk memasukan kode konfirmasi,

buka akun zoho mail, kemudian cek e-mail masuk dari google yang berupa kode konfirmasi

![kode konfirmasi]({{ site.img_url }}/p/7_kode_konfirmasi.png)

setelah mendapatkan kode, masukan kode kedalam form yang di berikan oleh google dan kemudian klik tombol **verifikasi**

![kode konfirmasi]({{ site.img_url }}/p/6_konfirmasi_email.png)

Jika semua sudah terkonfigurasi dengan benar, akan seperti ini tampilanya

![email terkonfirmasi]({{ site.img_url }}/p/8_email_terkonfirmasi.png)

sekarang kita bisa test, mengirim email dari gmail, tetapi bisa memilih email pengirimnya dengan email yang kita tambahkan tadi

![test kirim email dari gmail]({{ site.img_url }}/p/testing_email.png)


Selanjutnya kita akan mengaktifkan  e-mail forwardingnya,

buka kembali zoho mail kita dan masuk ke **settings** -> **E-mail forwarding and POP/IMAP**
kemudian klik **Add email address** pada **Forward a copy of incoming message to:** dan masukan e-mail tujuan yang akan menerima pesan forwardnya

![tambahkan email forward]({{ site.img_url }}/p/9_tambahkan_email_forwarder.png)


setelah itu kita akan diminta untuk verifikasi dari zoho mail, masuk ke gmail dan cek kode konfirmasi yang dikirimkan oleh zoho mail

![kode konfirmasi zoho]({{ site.img_url }}/p/10_konfirmasi_forwarder.png)

setelah mendapatkan kode, masukan kode konfirmasi kedalam setting zoho mail tadi

![konfirmasi forward]({{ site.img_url }}/p/11_konfirmasi_forwarder_2.png)

jika semuanya sudah benar, ketika ada email masuk ke akun zoho kita otomatis akan ter-forward ke akun gmail kita,

_contoh kirim email ke zoho, dan otomatis ter-forward ke gmail_

![contoh forward]({{ site.img_url }}/p/test_kirim_email_ke_zoho.png)
