# Hukuki Kaynak Birleştirme Notu

Bu proje, kullanıcıdan gelen PDF içeriği (ceza tablosu örneği) ile 2918 sayılı Kanun/Yönetmelik referanslarını tek bir veri setinde birleştirmek için hazırlanmıştır.

## Kullanılan kaynaklar

- 2918 Sayılı Karayolları Trafik Kanunu (resmi): https://www.mevzuat.gov.tr/mevzuatmetin/1.5.2918.pdf
- Karayolları Trafik Yönetmeliği (resmi giriş): https://www.mevzuat.gov.tr/mevzuat?MevzuatNo=8182&MevzuatTur=7&MevzuatTertip=5

## Birleştirme yaklaşımı

1. Kullanıcı PDF'inden gelen madde-ceza satırları normalize edilir.
2. Kanun/yönetmelik madde numaraları anahtar kabul edilir (`47/1-b`, `48/8` gibi).
3. Aynı madde için farklı kaynaklardan gelen açıklamalar tek kayıtta birleştirilir.
4. Uygulama tarafında hızlı arama için JSON varlık dosyası (`assets/data/traffic_rules.json`) kullanılır.

## Not

Bu depo içinde resmi metinlerin tamamı lisans/dağıtım ve boyut nedenleriyle tutulmaz; resmi bağlantılar referans olarak saklanır.
