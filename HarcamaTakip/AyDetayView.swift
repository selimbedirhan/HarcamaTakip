//
//  AyDetayView.swift
//  HarcamaTakip
//
//  Created by Selim Bedirhan Öztürk on 11.10.2025.
//

import SwiftUI

struct AyDetayView: View {
    let grup: AylikHarcamaGrubu
    
    var body: some View {
        List(grup.harcamalar.sorted(by: { $0.tarih > $1.tarih })) { harcama in
            // --- DEĞİŞİKLİK BURADA ---
            // Buradaki satırları da "HarcamaDuzenleView" ekranına giden bir linke dönüştürdük.
            NavigationLink(destination: HarcamaDuzenleView(harcama: harcama)) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(harcama.aciklama)
                            .fontWeight(.semibold)
                        Text(harcama.tarih, style: .date)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Text("\(harcama.tutar, specifier: "%.2f") ₺")
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)
                }
            }
            // ---
        }
        .navigationTitle(grup.ayinIlkGunu.formatla())
        // Başlığın küçük ve sabit kalmasını sağlayarak daha fazla harcamanın görünmesini sağlıyoruz.
        .navigationBarTitleDisplayMode(.inline)
    }
}
