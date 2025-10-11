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
        GeometryReader { geometry in
            ZStack {
                // ÇÖZÜM BURADA: NavigationView'i ZStack'in içine, ContentView'i sarmalayacak şekilde koyduk.
                NavigationView {
                    ContentView(isSidebarAcik: $isSidebarAcik)
                }
                
                if isSidebarAcik {
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
                    .offset(x: isSidebarAcik ? 0 : -geometry.size.width)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
