---
title:  "Menambah Credit Digital Ocean dengan VCN BNI"
date: 2017-08-01 21:30
categories: [tips]
tags: [paymnet, tips, digitalocean]
---

Halo DO fans, pernah ingin melakukan penambahan credit ke digitalocean tapi tak punya saldo paypal?  
tenang dulu, saya mau share pengalaman menambahkan credit ke digitalocean.  
kasus saya dulu juga sama kayak pertanyaan tersebut.

OK untuk melakukan ini yang perlu di siapin yaitu pertama VCC, disini saya pakai VCN BNI, gak tau kalau dari bank lainnya (coba sendiri aja XD)

yang kedua yaitu akun paypal, gak punya? bikin lah =))  
yang ketiga tentunya akun digitalocean bukan akun amaz** XD

### Req VCN BNI  
Untuk mendapatkan VCN BNI, kita harus request terlebih dahulu.  
Caranya, silahkan buka SMS Bankingmu, kemudian request VCN sejumlah yang kamu inginkan

```sh
REQ VCN 140445
# KIRIM KE 3346
```
![req vcn bni]({{ site.img_url }}/2017-08-01/1.png)

### Menambahkan VCC ke PayPal  
Setelah kita mendapatkan VCN, selanjutnya kita tambahkan VCN kita tersebut ke akun paypal kita.

Login ke akun paypal kita kemudian masuk ke dalam menu penambahan wallet atau bisa langsung masuk ke [https://www.paypal.com/myaccount/wallet/add/card](https://www.paypal.com/myaccount/wallet/add/card)

![add wallet]({{ site.img_url }}/2017-08-01/2.png)

isi dengan data VCN kita tadi, jika berhasil akan tampil seperti ini

![add wallet success]({{ site.img_url }}/2017-08-01/3.png)

### Menambahkan Credit Digital Ocean
Setelah selesai menambahkan VCC kita ke akun paypal, buka akun digitalocean kemudian masuk ke menu billing
atau bisa langusung buka [https://cloud.digitalocean.com/settings/billing](https://cloud.digitalocean.com/settings/billing)

Scroll kebawah, pada **Payments methods** pilih TAB **PayPal** dan isi jumlah credit yang ingin di tambahkan kemudian klik button **PayPal**

![add credit]({{ site.img_url }}/2017-08-01/4.png)

Ketika button PayPal kamu klik, otomatis akan ter-redirect ke web paypal.   
Disini kamu bisa menambahkan deskripsi tentang pembayaranmu tersebut

![add description]({{ site.img_url }}/2017-08-01/5.png)

Setalah menambahkan description, akan terbuka halaman summary tentang pembayaran  
Pada halaman ini, pilih **change** pada pilihan **Pay With**

![change pay with]({{ site.img_url }}/2017-08-01/6.png)

Kemudian pilih dengan VCC yang kita masukan tadi

![pilih vcc]({{ site.img_url }}/2017-08-01/7.png)

Setelah kita pilih, akan berubah menjadi seperti berikut

![pilih vcc success]({{ site.img_url }}/2017-08-01/8.png)

Setelah kiranya sudah benar, klik button **Pay Now**, tunggu prosess pembayarannya  
Jika berhasil akan ada pemberitahuan seperti berikut

![pay success]({{ site.img_url }}/2017-08-01/9.png)

Setalah success, kamu akan otomatis ter-redirect kembali ke halaman billing digitalocean.  
Credit digitalocean mu otomatis akan menambah, Cek **billing history** untuk melihatnya

![billing history]({{ site.img_url }}/2017-08-01/10.png)

Tambahan, kamu bisa cek akun e-mail mu yang terhubung ke paypal.  
disana akan ada invoice pembayaranmu tadi

![email invoice]({{ site.img_url }}/2017-08-01/11.png)

Nah gimana, mudahkan?  
Selamat Mencoba !!!
