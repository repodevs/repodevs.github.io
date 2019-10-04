---
title: Hosting static website on Amazon S3 
date: 2019-10-04 12:40
categories: [server, aws, devops]
tags: [aws, devops]
---

Selain untuk penyimpanan media/content, Amazon S3 juga bisa digunakan untuk Hosting Static Web.

Di tutorial kali ini kita akan melakukan:
- Membuat Bucket di Amazon S3
- Upload Static Web Content ke Bucket
- Mengaktifkan Akses ke Content
- Update Content Web

## Membuat Bucket di Amazon S3
1. Buka **AWS Management Console**, pada menu **_Services_** pilih **[S3](https://s3.console.aws.amazon.com/s3/home?region=ap-southeast-1)**.
2. Klik button **Create bucket**   
_Nama bucket di Amazon S3 bersifat unik dan berlaku untuk semua pengguna AWS. yang mana berarti ketia nama bucket tersebut telah dipilih, tidak akan bisa dipilih lagi oleh orang lain, sampai bucket tersebut dihapus._
3. Pada kolom **Bucket name** masukan nama bucket yang diinginkan, cth: `repodevs-web`.
4. Klik **Next**.   
_Di AWS kita bisa menggunakan sebuah **Tags** untuk memberikan informasi tambahan._
5. Pada bagian **Tags** masukan:
  - Key: `Service`
  - Value: `WebStatic`
6. Klik **Next**   
_Akses publik terhadap Bucket secara default adalah diblokir. File dari Web Content kita memerlukan akses publik untuk bisa diakses, jadi kita perlu mengaktifkan terlebih dahulu._
7. Hilangkan centang pada pilihan _**Block all public access**_
8. Klik **Next**
9. Lakukan Review terhadap Bucket yang akan dibuat, kemudian klik **Create bucket**
![Review Create Bucket]({{ site.img_url }}/2019-10-04/review-create-bucket.png)
10. Klik nama Bucket yang telah dibuat.   
_Disini kita akan mengkonfigurasi bucket untuk digunakan sebagai Hosting Static Website._
11. Klik tab **Properties**
12. Klik **Static website hosting**
13. Klik **Use this bucket to host a website** kemudian isikan kolom:
- Index document: `index.html`
14. Klik **Save**   
![Setup S3 as Static Hosting]({{ site.img_url }}/2019-10-04/setup-s3-as-static-hosting.png)
Bucket kita sekarang telah dikonfigurasi untuk Hosting static website, saatnya kita upload web content kita.

## Upload Static Web Content ke Bucket
Setelah Bucket kita terkonfigurasi untuk Hosting static website, sekarang kita upload static content kita.

1. Buat sebuah file `index.html`.   
```
    <html>
    <head>
        <title>My Website</title>
    </head>
    <body>
        <p><h1> Hello, Welcome to my website</h1></p>
    </body>
    </html>
```

2. Upload file `index.html` ke Bucket dengan cara kembali ke S3 management console dan klik tab **Overview**.
3. Klik button **Upload**
4. Klik **Add files** kemudian pilih file `index.html`
5. Klik **Upload**
![Upload file to s3]({{ site.img_url }}/2019-10-04/upload-file-to-s3.png)

## Mengaktifkan Akses ke Content
Setelah kita upload content, content tersebut secara default adalah private. ini memastikan file kita tetap aman.

Dibagian ini, kita akan mengaktifkan akses publik terhadap content kita.

1. Lakukan _centang_ pada checklist yang ada terhadap file `index.html`
2. Pada bagian **Actions** menu, klik **Make public**
List file yang akan dibuat publik akan munculkan.
3. Klik **Make public**   
![Make file as public]({{ site.img_url  }}/2019-10-04/make-file-as-public.png)
That's it! static websitemu sekarang sudah bisa diakses.


## Update Content Web
Dibagian ini kita akan melalukan update content website yang telah terdeploy.

1. Update file `index.html`.   
_Lakukan update pada file tersebut kemudian simpan dan_
2. Upload ulang file `index.html`.   
_Setelah file terupload, kita harus mengaktifkan akses publik lagi, meskipun file yang di upload sama seperti file yang sudah ada di Amazon S3._
3. Pilih  file `index.html` kemudian klik **Actions** menu dan klik **Make Public** lagi.
4. Selamat content websitemu telah diperbarui!

Sekian tutorial kali ini, semoga bisa sharing kembali dengan topik yang sama, ya, tentang AWS tentunya!

