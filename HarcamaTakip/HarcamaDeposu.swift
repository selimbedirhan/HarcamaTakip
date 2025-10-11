//
//  HarcamaDeposu.swift
//  HarcamaTakip
//
//  Created by Selim Bedirhan Öztürk on 11.10.2025.
//
import Foundation
import SwiftUI
import Combine

struct AylikHarcamaGrubu: Identifiable, Hashable {
    var id: Date { ayinIlkGunu }
    let ayinIlkGunu: Date
    let harcamalar: [Harcama]
    
    var toplamTutar: Double {
        harcamalar.reduce(0) { $0 + $1.tutar }
    }
}


class HarcamaDeposu: ObservableObject {
    @Published var harcamalar: [Harcama] = [] {
        didSet {
            kaydet()
        }
    }
    
    private let kayitAnahtari = "HarcamalarData"
    
    init() {
        yukle()
    }
    
    var aktifAyHarcamalari: [Harcama] {
        let bugun = Date()
        return harcamalar.filter { Calendar.current.isDate($0.tarih, equalTo: bugun, toGranularity: .month) }
    }
    
    var gecmisAyGruplari: [AylikHarcamaGrubu] {
        let bugun = Date()
        let gecmisHarcamalar = harcamalar.filter { !Calendar.current.isDate($0.tarih, equalTo: bugun, toGranularity: .month) }
        
        let gruplar = Dictionary(grouping: gecmisHarcamalar) { harcama in
            Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: harcama.tarih))!
        }
        
        return gruplar.map { (key, value) in
            AylikHarcamaGrubu(ayinIlkGunu: key, harcamalar: value)
        }.sorted { $0.ayinIlkGunu > $1.ayinIlkGunu }
    }
    

    var aktifAyToplamTutar: Double {
        aktifAyHarcamalari.reduce(0) { $0 + $1.tutar }
    }
    
    func harcamaEkle(aciklama: String, tutar: Double) {
        let yeniHarcama = Harcama(aciklama: aciklama, tutar: tutar, tarih: Date())
        harcamalar.insert(yeniHarcama, at: 0)
    }
    
    func harcamalariSil(ids: Set<UUID>) {
        harcamalar.removeAll { ids.contains($0.id) }
    }
    
    private func kaydet() {
        if let encodedVeri = try? JSONEncoder().encode(harcamalar) {
            UserDefaults.standard.set(encodedVeri, forKey: kayitAnahtari)
        }
    }
    
    private func yukle() {
        if let kaydedilmisVeri = UserDefaults.standard.data(forKey: kayitAnahtari) {
            if let decodedHarcamalar = try? JSONDecoder().decode([Harcama].self, from: kaydedilmisVeri) {
                self.harcamalar = decodedHarcamalar
                return
            }
        }
        self.harcamalar = []
    }
}

extension Date {
    func formatla(format: String = "MMMM yyyy") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
