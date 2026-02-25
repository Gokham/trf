# trf

Trafik polisleri için sade bir Flutter mobil arayüz prototipi.

## Özellikler

- Ortalanmış arama çubuğu
- Sesli arama butonu (demo/simülasyon)
- Madde numarası veya ihlal metniyle hızlı arama
- Kısa, resmi üslupla örnek tutanak metni üretimi
- PDF'den gelen ceza tablosu + 2918/Yönetmelik referans birleşimi

## Dosyalar

- `lib/main.dart`: Ana mobil arayüz
- `assets/data/traffic_rules.json`: Birleşik örnek bilgi tabanı
- `docs/legal_sources.md`: Resmi kaynaklar ve birleştirme notu

## Çalıştırma

```bash
flutter pub get
flutter run
```

> Bu prototipte sesli arama gerçek STT servisine bağlı değildir; demo amaçlıdır.


## Başlangıç Rehberi

- GitHub'da görme ve test adımları: `docs/github_ve_test_rehberi.md`
- Otomatik kurulum kontrolü: `bash scripts/check_setup.sh`


## Arama Kapsamı Notu

- Toplam kayıt sayısı artırıldı; arama artık Türkçe karakter ve madde yazım varyasyonlarına (ör. `47/1-b`, `471b`) daha toleranslıdır.
