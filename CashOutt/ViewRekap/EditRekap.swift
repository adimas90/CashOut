//
//  EditRekap.swift
//  CashOutt
//
//  Created by Adimas Surya Perdana Putra on 09/06/22.
//


import SwiftUI
 
enum Modeg {
  case new
  case edit
}
 
enum Actiong {
  case delete
  case done
  case cancel
}
 
struct EditRekap: View {
   
  @Environment(\.presentationMode) private var presentationMode
  @State var presentActionSheet = false
 
   
  @ObservedObject var viewModelRekap = RekapViewModel()
    @ObservedObject var viewModelRekape = BooksViewModel()
  var mode: Mode = .new
  var completionHandler: ((Result<Action, Error>) -> Void)?
   
   
  var cancelButton: some View {
    Button(action: { self.handleCancelTapped() }) {
      Text("Cancel")
    }
  }
   
//  var saveButton: some View {
//    Button(action: { self.handleDoneTapped() }) {
//      Text(mode == .new ? "Done" : "Save")
//    }
////    .disabled(!viewModelRekap.modified)
//  }
   
  var body: some View {
    NavigationView {
      Form {
           
        if mode == .edit {
          Section {
            Button("Hapus Rekap Ini?") { self.presentActionSheet.toggle() }
              .foregroundColor(.red)
          }
        }
      }
      .navigationTitle("Edit")
      .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
      .navigationBarItems(
        leading: cancelButton
//        trailing: saveButton
      )
     
      .actionSheet(isPresented: $presentActionSheet) {
        ActionSheet(title: Text("Apakah kamu yakin?"),
                    buttons: [
                      .destructive(Text("Hapus"),
                                   action: { self.handleDeleteTapped() }),
                      .cancel()
                    ])
      }
    }
  }
   
  func handleCancelTapped() {
    self.dismiss()
  }
   

   
  func handleDeleteTapped() {
    viewModelRekap.handleDeleteTappedRekap()
    self.dismiss()
    self.completionHandler?(.success(.delete))
  }
   
  func dismiss() {
    self.presentationMode.wrappedValue.dismiss()
  }
}
 
struct EditRekap_Previews: PreviewProvider {
  static var previews: some View {
    let book = Book(nama_pengeluaran: "", nominal: 0, tanggal: Date())
    let rekap = Rekap(list_pengeluaran: [book], total_rekap_pengeluaran: 0, tanggal_rekap: Date())
    let rekapViewModel = RekapViewModel(rekap: rekap)
    return EditRekap(viewModelRekap: rekapViewModel, mode: .edit)
  }
}

