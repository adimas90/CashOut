//
//  RekapDetailsView.swift
//  Speech to Text
//
//  Created by Adimas Surya Perdana Putra on 13/04/22.
//  Copyright © 2022 Joel Joseph. All rights reserved.
//

import SwiftUI

struct RekapDetailsView: View {

  @Environment(\.presentationMode) var presentationMode
  @State var presentEditBookSheet = false


  var rekap: Rekap

  private func editButton(action: @escaping () -> Void) -> some View {
    Button(action: { action() }) {
      Text("Edit")
    }
  }

  var body: some View {
    Form {
      Section(header: Text("Book")) {
        Text("\(rekap.total_rekap_pengeluaran)")
//        Text("\(rekap.nominal) pages")
      }

//      Section(header: Text("Author")) {
//        Text(rekap.author)
//      }
    }
    .navigationBarTitle("\(rekap.total_rekap_pengeluaran)")
    .navigationBarItems(trailing: editButton {
      self.presentEditBookSheet.toggle()
    })
    .onAppear() {
      print("BookDetailsView.onAppear() for \(self.rekap.total_rekap_pengeluaran)")
    }
    .onDisappear() {
      print("BookDetailsView.onDisappear()")
    }
    .sheet(isPresented: self.$presentEditBookSheet) {
      RekapEditView(viewModelRekap: RekapViewModel(rekap: rekap), modes: .edit) { result in
        if case .success(let action) = result, action == .delete {
          self.presentationMode.wrappedValue.dismiss()
        }
      }
    }
  }

}

struct RekapDetailsView_Previews: PreviewProvider {
  static var previews: some View {
      let book = Book(nama_pengeluaran: "", nominal: 0, tanggal: Date())
      let rekap = Rekap(list_pengeluaran: [book], total_rekap_pengeluaran: 3000000, tanggal_rekap: Date())
    return
      NavigationView {
        RekapDetailsView(rekap: rekap)
      }
  }
}
