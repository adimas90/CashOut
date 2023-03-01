//
//  BookViewModel.swift
//  LibFirebase
//
//  Created by Adimas Surya Perdana Putra on 02/04/22.
//

import Foundation
import Combine
import FirebaseFirestore
import SwiftUI
import Firebase
import FirebaseAuth
 
class BookViewModel: ObservableObject{
    
    
    
    @StateObject var viewModel1 = BooksViewModel()
    @StateObject var speech = SwiftUISpeech()
//    @ObservedObject var speechRecog = SpeechRecognition()
    
  @Published var book: Book
  @Published var bookList: [Book] = []
  @Published var modified = false
  @Published var booked = [Book]()
  @Published var rekapPengeluaran: [Rekap] = []
//  @EnvironmentObject var swiftUISpeech:SwiftUISpeech
    @EnvironmentObject var swiftUISpeech:SwiftUISpeech
    @ObservedObject var swiftUISpeechForNominal = SwiftUISpeechForNominal()
    @ObservedObject var swiftUISpeechh = SwiftUISpeech()
    

    
// 
//  var outputTXT = swiftUIS
    
  var firebasecall = [Book]()
    
    

  private var cancellables = Set<AnyCancellable>()
    
//    let speechUI: SwiftUISpeech
    

   
    init(book: Book = Book(nama_pengeluaran: "", nominal: 0, tanggal: Date())) {
    self.book = book
     
    self.$book
      .dropFirst()
      .sink { [weak self] book in
        self?.modified = true
      }
      .store(in: &self.cancellables)
    }
    
//    init(speech : SwiftUISpeech = SwiftUISpeech()) {
//
//    }
    
//    let sswiftUISpeech: SwiftUISpeech
//    init(sswiftUISpeech: SwiftUISpeech) {
//           self.sswiftUISpeech = sswiftUISpeech
//        }
    

    
//    var docData: String = SpeechRecognition().textPengeluaran
    
//    func getSpeechl(value: String) -> String{
//
//        return String(value)
//    }
//
//    func grandSpeechl() -> String {
//        var stung : String = "halo"
//
//        stung = swiftUISpeechh.outputText
//
//        return getSpeechl(value: stung)
//
//    }
//
    private var db = Firestore.firestore()
    
   
    private func addBook(_ book: Book) {

      do {
          
          let idBook = try db.collection("books").addDocument(from: book)
//          self.book.nama_pengeluaran = SpeechRecognition().grandSpeech()
          idBook.setData([
            "nama_pengeluaran" :
//                    swiftUISpeech.grandSpeech(),
//            grandSpeech(),
            book.nama_pengeluaran,
            
            "nominal": book.nominal,
            "tanggal": book.tanggal
            
            
          ])
      }
      catch {
        print(error)
      }
        print("success")
    }
   
  private func updateBook(_ book: Book) {
    
    if let documentId = book.id {
      do {
          try db.collection("books").document(documentId).setData(from: book)
      }
      catch {
        print(error)
      }
    }
  }
   
    private func updateOrAddBook(nama: String, nominal: String) {
    if let _ = book.id {
      self.updateBook(self.book)
    }
    else {
        do {
            var addbookId = book
            addbookId.userId = Auth.auth().currentUser?.uid
            
            let idBook = try db.collection("books").addDocument(from: addbookId)
            idBook.setData([
              "nama_pengeluaran" :
              nama,
              
              "nominal": Int(nominal) ?? 0,
              "tanggal": addbookId.tanggal,
              "userId" : addbookId.userId
              
              
            ])
        }
        catch {
          print(error)
        }
    }
  }
   
  private func removeBook() {
    if let documentId = book.id {
      db.collection("books").document(documentId).delete { error in
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
   
    func handleDoneTapped(nama: String, nominal: String) {
        self.updateOrAddBook(nama: nama, nominal: nominal)
  }
   
  func handleDeleteTapped() {
    self.removeBook()
  }

}





