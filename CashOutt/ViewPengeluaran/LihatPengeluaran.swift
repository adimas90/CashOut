//
//  LihatPengeluaran.swift
//  CashOut!
//
//  Created by Adimas Surya Perdana Putra on 31/05/22.
//  Copyright © 2022 Joel Joseph. All rights reserved.
//

import SwiftUI

 
struct LihatPengeluaran: View {
   
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
      Section(header: Text("Pengeluaran")) {
        Text(book.nama_pengeluaran)
          Text("\(book.nominal)")
      }
//        Section(header: Text("Nominal")) {
//          
//        }

//        Section(header: Text("Edit")) {
//            Button(action: {
//                self.presentEditBookSheet.toggle()
//            }){
//                HStack(alignment:.center){
//                    Spacer()
//                    HStack{
////                        Image(systemName: "mic.badge.plus")
////                                .fixedSize(horizontalvertical: 20)
//                        Text("Edit").bold()
//                    }
//
//                    .foregroundColor(Color.black)
//                    .multilineTextAlignment(.center)
//
//                    Spacer()
//
//                }.padding()
//                    .background(Color.green)
//                    .cornerRadius(15)
//            }
//        }
    }
    .navigationBarTitle("Edit Pengeluaran")
//    .navigationBarItems(trailing: editButton {
//      self.presentEditBookSheet.toggle()
//    })
    .onAppear() {
      print("BookDetailsView.onAppear() for \(self.book.nama_pengeluaran)")
        self.presentEditBookSheet.toggle()
    }
    .onDisappear() {
      print("BookDetailsView.onDisappear()")
    }
    .sheet(isPresented: self.$presentEditBookSheet) {
      EditPengeluaran(viewModel: BookViewModel(book: book), mode: .edit) { result in
        if case .success(let action) = result, action == .delete {
          self.presentationMode.wrappedValue.dismiss()
        }
      }
    }
  }
   
}
 
struct LihatPengeluaran_Previews: PreviewProvider {
  static var previews: some View {
    let book = Book(nama_pengeluaran: "", nominal: 0, tanggal: Date())
    return
      NavigationView {
        LihatPengeluaran(book: book)
      }
  }
}

