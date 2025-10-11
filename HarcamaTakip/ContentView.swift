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
    
    // AnaEkranView'daki 'isSidebarAcik' durumuna bağlanarak sidebar'ın açılıp kapanmasını tetikler.
    @Binding var isSidebarAcik: Bool
    
    var body: some View {
        List {
            // Aktif ayda harcama varsa gösterilecek olan toplam gider kartı.
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
            
            // Harcama listesi veya boş ise placeholder metni.
            if depo.aktifAyHarcamalari.isEmpty {
                Text("Bu ay hiç harcama girmediniz.\nEklemek için '+' butonuna dokunun.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding()
            } else {
                ForEach(depo.aktifAyHarcamalari) { harcama in
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
                // Listede sola kaydırarak silme işlevselliğini ekler.
                .onDelete(perform: harcamaSil)
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
    
    // Silinmek üzere seçilen elemanların index'lerini kullanarak,
    // ana veri kaynağından ilgili harcamaları ID'lerine göre güvenli bir şekilde siler.
    func harcamaSil(at offsets: IndexSet) {
        let harcamalarToDelete = offsets.map { depo.aktifAyHarcamalari[$0] }
        let idlerToDelete = Set(harcamalarToDelete.map { $0.id })
        depo.harcamalariSil(ids: idlerToDelete)
    }
}
