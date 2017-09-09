---
title:  "Tutorial Android CI dengan GitLab"
date: 2017-09-09 14:22
categories: [android]
tags: [CI, android, gitlab]
---

Assalamu'alaykum Warohmatullahi Wabarakatuh

Hallo temen-temen semua, pada tulisan kali ini saya ingin berbagi tutorial tentang Continuous Integration (CI) pada Android development dengan memenfaatkan CI dari GitLab.   
Saya sendiri sebenarnya bukan Android Developer, jadi disini saya hanya berbagi pada bagian CI nya saja.

Okay hal pertama yang harus di lakukan yaitu membuat repository dari aplikasi Android mu di GitLab. Saya asumsikan disini temen-temen sudah mempunyai repositorynya.

lakukan perubahan pada `build.gradle` temen-temen menjadi seperti

```java
// file app/build.gradle
...
//Signing configurations for build variants "release"
signingConfigs {
    release {
        storeFile file("my.keystore")
        storePassword System.getenv("KEYSTORE_PASSWORD")
        keyAlias System.getenv("KEY_ALIAS")
        keyPassword System.getenv("KEY_PASSWORD")
    }
}
...
```

dan jangan lupa sertakan keystore temen-temen dalam folder `app/`, jadi kurang lebih seperti ini strukturnya

![struktur file]({{ site.img_url }}/2017-09-09/1.png)

kemudian kita buat file `.gitlab-ci.yml` pada root directory project kita

![file gitlab-ci.yml]({{ site.img_url }}/2017-09-09/4.png)

dan kemudian isi sebagai berikut.

```yml
# file .gitlab-ci.yml
# docker container yang sudah terinstall android development
# container menggunakan SDK 25, dan BUILD TOOLS 24.0.3
# untuk container lainnya lihat gitlab.com/repodevs/android-ci

image: registry.gitlab.com/repodevs/android-ci:T25-B24.0.3

before_script:
    - export GRADLE_USER_HOME=`pwd`/.gradle
    - chmod +x ./gradlew

cache:
  key: "$CI_COMMIT_REF_NAME"
  paths:
     - .gradle/

stages:
  - build

build:
  stage: build
  only:
    - tags
  script:
     - ./gradlew assemble
  artifacts:
    paths:
    - app/
```

Script di atas akan menjalankan CI pada ketika ada sebuah `tags` di buat, jika ingin setiap commit atau lainya silahkan lihat disini [https://docs.gitlab.com/ee/ci/yaml/#only-and-except-simplified](https://docs.gitlab.com/ee/ci/yaml/#only-and-except-simplified)

setelah itu commit semua perubahannya, tetapi jangan di push dulu. kita akan settings Environment / Secret variables pada repository GitLabnya terlebih dahulu.

Masuk ke GitLab -> Repository -> Settings -> CI/CD atau mudahnya   
```https://gitlab.com/[USERNAME]/[NAMA-REPOSITORY]/settings/ci_cd```

dan settings variable yang kita butuhkan tadi yaitu   
`KEYSTORE_PASSWORD`   
`KEY_ALIAS`   
`KEY_PASSWORD`   

![add variables]({{ site.img_url }}/2017-09-09/2.png)

jika sudah dimasukan akan menjadi seperti ini

![all variables]({{ site.img_url }}/2017-09-09/3.png)

Setelah itu kita buat tags dari commitan kita terakhir dan kemudian push tags tersebut.

atau kita bisa membuat tags melalui web gitlabnya.

Masuk ke halaman pembuatan tags, atau mudahnya ```https://gitlab.com/[USERNAME]/[NAMA-REPOSITORY]/tags``` kemudan klik `New tag` dan isi field-field yang dibutuhkannya.

![create tag]({{ site.img_url }}/2017-09-09/5.png)

Ketika tags dibuat, GitLab akan otomatis men-trigger CI nya, untuk melihat semua status CI bisa dilihat di ```https://gitlab.com/[USERNAME]/[NAMA-REPOSITORY]/pipelines```

Ketika CI berjalan dengan normal, status pada pipelinesnya akan menjadi `passed` dan kita bisa langsung mendownload file apk kita `(Artifacs)`

![status CI]({{ site.img_url }}/2017-09-09/6.png)

Sekiah tutorial kali ini, InsyaAllah akan di sambung lagi tentang CI/CD ini :D
