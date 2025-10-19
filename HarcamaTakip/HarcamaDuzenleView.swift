//
//  HarcamaDuzenleView.swift
//  HarcamaTakip
//
//  Created by Selim Bedirhan Öztürk on 18.10.2025.
//

import SwiftUI

struct HarcamaDuzenleView: View {
    // Bu ekran, düzenlenecek harcama bilgisini dışarıdan almalıdır.
    let harcama: Harcama
    
    @EnvironmentObject var depo: HarcamaDeposu
    @Environment(\.dismiss) var dismiss
    
    // Ekran açıldığında harcamanın mevcut bilgileriyle doldurulacak değişkenler.
    @State private var aciklama: String = ""
    @State private var tutar: String = ""
    
    // Formun geçerli olup olmadığını kontrol eder.
    private var formGecerli: Bool {
        !aciklama.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !tutar.isEmpty &&
        Double(tutar.replacingOccurrences(of: ",", with: ".")) != nil
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Harcama Detayları")) {
                    TextField("Tutar", text: $tutar)
                        .keyboardType(.decimalPad)
                    
                    TextField("Açıklama", text: $aciklama)
                }
            }
            .navigationTitle("Harcamayı Düzenle")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("İptal") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Kaydet") {
                        if let tutarDouble = Double(tutar.replacingOccurrences(of: ",", with: ".")) {
                            // "Ekle" yerine "Güncelle" fonksiyonunu çağırıyoruz.
                            depo.harcamaGuncelle(id: harcama.id, yeniAciklama: aciklama, yeniTutar: tutarDouble)
                            dismiss() // Ekranı kapat.
                        }
                    }
                    .disabled(!formGecerli) // Form geçerli değilse butonu pasif yap.
                }
            }
        }
        // Bu görünüm (view) ekranda belirdiği anda...
        .onAppear {
            // State değişkenlerini dışarıdan aldığımız harcamanın bilgileriyle doldur.
            self.aciklama = harcama.aciklama
            // Tutarı String'e çevirirken formatlıyoruz.
            self.tutar = String(format: "%.2f", harcama.tutar)
        }
    }
}
