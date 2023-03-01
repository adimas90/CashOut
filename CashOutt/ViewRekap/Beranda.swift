//
//  Beranda.swift
//  Speech to Text
//
//  Created by Adimas Surya Perdana Putra on 27/03/22.
//  Copyright © 2022 Joel Joseph. All rights reserved.
//

import SwiftUI
import Firebase

struct Beranda: View {
    @StateObject var viewModellRekap = RekapsViewModel()
    @StateObject var viewModelRekap = RekapViewModel()
    @StateObject var viewModelBooks = BooksViewModel()
    @EnvironmentObject var swiftUISpeech:SwiftUISpeech
    @State var showInfoModalView:Bool = false
    @State var presentAddBookSheetRekap = false
    @State var numVal: Int = UserDefaults.standard.integer(forKey: "limit")
    @State var dateRekap: Date = Date()
    @State var tanggal_sekarang = Date()
    @State var tanggal_simpan: Date = UserDefaults.standard.object(forKey: "tanggallimit") as! Date
    @State private var alertGagal = false
    @State var durasi: String = ""
    
    
    
    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter
    }()
    
    private var addButton: some View {
      Button(action: { self.presentAddBookSheetRekap.toggle()
          print("tanggal sekarang 1 : \(tanggal_sekarang)")
          print("tanggal sekarang 2 : \(tanggal_simpan)")
      }) {
        Image(systemName: "plus")
      }
    }
    
//    private var saveButtonAtur: some View {
//      Button(action: {
//          self.numVal = inputLimit
//          presentationMode.wrappedValue.dismiss()
//      }) {
//        Text("")
//      }
//    }
    
    
    private func bookRowViewRekap(rekap: Rekap) -> some View {
        NavigationLink(destination: DetailRekapPengeluaran(rekap: rekap)) {
          VStack(alignment: .leading) {

        VStack(alignment: .leading) {
            HStack {

                VStack(alignment: .leading) {
                    Spacer()
                    if (numVal < rekap.total_rekap_pengeluaran) {
                        Text("Diatas limit")
                            .foregroundColor(Color.red)
                            .bold()
                    } else if (numVal > rekap.total_rekap_pengeluaran) {
                        Text("Dibawah limit")
                            .foregroundColor(Color.green)
                            .bold()
                    } else if (numVal == rekap.total_rekap_pengeluaran) {
                        Text("Pengeluaran sesuai dengan limit")
                            .foregroundColor(Color.green)
                            .bold()
                    }
//                    Text(rekap.status)
//                        .fontWeight(.bold)
                    Spacer()
                    Text("Rp. \(rekap.total_rekap_pengeluaran),-")
                    Spacer()

                }
                Spacer()
                Text("\(rekap.tanggal_rekap, formatter: dateFormatter)")
                    .foregroundColor(Color("yello"))
                }
            }
          }
        }
    }
    
