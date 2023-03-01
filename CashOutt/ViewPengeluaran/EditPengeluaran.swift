//
//  EditPengeluaran.swift
//  CashOut!
//
//  Created by Adimas Surya Perdana Putra on 31/05/22.
//  Copyright © 2022 Joel Joseph. All rights reserved.
//

import SwiftUI
 
enum Modev {
  case new
  case edit
}
 
enum Actionv {
  case delete
  case done
  case cancel
}
 
struct EditPengeluaran: View {
   
  @Environment(\.presentationMode) private var presentationMode
  @State var presentActionSheet = false
 
   
  @ObservedObject var viewModel = BookViewModel()
  var mode: Mode = .new
  var completionHandler: ((Result<Action, Error>) -> Void)?
   
   
  var cancelButton: some View {
    Button(action: { self.handleCancelTapped() }) {
      Text("Cancel")
    }
  }
   
  var saveButton: some View {
    Button(action: { self.handleDoneTapped() }) {
      Text(mode == .new ? "Done" : "Save")
    }
    .disabled(!viewModel.modified)
  }
   
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Nama Pengeluaran")) {
          TextField("Nama Pengeluaran", text: $viewModel.book.nama_pengeluaran)
                .disableAutocorrection(true)

        }
         
        Section(header: Text("Nominal")) {
            TextField("Nominal", value: $viewModel.book.nominal, formatter: NumberFormatter())        }
           
        if mode == .edit {
          Section {
            Button("Hapus Pengeluaran") { self.presentActionSheet.toggle() }
              .foregroundColor(.red)
          }
        }
      }
      .navigationTitle("Edit")
      .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
      .navigationBarItems(
        leading: cancelButton,
        trailing: saveButton
      )
     
      .actionSheet(isPresented: $presentActionSheet) {
        ActionSheet(title: Text("Are you sure?"),
                    buttons: [
                      .destructive(Text("Delete book"),
                                   action: { self.handleDeleteTapped() }),
                      .cancel()
                    ])
      }
    }
  }
   
  func handleCancelTapped() {
    self.dismiss()
  }
   
  func handleDoneTapped() {
    self.viewModel.handleDoneTapped(nama: "", nominal: "")
    self.dismiss()
  }
   
  func handleDeleteTapped() {
    viewModel.handleDeleteTapped()
    self.dismiss()
    self.completionHandler?(.success(.delete))
  }
   
  func dismiss() {
    self.presentationMode.wrappedValue.dismiss()
  }
}
 
struct EditPengeluaran_Previews: PreviewProvider {
  static var previews: some View {
    let book = Book(nama_pengeluaran: "", nominal: 0, tanggal: Date())
    let bookViewModel = BookViewModel(book: book)
    return EditPengeluaran(viewModel: bookViewModel, mode: .edit)
  }
}
