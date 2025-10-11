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
        List {
            // Mevcut "Geçmiş Aylar" bölümünü bir Section içine alıyoruz.
            Section(header: Text("Geçmiş Aylar").font(.headline)) {
                if depo.gecmisAyGruplari.isEmpty {
                    Text("Geçmiş aylara ait harcama bulunamadı.")
                        .foregroundColor(.gray)
                } else {
                    ForEach(depo.gecmisAyGruplari) { grup in
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
            
            // --- YENİ EKLENEN KISIM BURASI ---
            // Listenin en altına imzanı eklemek için yeni bir Section oluşturuyoruz.
            Section {
                HStack {
                    Spacer() // Metni ortalamak için
                    VStack {
                        Text("Created by")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("Selim Bedirhan Öztürk")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                    }
                    Spacer() // Metni ortalamak için
                }
            }
            // Bu bölümün arkaplanını ve kenarlıklarını kaldırarak daha temiz görünmesini sağlıyoruz.
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
        }
        .listStyle(SidebarListStyle())
    }
}
