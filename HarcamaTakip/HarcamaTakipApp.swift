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
            // NavigationView'i buradan kaldırdık.
            AnaEkranView()
                .environmentObject(depo)
        }
    }
}
