//
//  RekapViewModel.swift
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

class RekapViewModel: ObservableObject {
   
  @Published var rekap: Rekap
//    @ObservedObject var bookssview = BooksViewModel()

//    @Published var book: Book
  @Published var modifiedRekap = false
  @Published var rekaped : [Rekap] = []
    @Published var bookse = [Book]()
    @Published var bookss : [Book] = []
    @Published var ordered = false
    @ObservedObject var viewModellRekap = RekapsViewModel()
    @ObservedObject var viewModellBook = BookViewModel()
    @EnvironmentObject var swiftUISpeech:SwiftUISpeech
//    @ObservedObject var viewModelBook = BooksViewModel()
//    @StateObject var viewModelBookz = BooksViewModel()
    @Published var booksw = [Book]()
    
  var firebasecall = [Rekap]()
   
  private var cancellablesRekap = Set<AnyCancellable>()
   
    init(rekap: Rekap = Rekap(list_pengeluaran: [Book(nama_pengeluaran: "", nominal: 0, tanggal: Date())], total_rekap_pengeluaran: 0, tanggal_rekap: Date())) {
    self.rekap = rekap
     
    self.$rekap
      .dropFirst()
      .sink { [weak self] rekap in
        self?.modifiedRekap = true
      }
      .store(in: &self.cancellablesRekap)
  }
 
  
   
  private var db = Firestore.firestore()
    
    func updateOrder() {  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//        let db = Firestore.firestore()
//        if let documentId = rekapViewModel1.rekap.id {
//            if ordered{
//                ordered = false
//                db.collection("rekap").document(documentId).delete {
//                    (err) in
//                    if err != nil{
//                        self.ordered = true
//                    }
//                }
//            }
//        }
        
         
        
        
        var details : [[String:Any]] = [] //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        bookss.forEach { (rekap) in
            details.append([
    //                "nama_customer" : cart.nama_customer,
                "nama_pengeluaran" : rekap.nama_pengeluaran,
                "nominal" : rekap.nominal
            ])
            
        }
        
    }
    
    func getPricez(value: Int) -> String{
        let format = NumberFormatter()

        return format.string(for: Int(value)) ?? "0"
    }
    
    func grandTotalz() -> String {
        var prices : Int = 20000
        bookse.forEach { (bookr) in
            prices += Int(bookr.nominal)
            
        }
        return getPricez(value: prices)
        
    }
  

    
  private func addBookRekap(_ rekap: Rekap) {
      
      func getPricer(value: Float) -> String{
          let format = NumberFormatter()

          return format.string(from: NSNumber(value: value)) ?? ""
      }
      
      func grandTotalr() -> String {
          var prices : Float = 20000
          bookse.forEach { (bookr) in
              prices += Float(bookr.nominal)
              
          }
          return getPricer(value: prices)
          
      }
      
      var details : [[String:Any]] = [] //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      bookse.forEach { (rekap) in
          details.append([
  //                "nama_customer" : cart.nama_customer,
              "nama_pengeluaran" : rekap.nama_pengeluaran,
              "nominal" : rekap.nominal
          ])
          print("ayok dong details : \(details)")
          
      }
      
    do {
        var addbookIdRekap = rekap
        addbookIdRekap.userId = Auth.auth().currentUser?.uid
        let idRekap = try db.collection("rekap").addDocument(from: rekap)
        idRekap.setData([
            "list_pengeluaran" : "",
      "total_rekap_pengeluaran" : //Int(grandTotalz()) ?? 0,
//            viewModelBookz.grandTotal(),
            "",
//                rekap.total_rekap_pengeluaran,
//            viewModelBook.grandTotal(),
//            rekap.total_rekap_pengeluaran,
//            "total_string" : viewModelBook.grandTotal(),
            "total_string": "",
            "tanggal_rekap": rekap.tanggal_rekap
        ])
//        print("ini totalllss: \(viewModelBook.grandTotal())")
    }
    catch {
      print(error)
    }
  }
    
  
   
  private func updateBookRekap(_ rekap: Rekap) {
    if let documentId = rekap.id {
      do {
        try db.collection("rekap").document(documentId).setData(from: rekap)
      }
      catch {
        print(error)
      }
    }
  }
    
//    private func orderSet(_ rekap: Rekap) {
////        if let documentId = rekap.id {
////            if ordered{
////                ordered = false
////                db.collection("rekap").document(documentId).delete {
////                    (err) in
////                    if err != nil{
////                        self.ordered = true
////                    }
////                }
////            }
////        }
//
//        ordered = true //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//        if let documentId = rekap.id {
//            print("")
//            db.collection("rekap").document(documentId).setData([
//                "nama_pengeluaran" : viewModelBook.updateOrder(),
//                "total_rekap_pengeluaran" : viewModelBook.grandTotal(),
//                "tanggal_rekap": rekap.tanggal_rekap
//
//
//            ]){ (err) in
//                if err != nil{
//                    self.ordered = false
//                    return
//                }
//                print("success")
//
//            }
//        }
//    }
//
    
   
  private func updateOrAddBookRekap() {
    if let _ = rekap.id {
      self.updateBookRekap(self.rekap)
    }
    else {
      addBookRekap(rekap)
    }
  }
   
  private func removeBookRekap() {
    if let documentId = rekap.id {
      db.collection("rekap").document(documentId).delete { error in
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
 
    
   
  func handleDoneTappedRekap() {
    self.updateOrAddBookRekap()
  }
   
  func handleDeleteTappedRekap() {
    self.removeBookRekap()
  }
    
//   func handleDoneTappedOrder() {
//        self.orderSet(rekap)
//  }

//    private func orderSet(_ rekap: Rekap) {
////        if let documentId = rekap.id {
////            if ordered{
////                ordered = false
////                db.collection("rekap").document(documentId).delete {
////                    (err) in
////                    if err != nil{
////                        self.ordered = true
////                    }
////                }
////            }
////        }
//
//        ordered = true //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//        if let documentId = rekap.id {
//            print("")
//            db.collection("rekap").document(documentId).setData([
//                "nama_pengeluaran" : viewModelBook.updateOrder(),
//                "total_rekap_pengeluaran" : viewModelBook.grandTotal(),
//                "tanggal_rekap": rekap.tanggal_rekap
//
//
//            ]){ (err) in
//                if err != nil{
//                    self.ordered = false
//                    return
//                }
//                print("success")
//
//            }
//        }
//    }
    
    
   
}
