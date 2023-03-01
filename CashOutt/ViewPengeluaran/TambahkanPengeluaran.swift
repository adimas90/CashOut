//
//  TambahkanPengeluaran.swift
//  Speech to Text
//
//  Created by Adimas Surya Perdana Putra on 01/04/22.
//  Copyright © 2022 Joel Joseph. All rights reserved.
//

import SwiftUI
import Firebase

struct TambahkanPengeluaran: View {
    
    @StateObject var viewModel = BooksViewModel()
    @StateObject var viewModel1 = BookViewModel()
    @StateObject var viewModelRekap = RekapViewModel()
    @StateObject var viewModel1Rekap = RekapsViewModel()
    @EnvironmentObject var swiftUISpeech:SwiftUISpeech
    @State var presentAddBookSheet = false
    @State private var tanggal_pengeluaran = Date()
    @State private var alertIsPresented = false
    @State private var alertBerhasil = false
    
    private var timeFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()
    
    private var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()
    
    
    private func bookRowView(book: Book) -> some View {
        NavigationLink(destination: LihatPengeluaran(book: book)) {
            VStack(alignment: .leading) {
                DatePicker("Tanggal", selection: $tanggal_pengeluaran, in: ...Date() , displayedComponents: .date)
                    .hidden()
                    .padding(.top, -30)
                HStack {
                    
                    VStack(alignment: .leading) {
                        Spacer()
                        Text(book.nama_pengeluaran)
                            .fontWeight(.bold)
                        Spacer()
                        Text("Rp. \(book.nominal),-")
                    }
                    Spacer()
                    Text("\(book.tanggal, formatter: timeFormatter)")
                        .foregroundColor(Color("yello"))
                }
                Spacer()
                
            }
        }
    }
    
    var h : Int = 0
    
    var body: some View {
       
            VStack(alignment: .leading, spacing: 9){

                Text("List Pengeluaran Harian :")
                    .bold()
                    .multilineTextAlignment(.leading)
                
                    List{
                        ForEach (viewModel.books) { book in
                          bookRowView(book: book)
                        }
                        .onDelete() { indexSet in
                          viewModel.removeBooks(atOffsets: indexSet)
                        }
                
                    }.padding(.horizontal, 0.0)
                        .cornerRadius(9)
                
                
                Spacer()
                
                Label("Total Pengeluaran Anda Hari Ini : ", systemImage: "dollarsign.square")
                    
                
                Text("Rp. \(viewModel.grandTotal()),-")
                
                    .bold()
                    .foregroundColor(.red)
                    .font(.title)
                
                Spacer()
                
                VStack{
                    Button(action: {
//                        viewModelRekap.updateOrder()
//                        self.viewModel1Rekap.subscribeRekap()
//                        self.viewModel.handleDoneTappedRekape()
                        self.alertIsPresented = true
                        print("grandTotal: \(viewModel.grandTotal())")
                    }
                    ){
                        Text(viewModelRekap.ordered ? "Cancel Order" : "Tambahkan kedalam rekap")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(
                                Color("pink"))
                            .cornerRadius(15)
                    }
                    
                    Button(action: {
                        self.presentAddBookSheet.toggle()
                    }){
                        HStack(alignment:.center){
                            Spacer()
                            HStack{
                                Image(systemName: "mic.badge.plus")
    //                                .fixedSize(horizontalvertical: 20)
                                Text("Tambahkan pengeluaran Hari Ini").bold()
                            }
                            
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                            
                            Spacer()
                               
                        }.padding()
                            .background(Color.green)
                            .cornerRadius(15)
                    }
                }
            }
            .navigationBarTitle(Text("Catatan \(viewModel1.book.tanggal, formatter: dateFormatter)"))
                 .onAppear() {
                  print("BooksListView appears. Subscribing to data updates.")
                  self.viewModel.subscribe()
                  self.viewModel1Rekap.subscribeRekap()
                     
                 }
                 .onDisappear(){
                     print("BooksListView disappears. Subscribing to data updates.")
                     self.viewModel.subscribe()
                     self.viewModel1Rekap.subscribeRekap()
                 }
                 .sheet(isPresented: self.$presentAddBookSheet) {
                  SpeechRecognition()
                     
                 }
                 .alert("Tambahkan kedalam rekap?", isPresented: $alertIsPresented, actions: {
                       Button("Ok", action: {
                           viewModelRekap.updateOrder()
                           self.viewModel1Rekap.subscribeRekap()
                           self.viewModel.subscribe()
                           self.viewModel.handleDoneTappedRekape()
                           self.alertBerhasil.toggle()
                       })
                     
                     Button("Batal", action: {})
                         .foregroundColor(Color.red)
                     }, message: {
                       Text("Pastikan anda telah memasukkan seluruh pengeluaran belanja harian sebelum di rekap")
                     })
                 .alert(isPresented: $alertBerhasil, content: {
                     Alert(title: Text("Berhasil!"), message: Text("Pengeluaran Berhasil di Rekap. Mohon kembali ke halaman beranda untuk melihat rekap pengeluaran anda!"), dismissButton: .default(Text("Selesai")))
                 })
                .padding()
    }
}

struct TambahkanPengeluaran_Previews: PreviewProvider {
    static var previews: some View {
        TambahkanPengeluaran().environmentObject(SwiftUISpeech())
            .environmentObject(BookViewModel())
    }
}
