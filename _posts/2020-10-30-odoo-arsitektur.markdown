---
title:  "Odoo Arsitektur"
date:   2020-10-30 20:14:33
categories: [odoo]
tags: [python, odoo]
---

Di artikel sebelumnya kita telah membahas kenapa memilih Odoo, dan gambaran singkat tentang Odoo.

Pada artikel kali ini, kita akan membahas mengenai arsitektur Odoo tersebut.

## Odoo Arsitektur.

Jika digambarkan dalam bentuk diagram, maka Odoo bisa digambarkan seperti berikut.

![Odoo Arsitektur]({{ site.img_url }}/2020-10-30/odoo_arsitektur.png)


[_Source Drawing Exaclidraw_]({{ site.img_url }}/2020-10-30/odoo_arsitektur_exaclidraw.json)

---

```plaintext
Ehh bentar, ini kok udah sampe arsitektur aja, aku belum begitu paham nih tentang MVC, bisa jelasin ngga?
```

Oke, bagian ini dikususkan untuk kamu yang belum terbiasa menggunakan MVC atau malah baru denger istilah tersebut.

### Apa sih MVC itu?

> *MVC adalah sebuah pola arsitektur dalam sebuah desain software, dengan memisahkan data (Model) dari tampilan (View) dan cara bagaimana memprosesnya (Controller).*
> 

Masih bingung dengan penjelasan di atas?

Oke, baiklah mari kita ilustrasikan dengan contoh nyata dalam kehidupan.

Mari kita asumsikan kamu sedang pergi ke restoran untuk makan malam (sendirian pastinya kan. dengan pasangan? emang ada? 😆).

Disana kamu akan menemukan sebuah meja, daftar menu makanan dan setelah melihat-lihat akhirnya kamu memutuskan untuk memesan sebuah Lychee Tea 🍹kepada **waiter**. Disini, **waiter** akan mencatat pesananmu dan memberikan kepada **Kitchen Manager** (orang yang menerima pesanan dari waiter). Si **Kitchen Manager** akan meneruskan pesanan itu kepada **Koki** yang bertugas untuk membuatkan pesanan tersebut. **Disinilah Kitchen Manager berlaku seperti *Controller* didalam MVC.** 

Si **Koki** akan menganalisa pesanan dan menentukan apa saja bahan yang diperlukan untuk membuat pesanan tersebut dan mengolahnya. Dia mengambil **Lychee, Tea, Gula** dan pelengkapnya dari tempat penyimpanannya. **Disini Koki bertindak sebagi *Model* didalam MVC,** karena **Model** menyediakan **data** untuk memenuhi pesanan.

Setalah **Lychee Tea** 🍹 ****telah siap, **Kitchen Manager** akan menginstrusikan **Waiter** untuk *meladeni* / memberikan kepadamu. Untuk memberikan tampilan yang *aesthetic* **Waiter** akan memberikan sedotan, tisue, dan sebagainya. **Disini Waiter berlaku seperti *View* didalam MVC.**

Semoga penjelasan tersebut dapat dimengerti, jika sekiranya kurang jelas pengertian tentang MVC bisa dilihat di [**Wikipedia**](https://en.wikipedia.org/wiki/Model–view–controller).

### MVC pada Odoo seperti apa?

Sebelum kita melihat lebih dalam tentang penerapan MVC pada Odoo. mari kita lihat apa saja teknologi yang digunakan Odoo.

- **Python**
    
    Python adalah sebuah bahasa pemrograman yang bersifat terbuka yang pertama kali dibuat oleh Guido van Rossum. Odoo menggunakan python sebagai **Business Logic** dan **Business Object** dalam aplikasinya. Odoo menggunakan Python2.7 untuk versi Odoo 10 dan sebelumnya, sedangkan untuk Odoo versi 11 dan yang terbarunya menggunakan Python3.6 atau yang terbaru.
    
    Didalam pengembangnya Odoo mencoba untuk ***respect terhadap PEP8.*** PEP8 adalah sebuah standart dalam penulisan kode python *(Style Guide)*. tetapi ada beberapa yang dikesampingkan seperti:
    
    - `E301: expected 1 blank line, found 0`
    - `E501: line too long`
    - `E302: expected 2 blank lines, found 1` .
    
    Odoo juga [sangat menyarankan](https://github.com/odoo/documentation/blob/8061470577388754999d75e3ecb6d7ca3533bbe4/content/contributing/development/coding_guidelines.rst#idiomatics-of-programming-python) dalam setiap baris pertama pada python file untuk diawali dengan   `# -*-*coding: utf-8 -*-` ,* ini gunanya untuk menandakan bahwa file python tersebut menggunakan Unicode UTF-8 sebagai [Encoding](https://docs.python.org/3/reference/lexical_analysis.html#encoding-declarations)nya.

    ```text
Mulai odoo version 14 dan/atau yang terbaru atau yang sudah menggunakan Python 3, sudah tidak lagi diperlukan untuk mengawali setiap file python dengan `# -*-*coding: utf-8 -*-`.
    ```
    
- **Frontend (XML/Html Templates)**
    
    Odoo menggunakan XML file untuk menentukan sebuah tampilan, yang kemudian akan secara otomatis terbuat (*render*) sebuah HTML ketika User mengakses melalui Web Browser. Didalam file XML ini kita bisa mendefinisikan sebuah Menu, Action, View dan juga kita bisa melakukan pengolahan data dalam sebuah model.
    
- **CSV**
    
    Odoo juga menggunakan sebuah file CSV untuk melakukan pengolahan data (memasukan data kedalam sistem Odoo). file ini biasanya digunakan untuk menentukan Access Control List pada Module Odoo.
    
- **PostgreSQL**
    
    Odoo menggunakan PostgreSQL sebagai Databasenya. versi yang direkomendasikan untuk digunakan yaitu versi 10 atau yang terbaru. Didalam Odoo kita hampir tidak memerlukan untuk pembuatan table secara manual, karena kita hanya memerlukan pendefinisian nama field kedalam Class didalam pytho file, Odoo akan otomatis membuatkan table dan column/field tersebut kedalam database.
    

Setelah kita melihat apa saja teknologi yang digunakan oleh Odoo. kita bisa mengambil kesimpulan bahwa penerapan MVC pada Odoo yaitu:

- **Model:** PostgreSQL tables.
- **View:** XML files / HTML Templates.
- **Controller:** Python Class dan function didalamnya.

Menggunakan Odoo kita akan "dimanjakan" dengan ORM dan Frameworknya yang begitu Powerfull ketika mengembangakan sebuah module/addons.