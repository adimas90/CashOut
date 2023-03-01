//
//  Rekap.swift
//  Speech to Text
//
//  Created by Adimas Surya Perdana Putra on 11/04/22.
//  Copyright © 2022 Joel Joseph. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift
 
struct Rekap: Identifiable, Codable {
    @DocumentID var id: String?
    var list_pengeluaran: [Book]?
    var total_rekap_pengeluaran: Int
    var tanggal_rekap: Date
    var userId: String?
    
   
  enum CodingKeys: String, CodingKey {
    case id
    case list_pengeluaran
    case total_rekap_pengeluaran = "total_rekap_pengeluaran"
    case tanggal_rekap
    case userId
  }
}
