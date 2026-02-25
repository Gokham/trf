# GitHub'da Görme ve Uygulamayı Test Etme Rehberi (Hiç Bilmeyenler İçin)

Tamam kanka, bunu en basit haliyle çözelim. 
Bu rehberin amacı: **uygulamayı gerçekten açtırmak**.

## Sıfırıncı adım (en hızlı yol)

Terminalde proje klasörüne gir ve bunu çalıştır:

```bash
bash scripts/check_setup.sh
```

Bu script sana neyin eksik olduğunu tek tek söyler.

---

## 1) Neden GitHub'da görünmüyor olabilir?

Çünkü sadece `commit` yapmak yetmez, ayrıca GitHub'a `push` gerekir.

### Kontrol:
```bash
git remote -v
```

`origin` yoksa ekle:
```bash
git remote add origin https://github.com/KULLANICI_ADIN/REPO_ADIN.git
```

Sonra gönder:
```bash
git push -u origin work
```

> `main` istiyorsan:
```bash
git push -u origin HEAD:main
```

---

## 2) Uygulama neden açılmıyor? (en sık 4 sebep)

### Sebep A: Flutter kurulu değil
Kontrol:
```bash
flutter --version
```

Çözüm: Flutter kur
- https://docs.flutter.dev/get-started/install

### Sebep B: PATH ayarı eksik (Flutter kurulu ama komut yok)
`flutter` komutu bulunamıyorsa PATH'e Flutter `bin` klasörünü ekle.

### Sebep C: Cihaz/emülatör yok
Kontrol:
```bash
flutter devices
```

- Liste boşsa: Android Studio'dan emulator aç veya fiziksel telefonu USB ile bağla.

### Sebep D: Paketler inmedi
Kontrol:
```bash
flutter pub get
```

Hata varsa çoğunlukla internet/proxy kaynaklıdır.

---

## 3) Uygulamayı açma (çalışan komut sırası)

Bu sırayı **aynen** uygula:

```bash
cd trf
flutter doctor
flutter pub get
flutter run
```

---

## 4) Açıldıktan sonra test et (1 dakikalık test)

1. Arama kutusuna `47/1-b` yaz.
2. `Yapay Zeka Yanıtı Üret` butonuna bas.
3. Ceza + kısa tutanak örneği görmelisin.
4. Mikrofon ikonuna basınca demo olarak `kırmızı ışık` yazısı dolmalı.

---

## 5) Bana göndermen gerekenler (takılırsan)

Aşağıdaki 3 komutun çıktısını olduğu gibi at, direkt hatayı nokta atışı çözelim:

```bash
bash scripts/check_setup.sh
flutter doctor -v
flutter run -v
```

> Özellikle son 30-40 satır çok önemli.
