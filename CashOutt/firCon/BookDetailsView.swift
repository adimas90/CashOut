//
//  BookDetailsView.swift
//  LibFirebase
//
//  Created by Adimas Surya Perdana Putra on 02/04/22.
//

import SwiftUI
 
struct BookDetailsView: View {
   
  @Environment(\.presentationMode) var presentationMode
  @State var presentEditBookSheet = false
   
   
  var book: Book
   
  private func editButton(action: @escaping () -> Void) -> some View {
    Button(action: { action() }) {
      Text("Edit")
    }
  }
   
  var body: some View {
    Form {
      Section(header: Text("Book")) {
        Text(book.nama_pengeluaran)
        Text("\(book.nominal) pages")
      }
    }
    .navigationBarTitle(book.nama_pengeluaran)
    .navigationBarItems(trailing: editButton {
      self.presentEditBookSheet.toggle()
    })
    .onAppear() {
      print("BookDetailsView.onAppear() for \(self.book.nama_pengeluaran)")
    }
    .onDisappear() {
      print("BookDetailsView.onDisappear()")
    }
    .sheet(isPresented: self.$presentEditBookSheet) {
      SpeechRecognition(viewModel: BookViewModel(book: book), mode: .edit) { result in
        if case .success(let action) = result, action == .delete {
          self.presentationMode.wrappedValue.dismiss()
        }
      }
    }
  }
   
}
 
struct BookDetailsView_Previews: PreviewProvider {
  static var previews: some View {
      let book = Book(nama_pengeluaran: "Coder", nominal: 23, tanggal: Date())
    return
      NavigationView {
        BookDetailsView(book: book)
      }
  }
}