//    private func bookRowViewRekap(rekap: Rekap) -> some View {
//
//        VStack(alignment: .leading) {
//            HStack {
//
//                VStack(alignment: .leading) {
//                    Spacer()
//                    Text("\(rekap.total_rekap_pengeluaran)")
//                        .fontWeight(.bold)
//                    Spacer()
//                    Text("Rp. \(rekap.total_rekap_pengeluaran),-")
//                }
//                Spacer()
//                Text("09:00")
//
//            }
//        }
//
//    }
    
    
    
    var body: some View {
        
        NavigationView{
            VStack(alignment: .leading, spacing: 9){
                Text("Akumulasi :")
                    .bold()
                    .multilineTextAlignment(.leading)
                
                VStack{
                    ZStack{
                        
                        Rectangle().fill(Color("warnaakumulasi")).frame(height: 199, alignment: .center)
                            .cornerRadius(9)
                        
                        ZStack{
                            Image("grafikakumulasi")
                                .padding(.leading, 150)
                            VStack(alignment: .leading, spacing: 60){
                                VStack(alignment: .leading){
                                    Text("Akumulasi Pengeluaran:")
                                        .foregroundColor(Color.white)
                                        .bold()
                                    Image("garisakumulasi")
                                }
                                
                                VStack(){
                                    Text("Rp. \(viewModellRekap.grandTotal()),-")
                                        .foregroundColor(Color.white)
                                        .font(.title)
                                        .bold()
                                }
                            }.padding(.bottom, 30)
                                .padding(.leading, -20)
                            
                        }
                        
                    }
                }
                
                
                Text("Atur Limit Pengeluaran Harian :")
                    .bold()
                    .multilineTextAlignment(.leading)
                    
                HStack {
                  Button(action: {
                      if tanggal_simpan.addingTimeInterval(10) <= Date.now {
                          showInfoModalView = true
                      }else{
                          self.alertGagal.toggle()
                      }
                      let fmt = ISO8601DateFormatter()

                      let date1 = tanggal_simpan
                      var date2 = tanggal_sekarang

                      let diffs = Calendar.current.dateComponents([.day, .hour, .minute], from: date1, to: date2)
                      

                      print("Final ini : \(diffs)")
                      
                      let today = Date.now
                      let formatter1 = DateFormatter()
                      formatter1.dateStyle = .short
                      print(formatter1.string(from: today))
                      
                      
//                      let timeInterval = tanggal_simpan.timeIntervalSince(tanggal_sekarang)
//                      print(timeInterval)
//                      print("Ini tanggal simpan : \(tanggal_simpan)")
                    
                  }, label: {
                      HStack{
                          Text("Rp. \(numVal),-")
                                .bold()
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.center)
                          Spacer()
                          Text(durasi)
                            Spacer()
                            Text(">")
                                .foregroundColor(.gray)
                                .bold()
                          

                          
                      }
                  })
                }
                .padding()
                .background(Color("aturlimit"))
                .cornerRadius(9)
                .sheet(isPresented: $showInfoModalView) {
                    InfoView(tanggal_simpan: $tanggal_simpan, numVal: $numVal)}
                
                Spacer()
                HStack{
                    Text("Rekap Pengeluaran Harian :")
                        .bold()
                        .multilineTextAlignment(.leading)
                    Spacer()
                    NavigationLink(destination: GrafikPengeluaranBulanan()){
                        Text("Lihat Data")
                    }
                }

                
                
                List{
                    ForEach (viewModellRekap.rekaps) { rekap in
                      bookRowViewRekap(rekap: rekap)
                    }
                    .onDelete() { indexSetRekap in
                      viewModellRekap.removeBooksRekap(atOffsets: indexSetRekap)
                    }
            
                }.padding(.horizontal, 0.0)
                    .cornerRadius(9)
                    
                    
            
                Spacer()

                NavigationLink(destination: TambahkanPengeluaran()) {
                    HStack(alignment:.center){
                        Spacer()
                        Text("+ Tambahkan pengeluaran").bold()
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                        
                        Spacer()
                           
                    }.padding()
                        .background(Color.green)
                        .cornerRadius(9)
                }
                    
                
                    
            }
            
            .navigationBarTitle(Text("Beranda"))
                .navigationBarItems(trailing: addButton)
                .onAppear() {
                  print("RekapListView appears. Subscribing to data updates.")
                  self.viewModellRekap.subscribeRekap()
                    self.viewModelBooks.subscribe()
                }
            
                .sheet(isPresented: self.$presentAddBookSheetRekap) {
                    RekapEditView()}
                .padding()
                .alert(isPresented: $alertGagal, content: {
                    Alert(title: Text("Tidak dapat mengubah limit!"), message: Text("Anda dapat mengubah limit setidaknya 7 hari setelah anda terakhir kali mengubah limit"), dismissButton: .default(Text("Oke")))
                })
            
            
            
    
                }
            
    }
}

struct InfoView: View {
  @Environment(\.presentationMode) var presentationMode
    @State var inputLimit: Int = UserDefaults.standard.integer(forKey: "limit")
    @State var tanggalToday: Date = Date().addingTimeInterval(0)
//        .addingTimeInterval(604800)
    @Binding var tanggal_simpan: Date
    @Binding var numVal: Int
    @State var nomor: Int = 0
    @State var tang: Date = Date()
  var body: some View {
      NavigationView{
          Form{
              Section(header: Text("Masukkan Limit")) {
//                  Text("Tambahkan Limit Disini")
//                          .bold()
                  TextField("Input Limit disini", value: $inputLimit, formatter: NumberFormatter())
//                          .border(Color.gray)
//                          .cornerRadius(3)
                          .keyboardType(.numberPad)
              }
              
              Section(header: Text("Tanggal update limit selanjutnya")) {
                  DatePicker("Tanggal", selection: $tanggalToday, in: Date()...)
                      .labelsHidden()
                      .disabled(true)
                      .multilineTextAlignment(.center)
              }
              
          }
          
          .navigationTitle(Text("Atur Limit"))
          .navigationBarTitleDisplayMode(.inline)
              .navigationBarItems(leading: Button(action: {
                  presentationMode.wrappedValue.dismiss()
                  
              }) {
                                      Text("Batal")
                                    },
                                  trailing: Button(action: {
                                  saveData()
                                  self.numVal = inputLimit
                  self.tanggal_simpan = tanggalToday
                                  presentationMode.wrappedValue.dismiss()
                  
              }) {
                                      Text("Selesai")
                                    })
      }
  }
    
    func saveData() {
        UserDefaults.standard.set(self.inputLimit, forKey: "limit")
        UserDefaults.standard.set(self.tanggalToday, forKey: "tanggallimit")
    }
    
    func getData() {
        nomor = UserDefaults.standard.integer(forKey: "limit")
        tang = UserDefaults.standard.object(forKey: "tanggallimit") as! Date
    }
}

struct Beranda_Previews: PreviewProvider {
    static var previews: some View {
        Beranda().environmentObject(SwiftUISpeech())
    }
}
