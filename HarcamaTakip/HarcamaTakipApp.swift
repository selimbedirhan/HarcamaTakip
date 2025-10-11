//
//  HarcamaTakipApp.swift
//  HarcamaTakip
//
//  Created by Selim Bedirhan Öztürk on 11.10.2025.
//

import SwiftUI

@main
struct HarcamaTakipApp: App {
    @StateObject private var depo = HarcamaDeposu()
    
    var body: some Scene {
        WindowGroup {
            // Navigasyonun çalışabilmesi için her şeyi bir NavigationView içine alıyoruz.
            // Bu sayede sidebar'dan detay sayfasına geçiş çalışacak.
            NavigationView {
                AnaEkranView()
            }
            .environmentObject(depo) // Veri deposunu tüm alt görünümlere dağıt.
        }
    }
}
