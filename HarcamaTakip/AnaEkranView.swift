//
//  AnaEkranView.swift
//  HarcamaTakip
//
//  Created by Selim Bedirhan Öztürk on 11.10.2025.
//

import SwiftUI

struct AnaEkranView: View {
    @State private var isSidebarAcik = false
    
    var body: some View {
        // GeometryReader, ekran boyutuna göre dinamik frame'ler oluşturmak için kullanılıyor.
        GeometryReader { geometry in
            ZStack {
                ContentView(isSidebarAcik: $isSidebarAcik)
                
                if isSidebarAcik {
                    // Sidebar açıkken arkadaki içeriğin etkileşimini kesen ve kapatma işlevi gören overlay.
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                isSidebarAcik = false
                            }
                        }
                }

                SidebarView()
                    .frame(width: geometry.size.width * 0.75)
                    .background(Color(.systemBackground))
                    // 'isSidebarAcik' durumuna göre sidebar'ı ekranın içine veya dışına konumlandırır.
                    .offset(x: isSidebarAcik ? 0 : -geometry.size.width)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
