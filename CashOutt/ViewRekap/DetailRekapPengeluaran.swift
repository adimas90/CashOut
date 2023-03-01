//
//  DetailRekapPengeluaran.swift
//  Speech to Text
//
//  Created by Adimas Surya Perdana Putra on 20/04/22.
//  Copyright © 2022 Joel Joseph. All rights reserved.
//

import SwiftUI

struct DetailRekapPengeluaran: View {
  
  @Environment(\.presentationMode) var presentationMode
  @State var presentEditBarangSheet = false
    @EnvironmentObject var swiftUISpeech:SwiftUISpeech
//    private var dateFormatterDetail: DateFormatter = {
//        let dateFormatterDetail = DateFormatter()
//        dateFormatterDetail.dateFormat = "dd MMMM yyyy"
//        return dateFormatterDetail
//    }()
    var timeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()
    

    
    
  var rekap: Rekap
    
//    private func bookRowViewRekap(rekap: Rekap) -> some View {
//
//                ForEach(rekap.list_pengeluaran!){ list in
//                    HStack{
//                        VStack(alignment: .leading){
//                            Text("\(list.nama_pengeluaran)")
//                                .bold()
//                            Text("Rp. \(list.nominal)")
//                        }
//                        Spacer()
//                        Text("\(list.tanggal, formatter: timeFormatter)")
//                            .foregroundColor(Color("yello"))
//                    }
//                }
//
//
//    }
  
  private func editButton(action: @escaping () -> Void) -> some View {
    Button(action: { action() }) {
      Text("Edit")
    }
  }
  
  var body: some View {
    Form {
//        Section(header: Text("List Pengeluaran")) {
////            Text("\(rekap.list_pengeluaran[book.nominal])")
//            List{
//                ForEach (viewModellRekap.rekaps) { rekap in
//                  bookRowViewRekap(rekap: rekap)
//                }
//                .onDelete() { indexSetRekap in
//                  viewModellRekap.removeBooksRekap(atOffsets: indexSetRekap)
//                }
//
//            }.padding(.horizontal, 0.0)
//                .cornerRadius(9)
//      }
        
        Section(header: Text("List Pengeluaran")) {
            List{
                ForEach(rekap.list_pengeluaran!, id: \.nama_pengeluaran){ list in
                    HStack{
                        VStack(alignment: .leading){
                            Spacer()
                            Text("\(list.nama_pengeluaran)")
                                .bold()
                            Spacer()
                            Text("Rp. \(list.nominal)")
                        }
                        Spacer()
                        Text("\(list.tanggal, formatter: timeFormatter)")
                            .foregroundColor(Color("yello"))
                    }
                }
            }
      }

      
        Section(header: Text("Total Pengeluaran")) {
          Text("Rp. \(rekap.total_rekap_pengeluaran)")
                .bold()
      }
    }
    .navigationBarTitle("Rekap: \(rekap.tanggal_rekap,  formatter: Beranda().dateFormatter)")
    .navigationBarItems(trailing: editButton {
      self.presentEditBarangSheet.toggle()
    })
    .onAppear() {
      print("BarangDetailsView.onAppear() for \(self.rekap.tanggal_rekap)")
    }
    .onDisappear() {
      print("BarangDetailsView.onDisappear()")
    }
    .sheet(isPresented: self.$presentEditBarangSheet) {
        EditRekap(viewModelRekap: RekapViewModel(rekap: rekap), mode: .edit) { result in
          if case .success(let action) = result, action == .delete {
            self.presentationMode.wrappedValue.dismiss()
          }
        }
      }
  }
  
}

struct DetailRekapPengeluaran_Previews: PreviewProvider {
  static var previews: some View {
      let book = Book(nama_pengeluaran: "", nominal: 0, tanggal: Date())
      let rekap = Rekap(list_pengeluaran: [book], total_rekap_pengeluaran: 0, tanggal_rekap: Date())
    return
      NavigationView {
          DetailRekapPengeluaran(rekap: rekap).environmentObject(SwiftUISpeech())
      }
  }
}

