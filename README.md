# 💸 HarcamaTakip App

Kişisel harcamaları kolayca takip etmek için geliştirilmiş, modern ve sade bir iOS uygulamasıdır. Bu proje, kullanıcı dostu bir arayüzle finansal farkındalığı artırmayı hedefler. Tamamen **SwiftUI** kullanılarak, modern iOS geliştirme pratikleriyle oluşturulmuştur.

## 📱 Ekran Görüntüleri

| Ana Ekran | Harcama Ekleme | Yan Menü (Geçmiş Aylar) |
|:---:|:---:|:---:|
| <img src="https://raw.githubusercontent.com/selimbedirhan/HarcamaTakip/main/anaekran.PNG" width="200"> | <img src="https://raw.githubusercontent.com/selimbedirhan/HarcamaTakip/main/harcama_ekleme.PNG" width="200"> | <img src="https://raw.githubusercontent.com/selimbedirhan/HarcamaTakip/main/yan_menu.PNG" width="200"> |


## ✨ Özellikler

- **Aylık Harcama Takibi:** Harcamalar ana ekranda içinde bulunulan aya göre filtrelenir.
- **Anlık Toplam Gider:** Ana ekranda o ayki toplam harcama tutarını gösteren dinamik bir kart bulunur.
- **Kolay Harcama Ekleme:** Basit bir form ile hızlıca yeni harcamalar eklenebilir.
- **Kaydırarak Silme:** Harcamalar listeden sola kaydırılarak kolayca silinebilir.
- **Geçmiş Aylara Erişim:** Soldan açılan bir yan menü ile geçmiş ayların harcama özetlerine ve detaylarına ulaşılabilir.
- **Veri Kalıcılığı:** Tüm veriler, uygulama kapatılıp açılsa bile kaybolmayacak şekilde cihaz üzerinde (`UserDefaults`) güvenle saklanır.
- **Dinamik Arayüz:** `GeometryReader` kullanılarak farklı ekran boyutlarına uyum sağlayan esnek bir yapı oluşturulmuştur.
- **Özel Uygulama İkonu:** Uygulamanın kimliğini yansıtan özgün bir logo içerir.

## 🛠️ Kullanılan Teknolojiler

- **UI Framework:** SwiftUI
- **Dil:** Swift
- **Mimari Yaklaşım:** MVVM (Model-View-ViewModel)
- **Veri Saklama:** `UserDefaults` & `Codable` Protokolü
- **State Management:** `@State`, `@StateObject`, `@EnvironmentObject`, `@Binding` ve `Combine` framework'ü (`ObservableObject`).
- **IDE:** Xcode

## 🚀 Kurulum

Projeyi kendi bilgisayarınızda çalıştırmak için aşağıdaki adımları izleyebilirsiniz:

1.  Bu repoyu klonlayın:
    ```bash
    git clone [https://github.com/selimbedirhan/HarcamaTakip.git](https://github.com/selimbedirhan/HarcamaTakip.git)
    ```
2.  Proje klasörüne gidin:
    ```bash
    cd HarcamaTakip
    ```
3.  `HarcamaTakip.xcodeproj` dosyasını Xcode ile açın.
4.  Bir simülatör veya fiziksel bir cihaz seçerek **Run (▶)** butonuna basın.

## 📄 Lisans

Bu proje MIT Lisansı ile lisanslanmıştır. Detaylar için `LICENSE` dosyasına göz atabilirsiniz.

## 📬 İletişim

Selim Bedirhan Öztürk
