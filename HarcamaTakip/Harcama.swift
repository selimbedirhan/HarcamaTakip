//
//  Harcama.swift
//  HarcamaTakip
//
//  Created by Selim Bedirhan Öztürk on 11.10.2025.
//

import Foundation

struct Harcama: Identifiable, Codable, Hashable {
    var id = UUID()
    var aciklama: String
    var tutar: Double
    var tarih: Date
}
