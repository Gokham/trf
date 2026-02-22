# GitHub'da Görme ve Uygulamayı Test Etme Rehberi (Başlangıç Seviyesi)

Bu rehber, **daha önce hiç yazılım kurmamış** birinin bile adım adım ilerleyebilmesi için hazırlandı.

## 1) Neden GitHub'da göremiyorsun?

Bu projede yapılan değişiklikler önce yerel git geçmişine commit edilir.
GitHub'da görünmesi için bu commitlerin GitHub'daki repoya **push** edilmesi gerekir.

> Kısacası: `commit` = bilgisayarda kaydetmek, `push` = GitHub'a göndermek.

---

## 2) Önce projeyi kendi GitHub hesabına gönder

Aşağıdaki komutları sırayla terminalde çalıştır:

```bash
git remote -v
```

- Eğer `origin` satırlarında senin GitHub repo adresin görünüyorsa devam et.
- Görünmüyorsa remote ekle:

```bash
git remote add origin https://github.com/KULLANICI_ADIN/REPO_ADIN.git
```

Sonra branch'i GitHub'a gönder:

```bash
git push -u origin work
```

> Eğer `work` branch'i yerine `main` kullanmak istiyorsan:

```bash
git push -u origin HEAD:main
```

Push başarılı olunca GitHub sayfasını yenile; dosyaları göreceksin.

---

## 3) Bilgisayara Flutter kur (Windows/Mac/Linux)

Projeyi çalıştırmak için Flutter gerekir.

1. Flutter indir: https://docs.flutter.dev/get-started/install
2. Kurulum bittiğinde terminalde doğrula:

```bash
flutter --version
flutter doctor
```

`flutter doctor` eksikleri tek tek yazar (Android Studio, Xcode vb.).
Eksikleri tamamla.

---

## 4) Projeyi çalıştırma (ilk test)

Proje klasöründe şunları çalıştır:

```bash
flutter pub get
flutter run
```

- Telefon bağlıysa cihazda açılır.
- Cihaz yoksa emulator/simulator açman gerekir.

---

## 5) Uygulamayı nasıl test edeceksin? (çok basit senaryo)

Uygulama açıldıktan sonra:

1. Ortadaki arama kutusuna `47/1-b` yaz.
2. `Yapay Zeka Yanıtı Üret` butonuna bas.
3. Ekranda ceza bilgisi + örnek resmi tutanak metni gelmeli.
4. Mikrofon ikonuna basınca demo olarak `kırmızı ışık` metni dolmalı.

---

## 6) Olası hatalar ve çözüm

### Hata: `flutter: command not found`
Flutter kurulu değil veya PATH ayarı eksik.

### Hata: cihaz görünmüyor
Aşağıyı çalıştır:

```bash
flutter devices
```

Telefonu USB hata ayıklama ile bağla veya emulator aç.

### Hata: paketler inmiyor
Ağ/proxy engeli olabilir. Farklı ağda tekrar dene.

---

## 7) Hızlı kontrol listesi

- [ ] GitHub'a push yaptım.
- [ ] `flutter doctor` temiz/uyarılara göre düzeltildi.
- [ ] `flutter pub get` başarılı.
- [ ] `flutter run` ile uygulama açıldı.
- [ ] `47/1-b` araması sonuç verdi.

Bu adımları tamamladıysan projeyi başarılı şekilde görüp test etmiş olursun.
