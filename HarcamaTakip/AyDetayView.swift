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
        // Harcamaları tarihe göre azalan sırada listeler.
        List(grup.harcamalar.sorted(by: { $0.tarih > $1.tarih })) { harcama in
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
        .navigationTitle(grup.ayinIlkGunu.formatla())
    }
}
