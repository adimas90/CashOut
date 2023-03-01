//
//  Book.swift
//  LibFirebase
//
//  Created by Adimas Surya Perdana Putra on 02/04/22.
//

import Foundation
import FirebaseFirestoreSwift
import SwiftUI
 
struct Book: Identifiable, Codable {
  @DocumentID var id: String?
  var nama_pengeluaran: String
  var nominal: Int
  var tanggal: Date
  var userId: String?

   
  enum CodingKeys: String, CodingKey {
    case id
    case nama_pengeluaran
    case nominal = "nominal"
    case tanggal
    case userId
  }
}


