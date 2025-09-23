---
title:  "Kenapa pilih Odoo?"
date:   2020-10-29 20:14:33
categories: [odoo]
tags: [python, odoo]
---

Simpelnya, Odoo itu kayak Swiss Army Knife-nya dunia ERP, satu tools buat semua kebutuhan bisnis lo, mulai dari sales, inventory, accounting, sampe e-commerce jadi satu. Yang bikin keren, dia open source jadi gratis (ga kayak SAP atau Oracle yang bikin kantong jebol), web-based jadi bisa diakses dari mana aja pake HP sekalipun, plus modular jadi tinggal install yang lo butuhin aja. Dari sisi teknis, dia pake Python sama PostgreSQL yang udah proven, arsitekturnya pake MVC yang rapih,cuma butuh beberapa baris kode Python & XML udah bisa bikin aplikasi lengkap karena semua "magic"-nya udah di-handle sama framework-nya.

## Odoo dari segi bisnis

Ngomongin tentang Odoo kita pasti tidak jauh dengan ERP. ada 2 jenis tipe sebuah ERP, yaitu **Proprietary** dan **Open Source.**

**Proprietary** adalah sebuah ERP yang dikembangkan, didistribusikan dan disupport oleh private company. Misalnya: Oracle, SAP, Microsoft Dynamics, dan lainnya.

**Open Source** adalah sebuah sistem ERP yang source code nya yang tersedia secara publik, mudah untuk dicustom dan juga biasanya tidak ada biaya lisensi alias free (bebas). Misalnya: Odoo, ERPnext, dan lainnya.

### Kenapa harus Odoo?

- **Open Source based!. -** Souce Code Odoo tersedia secara publik, semua orang bisa menggunakan dan mengcustomnya. tentu tidak perlu mengeluarkan biaya yang sangat mahal untuk membeli lisensi dibanding dengan ERP lainnya yang menawarkan solusi yang serupa. Odoo juga menyediakan aplikasi versi berbayar dan juga support jika diperlukan.
- **Web Based ERP.** - Odoo dibangun dengan sistem web based. Ini menguntungkan kita, kita tidak lagi perlu dikantor atau didepan komputer kita untuk mengakasesnya. kita bisa dari mana saja dan kapan saja untuk mengaksesnya, mulai dari menggunakan Laptop, Tablet, ataupun Smartphone kita.
- **All-in-one solution.** - Odoo menawarkan solusi dengan menggabungkan segala kebutuhan bisnis menjadi satu. mulai dari Sales, Purchasing, Inventory, Accounting bahkan hingga e-Commerce menjadi satu.
- **Highly Modular.** - Jika Anda hanya memerlukan aplikasi **Sales,** Anda hanya perlu memasang aplikasi tersebut tanpa perlu melakukan pemasangan semua aplikasi yang ada**. Odoo** bisa melakukan itu, karena Odoo dirancang secara modular.
- **Scalable and Flexible. -** Aplikasi yang telah disediakan Odoo tidak memenuhi kebutuhan bisnis Anda? Anda ingin menambahkan aplikasi baru untuk melengkapinya? Dengan Fleksibilitas Odoo mudah melakukan itu!.
- **User-friendly Experience. -** Odoo dirancang untuk memudahkan user dalam pengoperasian aplikasinya, tanpa harus *membayar* waktu yang lama dan mahal untuk melatih user dalam menggunakannya.
- **Easily Integrate with Third-party.** - Odoo sangat mudah diintegrasikan dengan aplikasi pihak ketiga jika diperlukan, misal anda memerlukan aplikasi CRM yang otomatis mengirimkan SMS atau WhatsApp kepada pelanggan Anda tanpa perlu *bolak-balik* pindah aplikasi. Semua bisa menjadi satu didalam Odoo.
- **Proven Product.** - Odoo telah digunakan lebih dari 5 juta orang diseluruh dunia, dan terus bertambah setiap harinya.

![Odoo vs Aplikasi Bisnis lainnya. *Gambar dari Odoo.*]({{ site.img_url }}/2020-10-29/odoo_comparison.png)

Odoo vs Aplikasi Bisnis lainnya. *Gambar dari Odoo.*

## Odoo dari segi teknikal

- **Open Source based!** - Base Odoo dibuat secara Open Source dan bisa di akses di halaman [Repository GitHub](https://github.com/odoo/odoo).
- **Modular** - Odoo dirancang secara modular (biasa disebut Addons atau Module) ini memudahkan kita untuk *bongkar* dan *pasang* module yang kita perlukan.
- **Mudah Integrasi** - Odoo dibuat menggunakan **Python** sebagai Backend dan **PostgreSQL** sebagai database. ini memudahkan kita untuk melakukan integrasi dengan thrid-party, misal SMS atau WhatsApp untuk notifikasi. Atau membuatkan sebuah API untuk digunakan oleh aplikasi client.
- **Komunitas** - Odoo memiliki sebuah komunitas yang menyediakan banyak sekali addons/module yang biasa disebut [OCA](https://github.com/oca) dan selain itu Odoo juga memiliki sebuah Forum dan Mailing list, ini memudahkan kita untuk bertanya jika ada kesulitan dalam pengembangan aplikasi.

### Kenapa sih harus Odoo untuk bikin aplikasi?

Bagi yang sudah terbiasa mengembangkan aplikasi tentu kita pernah mendengar istilah framework kan? entah itu yang menggunakan ~~MVC (Model View Controller)~~ ataupun yang semisalnya.

Odoo menggunakan [multitier](https://softwareengineering.stackexchange.com/a/299881) sumber [referensi](https://github.com/odoo-dev/odoo/blob/saas-13.5-dev_training-nim/doc/howtos/rdtraining/01_architecture.rst)

Nah Odoo sendiri juga menerapkan konsep tersebut (MVC). Didalam Odoo ini bisa kita bilang banyak sekali "Magic" nya. karena hanya beberapa Line Code Python & Xml kita sudah bisa membuat sebuah aplikasi, tanpa perlu mem*pusing*kan tentang pembuatan table di database, HTML/CSS untuk tampilan, Authentication, Access Rule dan *teman-temannya*!

Ingin tau seperti apa arsitektur Odoo? baca post selanjutnya.

---