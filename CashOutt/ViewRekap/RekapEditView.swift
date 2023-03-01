//
//  RekapEditView.swift
//  Speech to Text
//
//  Created by Adimas Surya Perdana Putra on 13/04/22.
//  Copyright © 2022 Joel Joseph. All rights reserved.
//

import SwiftUI
 
enum Modes {
  case new
  case edit
}
 
enum Actions {
  case delete
  case done
  case cancel
}
 
struct RekapEditView: View {
    
    
    
   @Environment(\.presentationMode) private var presentationMode
   @State var presentActionSheet = false
//@StateObject var viewModelBooks = BooksViewModel()
  
    
   @ObservedObject var viewModelRekap = RekapViewModel()
    @ObservedObject var viewModelRekaps = RekapsViewModel()
    @ObservedObject var viewModelBooks = BooksViewModel()
    @EnvironmentObject var swiftUISpeech:SwiftUISpeech
   var modes: Modes = .new
   var completionHandler: ((Result<Action, Error>) -> Void)?
    
    
   var cancelButton: some View {
     Button(action: { self.handleCancelTappedRekap() }) {
       Text("Cancel")
     }
   }
    
   var saveButton: some View {
     Button(action: { self.handleDoneTappedRekap() }) {
       Text(modes == .new ? "Done" : "Save")
     }
     .disabled(!viewModelRekap.modifiedRekap)
   }
    
   var body: some View {
     NavigationView {
         
       Form {
         Section(header: Text("Tambahkan grand total")) {
           TextField("Title", value: $viewModelRekap.rekap.total_rekap_pengeluaran, formatter: NumberFormatter())
//             Text("\(viewModelRekaps.grandTotal())")
             DatePicker("Tanggal", selection: $viewModelRekap.rekap.tanggal_rekap, in: ...Date() , displayedComponents: .date)
//             .hidden()
         }
        
        


         
        
          
 //        Section(header: Text("Author")) {
 //          TextField("Author", text: $viewModelRekap.rekap.author)
 //        }
 //
 //        Section(header: Text("Photo")) {
 //            TextField("Image", text: $viewModel.book.image)
 //        }
            
 //        if mode == .edit {
 //          Section {
 //            Button("Delete book") { self.presentActionSheet.toggle() }
 //              .foregroundColor(.red)
           
         }
       .navigationTitle("Rincian")
       .navigationBarTitleDisplayMode(modes == .new ? .inline : .large)
       .navigationBarItems(
         leading: cancelButton,
         trailing: saveButton
       )
       .actionSheet(isPresented: $presentActionSheet) {
         ActionSheet(title: Text("Are you sure?"),
                     buttons: [
                       .destructive(Text("Delete book"),
                                    action: { self.handleDeleteTappedRekap() }),
                       .cancel()
                     ])
       }
     }
   }
   func handleCancelTappedRekap() {
     self.dismissRekap()
   }
    
   func handleDoneTappedRekap() {
     self.viewModelRekap.handleDoneTappedRekap()
     self.dismissRekap()
   }
    
   func handleDeleteTappedRekap() {
     viewModelRekap.handleDeleteTappedRekap()
     self.dismissRekap()
     self.completionHandler?(.success(.delete))
   }
    
   func dismissRekap() {
     self.presentationMode.wrappedValue.dismiss()
  }
}


 
struct RekapEditView_Previews: PreviewProvider {
    @ObservedObject var viewModelBooks = BooksViewModel()
  static var previews: some View {
      let book = Book(nama_pengeluaran: "", nominal: 0, tanggal: Date())
      let rekap = Rekap(list_pengeluaran: [book] , total_rekap_pengeluaran: 0, tanggal_rekap: Date())
    let rekapViewModel = RekapViewModel(rekap: rekap)
      return RekapEditView(viewModelRekap: rekapViewModel, modes: .edit).environmentObject(SwiftUISpeech())
  }
}
