//
//  SidebarView.swift
//  HarcamaTakip
//
//  Created by Selim Bedirhan Öztürk on 11.10.2025.
//

import SwiftUI

struct SidebarView: View {
    @EnvironmentObject var depo: HarcamaDeposu
    
    var body: some View {
        // Menünün içeriğini bir liste olarak düzenliyoruz.
        List {
            // Başlık
            Text("Geçmiş Aylar")
                .font(.headline)
                .padding(.top)

            if depo.gecmisAyGruplari.isEmpty {
                Text("Geçmiş aylara ait harcama bulunamadı.")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                // Her bir geçmiş ay grubu için bir satır oluşturuyoruz.
                ForEach(depo.gecmisAyGruplari) { grup in
                    // Bu NavigationLink sayesinde bir aya tıklandığında detay sayfası açılacak.
                    NavigationLink(destination: AyDetayView(grup: grup)) {
                        HStack {
                            Text(grup.ayinIlkGunu.formatla())
                                .fontWeight(.bold)
                            Spacer()
                            Text("\(grup.toplamTutar, specifier: "%.2f") ₺")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .listStyle(SidebarListStyle()) // Menüye daha uygun bir stil veriyoruz.
    }
}
