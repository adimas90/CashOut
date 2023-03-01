//
//  BooksViewModel.swift
//  LibFirebase
//
//  Created by Adimas Surya Perdana Putra on 02/04/22.
//

import Foundation
import Combine
import FirebaseFirestore
import SwiftUI
import FirebaseAuth
 
class BooksViewModel: ObservableObject {
    @Published var rekap: Rekap
//    @Published var book:Book
  @Published var books = [Book]()
  @StateObject var viewModel1 = BookViewModel()
    @EnvironmentObject var swiftUISpeech:SwiftUISpeech
  @StateObject var rekapViewModel1 = RekapViewModel()
    @StateObject var rekapViewModel = RekapsViewModel()
  @Published var ordered = false
    @Published var modifiedRekapz = false
  
    
  private var db = Firestore.firestore()
  private var listenerRegistration: ListenerRegistration?
    
    private var cancellablesRekap = Set<AnyCancellable>()
    
    
     
      init(rekap: Rekap = Rekap(list_pengeluaran: [Book(nama_pengeluaran: "", nominal: 0, tanggal: Date())], total_rekap_pengeluaran: 0,tanggal_rekap: Date())) {
      self.rekap = rekap
       
      self.$rekap
        .dropFirst()
        .sink { [weak self] rekap in
          self?.modifiedRekapz = true
        }
        .store(in: &self.cancellablesRekap)
    }
    
  
   
  deinit {
    unsubscribe()
  }
   
  func unsubscribe() {
    if listenerRegistration != nil {
      listenerRegistration?.remove()
      listenerRegistration = nil
    }
  }
   
  func subscribe() {
      let userId = Auth.auth().currentUser?.uid
    if listenerRegistration == nil {
        listenerRegistration = db.collection("books")
            .order(by: "tanggal")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
         
        self.books = documents.compactMap { queryDocumentSnapshot in
          try? queryDocumentSnapshot.data(as: Book.self)
            
            
        }
          print("assalamualaikum : \(self.books)")
          print()
      }
    }
  }
  
  
   
  func removeBooks(atOffsets indexSet: IndexSet) {
    let books = indexSet.lazy.map { self.books[$0] }
    books.forEach { book in
      if let documentId = book.id {
        db.collection("books").document(documentId).delete { error in
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
        books.forEach { (bookr) in
            prices += Int(bookr.nominal)
        }
        
        return getPrice(value: prices)
        
    }
    
    
private func addBookRekape(_ rekap: Rekap) {
      
      func getPricer(value: Float) -> String{
          let format = NumberFormatter()
          return format.string(from: NSNumber(value: value)) ?? ""
      }
      
      func grandTotalr() -> String {
          var prices : Float = 0
          books.forEach { (bookr) in
              prices += Float(bookr.nominal)
              
          }
          return getPricer(value: prices)
      }
      
      var details : [[String:Any]] = [] //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
      books.forEach { (rekap) in
          details.append([
  //                "nama_customer" : cart.nama_customer,
              "nama_pengeluaran" : rekap.nama_pengeluaran,
              "nominal" : rekap.nominal,
              "tanggal" : rekap.tanggal
          ])
          print("ayok dong details : \(details)")
          
      }
      
    do {
        var addbookIdRekap = rekap
        addbookIdRekap.userId = Auth.auth().currentUser?.uid
        let idRekap = try db.collection("rekap").addDocument(from: addbookIdRekap)
        idRekap.setData([
            "list_pengeluaran" : details,
            "total_rekap_pengeluaran" :Int(grandTotalr()) ?? 0,
            "tanggal_rekap": addbookIdRekap.tanggal_rekap,
            "userId": addbookIdRekap.userId
        ])
//        print("ini totalllss: \(viewModelBook.grandTotal())")
    }
    catch {
      print(error)
    }
  }
    
    private func updateBookRekape(_ rekap: Rekap) {
      if let documentId = rekap.id {
        do {
          try db.collection("rekap").document(documentId).setData(from: rekap)
        }
        catch {
          print(error)
        }
      }
    }
    
    private func removeBookRekapg() {
      if let documentId = rekap.id {
        db.collection("rekap").document(documentId).delete { error in
          if let error = error {
            print(error.localizedDescription)
          }
        }
      }
    }
    
    private func updateOrAddBookRekape() {
      if let _ = rekap.id {
        self.updateBookRekape(self.rekap)
      }
      else {
        addBookRekape(rekap)
      }
    }
    
    func handleDoneTappedRekape() {
      self.updateOrAddBookRekape()
    }
     
    func handleDeleteTappedRekape() {
      self.removeBookRekapg()
    }
    
    
    
    
    
//    func grandTotalz() -> Int {
//        var prices : Int = 0
//        books.forEach { (bookr) in
//            prices += Int(bookr.nominal)
//            
//        }
//        
//        return grandTotalz()
//        
//    }
    
//    func getPricez(value: Int) -> Int{
//        let format = NumberFormatter()
//
//        return format.int(from: NSNumber(value: value)) ?? ""
//    }
    

 
   
}

//
//class RekapsViewModel: ObservableObject {
//  @Published var rekaps = [Rekap]()
//   
//  private var db = Firestore.firestore()
//  private var listenerRegistration: ListenerRegistration?
//   
//  deinit {
//    unsubscribe()
//  }
//   
//  func unsubscribe() {
//    if listenerRegistration != nil {
//      listenerRegistration?.remove()
//      listenerRegistration = nil
//    }
//  }
//   
//  func subscribe() {
//    if listenerRegistration == nil {
//      listenerRegistration = db.collection("rekap").addSnapshotListener { (querySnapshot, error) in
//        guard let documents = querySnapshot?.documents else {
//          print("No documents")
//          return
//        }
//         
//        self.rekaps = documents.compactMap { queryDocumentSnapshot in
//          try? queryDocumentSnapshot.data(as: Rekap.self)
//            
//            
//        }
//          print("holass : \(self.rekaps)")
//      }
//    }
//  }
//   
//  func removeBooks(atOffsets indexSet: IndexSet) {
//    let rekaps = indexSet.lazy.map { self.rekaps[$0] }
//    rekaps.forEach { rekap in
//      if let documentId = rekap.id {
//        db.collection("rekap").document(documentId).delete { error in
//          if let error = error {
//            print("Unable to remove document: \(error.localizedDescription)")
//          }
//        }
//      }
//    }
//  }
//
//    func getPrice(value: Float) -> String{
//        let format = NumberFormatter()
//        
//        return format.string(from: NSNumber(value: value)) ?? ""
//    }
//    
//    func grandTotal() -> String {
//        var prices : Float = 0
//        rekaps.forEach { (bookr) in
//            prices += Float(bookr.total_rekap_pengeluaran)
//            
//        }
//       
//        return getPrice(value: prices)
//    }
//    
// 
//   
//}
