//
//  RekapsViewModel.swift
//  Speech to Text
//
//  Created by Adimas Surya Perdana Putra on 13/04/22.
//  Copyright © 2022 Joel Joseph. All rights reserved.
//

import Foundation
import Combine
import FirebaseFirestore
import SwiftUI
import FirebaseAuth

class RekapsViewModel: ObservableObject {
  @Published var rekaps = [Rekap]()
    @StateObject var viewModel1 = BookViewModel()
//    @EnvironmentObject var swiftUISpeech:SwiftUISpeech
    @StateObject var rekapViewModel1 = RekapViewModel()
  @StateObject var rekapViewModel = RekapsViewModel()
    @Published var ordered = false
    
  private var db = Firestore.firestore()
  private var listenerRegistrationRekap: ListenerRegistration?
   
  deinit {
    unsubscribeRekap()
  }
   
  func unsubscribeRekap() {
    if listenerRegistrationRekap != nil {
      listenerRegistrationRekap?.remove()
      listenerRegistrationRekap = nil
    }
  }
   
  func subscribeRekap() {
      let userIdRekap = Auth.auth().currentUser?.uid
    if listenerRegistrationRekap == nil {
      listenerRegistrationRekap = db.collection("rekap")
            .order(by: "tanggal_rekap", descending: true)
            .whereField("userId", isEqualTo: userIdRekap)
            .addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
         
        self.rekaps = documents.compactMap { queryDocumentSnapshot in
          try? queryDocumentSnapshot.data(as: Rekap.self)
            
            
        }
      }
    }
  }
   
  func removeBooksRekap(atOffsets indexSet: IndexSet) {
    let rekaps = indexSet.lazy.map { self.rekaps[$0] }
    rekaps.forEach { rekap in
      if let documentIdRekap = rekap.id {
        db.collection("rekap").document(documentIdRekap).delete { error in
          if let error = error {
            print("Unable to remove document: \(error.localizedDescription)")
          }
        }
      }
    }
  }

    func getPrice(value: Int) -> String{
        let format = NumberFormatter()
        
        return format.string(from: NSNumber(value: value)) ?? ""
    }
    
    func grandTotal() -> String {
        var prices : Int = 0
        rekaps.forEach { (akum) in
            prices += Int(akum.total_rekap_pengeluaran)
            
        }
       
        return getPrice(value: prices)
    }
    
    func PengeluaranKemarin() -> String {
        var prices : Int = 0
        
        rekaps.forEach { (akum) in
            prices += Int(akum.total_rekap_pengeluaran)
            
        }
       
        return String(prices)
    }
    
    func PengeluaranHariIni(hariKe : Int) -> Double {
        
        
        if (rekaps.count != 0) {
            let totalIndeks = rekaps.count - 1
            return Double(rekaps[totalIndeks - hariKe].total_rekap_pengeluaran)
        }
        else
        {
            return 0
        }
        
        
      
        
    }
}

