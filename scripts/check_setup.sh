#!/usr/bin/env bash
set -euo pipefail

ok() { echo "✅ $1"; }
warn() { echo "⚠️  $1"; }
err() { echo "❌ $1"; }

step() { echo; echo "--- $1 ---"; }

step "1) Proje klasörü kontrolü"
if [[ -f "pubspec.yaml" ]]; then
  ok "Doğru klasördesin (pubspec.yaml bulundu)."
else
  err "Bu klasörde pubspec.yaml yok. Proje klasörüne gir: cd trf"
  exit 1
fi

step "2) Git remote kontrolü"
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  ok "Git repository algılandı."
  if git remote -v | grep -q origin; then
    ok "origin remote bulundu:"
    git remote -v | sed 's/^/   /'
  else
    warn "origin remote yok. Eklemek için:"
    echo "   git remote add origin https://github.com/KULLANICI_ADIN/REPO_ADIN.git"
  fi
else
  err "Burası bir git repo değil."
fi

step "3) Flutter kurulum kontrolü"
if command -v flutter >/dev/null 2>&1; then
  ok "Flutter bulundu: $(command -v flutter)"
  flutter --version | head -n 1 | sed 's/^/   /'
else
  err "flutter komutu bulunamadı. Flutter kur ve PATH'e ekle: https://docs.flutter.dev/get-started/install"
fi

step "4) Dart kontrolü"
if command -v dart >/dev/null 2>&1; then
  ok "Dart bulundu: $(command -v dart)"
  dart --version 2>&1 | sed 's/^/   /'
else
  warn "dart komutu bulunamadı (Flutter kurulduğunda genelde gelir)."
fi

step "5) Cihaz/emülatör kontrolü"
if command -v flutter >/dev/null 2>&1; then
  echo "Çalıştırılıyor: flutter devices"
  flutter devices || true
fi

step "6) Bağımlılık yükleme testi"
if command -v flutter >/dev/null 2>&1; then
  if flutter pub get; then
    ok "flutter pub get başarılı."
  else
    err "flutter pub get başarısız. Ağ/proxy veya Flutter setup sorununu kontrol et."
  fi
fi

step "7) Sonraki adım"
echo "Uygulamayı çalıştır:"
echo "   flutter run"
echo
ok "Kontrol bitti. Hata satırlarını bana olduğu gibi atarsan birlikte çözeriz."
