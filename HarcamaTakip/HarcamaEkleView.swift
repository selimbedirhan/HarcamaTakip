//
//  HarcamaEkleView.swift
//  HarcamaTakip
//
//  Created by Selim Bedirhan Öztürk on 11.10.2025.
//

import SwiftUI

struct HarcamaEkleView: View {
    @EnvironmentObject var depo: HarcamaDeposu
    @Environment(\.dismiss) var dismiss
    
    @State private var aciklama: String = ""
    @State private var tutar: String = ""
    
    // Kaydet butonunun aktif olup olmayacağını belirleyen form doğrulama mantığı.
    private var formGecerli: Bool {
        !aciklama.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !tutar.isEmpty &&
        // Tutar alanında ondalık ayırıcı olarak virgül girilme ihtimaline karşı '.' karakterine çevirir.
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
            .navigationTitle("Yeni Harcama")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("İptal") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Kaydet") {
                        if let tutarDouble = Double(tutar.replacingOccurrences(of: ",", with: ".")) {
                            depo.harcamaEkle(aciklama: aciklama, tutar: tutarDouble)
                            dismiss()
                        }
                    }
                    .disabled(!formGecerli)
                }
            }
        }
    }
}
