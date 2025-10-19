//
//  ContentView.swift
//  HarcamaTakip
//
//  Created by Selim Bedirhan Öztürk on 11.10.2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var depo: HarcamaDeposu
    @State private var eklemeEkraniGoster = false
    
    @Binding var isSidebarAcik: Bool
    
    var body: some View {
        List {
            // Toplam gider kartı
            if !depo.aktifAyHarcamalari.isEmpty {
                Section {
                    HStack(spacing: 15) {
                        Image(systemName: "chart.line.downtrend.xyaxis")
                            .font(.largeTitle)
                            .foregroundColor(.primary)
                            .padding()
                            .background(Color.primary.opacity(0.1))
                            .cornerRadius(12)
                        
                        VStack(alignment: .leading) {
                            Text("Toplam Gider")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            Text("\(depo.aktifAyToplamTutar, specifier: "%.2f") ₺")
                                .font(.largeTitle.bold())
                                .foregroundColor(.primary)
                        }
                    }
                    .padding(.vertical)
                }
            }
            
            // Harcama listesi
            if depo.aktifAyHarcamalari.isEmpty {
                Text("Bu ay hiç harcama girmediniz.\nEklemek için '+' butonuna dokunun.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                // --- DEĞİŞİKLİK BURADA ---
                ForEach(depo.aktifAyHarcamalari) { harcama in
                    // Her bir satırı, hedefi "HarcamaDuzenleView" olan bir linke dönüştürdük.
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
                        .padding(.vertical, 4)
                    }
                }
                .onDelete(perform: harcamaSil) // Silme özelliği hala çalışmaya devam edecek.
                // ---
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Harcamalarım")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    withAnimation {
                        isSidebarAcik.toggle()
                    }
                }) {
                    Image(systemName: "calendar")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { eklemeEkraniGoster = true }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $eklemeEkraniGoster) {
            HarcamaEkleView()
        }
    }
    
    func harcamaSil(at offsets: IndexSet) {
        let harcamalarToDelete = offsets.map { depo.aktifAyHarcamalari[$0] }
        let idlerToDelete = Set(harcamalarToDelete.map { $0.id })
        depo.harcamalariSil(ids: idlerToDelete)
    }
}
