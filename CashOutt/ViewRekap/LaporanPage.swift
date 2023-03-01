//
//  LaporanPage.swift
//  CashOut!
//
//  Created by Adimas Surya Perdana Putra on 08/06/22.
//  Copyright © 2022 Joel Joseph. All rights reserved.
//

//import SwiftUI
//import SwiftUICharts
//
//struct LaporanPage: View {
////    @State private var pengeluaranns: [Pengeluaran] = [Pengeluaran]()
////    @State private var kategoriis: [Kategori] = [Kategori]()
////
////    @FetchRequest(entity: Pemasukan.entity(), sortDescriptors: []) var pemasukan: FetchedResults<Pemasukan>
////    @FetchRequest(entity: Pengeluaran.entity(), sortDescriptors: []) var pengeluaran: FetchedResults<Pengeluaran>
////    @FetchRequest(entity: Kategori.entity(), sortDescriptors: []) var kategori: FetchedResults<Kategori>
////
////    @FetchRequest(entity: Pengeluaran.entity(), sortDescriptors: [], predicate: NSPredicate(format: "tanggal > %@", Date().self as CVarArg)) var pengToday: FetchedResults<Pengeluaran>
////    @FetchRequest(entity: Pengeluaran.entity(), sortDescriptors: [], predicate: NSPredicate(format: "tanggal <= %@", Date.self() as CVarArg)) var pengYesterday: FetchedResults<Pengeluaran>
////
////    @FetchRequest(entity: Kategori.entity(), sortDescriptors: [], predicate: NSPredicate(format: "nama_kategori == 'Primer'")) var persenPrimer: FetchedResults<Kategori>
////    @FetchRequest(entity: Kategori.entity(), sortDescriptors: [], predicate: NSPredicate(format: "nama_kategori == 'Investasi'")) var persenInvest: FetchedResults<Kategori>
////    @FetchRequest(entity: Kategori.entity(), sortDescriptors: [], predicate: NSPredicate(format: "nama_kategori == 'Hiburan'")) var persenHiburan: FetchedResults<Kategori>
////    @FetchRequest(entity: Kategori.entity(), sortDescriptors: [], predicate: NSPredicate(format: "nama_kategori == 'Dana Darurat'")) var persenDarurat: FetchedResults<Kategori>
////
////    @FetchRequest(entity: Pemasukan.entity(), sortDescriptors: [], predicate: NSPredicate(format: "id_kategori == 'Primer'")) var pemPrimer: FetchedResults<Pemasukan>
////    @FetchRequest(entity: Pemasukan.entity(), sortDescriptors: [], predicate: NSPredicate(format: "id_kategori == 'Investasi'")) var pemInvest: FetchedResults<Pemasukan>
////    @FetchRequest(entity: Pemasukan.entity(), sortDescriptors: [], predicate: NSPredicate(format: "id_kategori == 'Hiburan'")) var pemHiburan: FetchedResults<Pemasukan>
////    @FetchRequest(entity: Pemasukan.entity(), sortDescriptors: [], predicate: NSPredicate(format: "id_kategori == 'Dana Darurat'")) var pemDarurat: FetchedResults<Pemasukan>
////
////    @FetchRequest(entity: Pengeluaran.entity(), sortDescriptors: [], predicate: NSPredicate(format: "id_kategori == 'Primer'")) var pengPrimer: FetchedResults<Pengeluaran>
////    @FetchRequest(entity: Pengeluaran.entity(), sortDescriptors: [], predicate: NSPredicate(format: "id_kategori == 'Investasi'")) var pengInvest: FetchedResults<Pengeluaran>
////    @FetchRequest(entity: Pengeluaran.entity(), sortDescriptors: [], predicate: NSPredicate(format: "id_kategori == 'Hiburan'")) var pengHiburan: FetchedResults<Pengeluaran>
////    @FetchRequest(entity: Pengeluaran.entity(), sortDescriptors: [], predicate: NSPredicate(format: "id_kategori == 'Dana Darurat'")) var pengDarurat: FetchedResults<Pengeluaran>
////
////    let coreDM: CDManager
//    
//    var body: some View {
//        ScrollView{
//            VStack(alignment: .leading){
//                Text("Laporan")
//                    .font(.title)
//                    .fontWeight(.heavy)
//                    .padding(.bottom, 30)
//                
//                let lgdPem = Legend(color: .blue, label: "Pemasukan")
//                let lgdPeng = Legend(color: .yellow, label: "Pengeluaran")
//                
//                let lgdToday = Legend(color: .pink, label: "Hari ini")
//                let lgdYesterday = Legend(color: .red, label: "Kemarin")
//                
//                let points: [DataPoint] = [
//                    .init(value: Double(totalPemasukan()) ?? 0, label: "\(totalPemasukan())", legend:lgdPem),
//                    .init(value: Double(totalPengeluaran()) ?? 0, label: "\(totalPengeluaran())", legend:lgdPeng)
//                ]
//                
//                let points2: [DataPoint] = [
//                    .init(value: Double(totalToday()) ?? 0, label: "\(totalToday())", legend:lgdToday),
//                    .init(value: Double(totalYesterday()) ?? 0, label: "\(totalYesterday())", legend:lgdYesterday)
//                ]
//                
//                // Persentase Aktivitas
//                Text("Persentase Aktivitas")
//                    .font(.headline)
//                    .fontWeight(.bold)
//                    .padding(.bottom, 12)
//                
//                VStack{
//                    BarChartView(dataPoints: points)
//                        .frame(height: UIScreen.main.bounds.size.height/3)
//                        .padding()
//                }
//                .padding(20)
//                .background(Color("myGray"))
//                .cornerRadius(8)
//                .padding(.bottom, 30)
//                // close Persentase Aktivitas
//                
//                // Perbandingan Hari ini dan Kemarin
//                Text("Perbandingan Hari ini dan Kemarin")
//                    .font(.headline)
//                    .fontWeight(.bold)
//                    .padding(.bottom, 12)
//                
//                VStack{
//                    BarChartView(dataPoints: points2)
//                        .frame(height: UIScreen.main.bounds.size.height/3)
//                        .padding()
//                }
//                .padding(20)
//                .background(Color("myGray"))
//                .cornerRadius(8)
//                .padding(.bottom, 30)
//                // close Perbandingan Hari ini dan Kemarin
//                
//                // Perbandingan Kategori
//                Text("Perbandingan Kategori")
//                    .font(.headline)
//                    .fontWeight(.bold)
//                    .padding(.bottom, 12)
//                HStack(alignment: .top){
//                    VStack(alignment: .leading, spacing: 8){
//                        Text("Nama")
//                        Text("Primer")
//                        Text("Investasi")
//                        Text("Hiburan")
//                        Text("Darurat")
//                    }
//                    Spacer()
//                    VStack(alignment: .leading, spacing: 8){
//                        Text("Persen")
//                        Text("\(percentPrimer())")
//                        Text("\(percentInvest())")
//                        Text("\(percentHiburan())")
//                        Text("\(percentDarurat())")
//                    }
//                    Spacer()
//                    VStack(alignment: .leading, spacing: 8){
//                        Text("Realita")
//                        Text("\(totalPrimer())")
//                        Text("\(totalInvest())")
//                        Text("\(totalHiburan())")
//                        Text("\(totalDarurat())")
//                    }
//                }
//                .padding(20)
//                .background(Color("myGray"))
//                .cornerRadius(8)
//                .padding(.bottom, 30)
//                // close Perbandingan Kategori
//                
//                // list
////                Text("Perbandingan Kategori2")
////                VStack{
////                    List{
////                        ForEach(kategoriis, id: \.self) {pema in
////                            HStack(alignment: .top, spacing: 8){
////                                Text("\(pema.nama_kategori ?? "Data nil")")
////                                Text("\(pema.persentase)")
////                                Text("realita")
//////                                VStack(alignment: .leading){
//////                                    Text("\(pema.deskripsi ?? "Data nil")")
//////                                    Text("\(pema.tanggal ?? hariTglText, style: .date)")
//////                                        .foregroundColor(Color("myGray50"))
//////                                    Text("\(pema.id_kategori ?? "Data nil")")
//////                                        .foregroundColor(Color("myGray50"))
//////                                }
//////                                VStack(alignment: .trailing, spacing: 8){
//////                                    Text("\(pema.jumlah)")
//////                                    Circle()
//////                                        .fill(Color("myGreen1"))
//////                                        .frame(width: 20, height: 20)
//////                                }
////                            }
////                            .padding(12)
////                            .background(Color("myGreen1"))
////                            .cornerRadius(8)
////                        }
////                        .onDelete(perform: { indexSet in
////                            indexSet.forEach { index in
////                                let kategori = kategoriis[index]
////                                coreDM.hapusKategori(kategori: kategori)
////                                kategoriis = coreDM.getAllKategori()
////                            }
////                        })
////                    }
////                    .listStyle(.plain)
////                }
////                .frame(maxHeight: .infinity)
////                .padding(.bottom, 10)
////                .padding(.horizontal, 20)
////                .onAppear(perform: {
////                    kategoriis = coreDM.getAllKategori()
////                })
//                // close list
//                
//                // button buat ngecek
////                Button("percentPrimerr()") {
////                    print("percentPrimer(): \(percentPrimer())")
////                    print("persenPrimer: \(persenPrimer)")
////                    print("coreDM: \(coreDM)")
////                    print("getAll: \(coreDM.getAllKategori())")
////                    print("kategoriis: \(kategoriis)")
////                }
////
////                ForEach(pengeluaran, id: \.tanggal){ list in
////                    Text("\(list.tanggal ?? Date(), style: .date)")
////                    Text("\(list.jumlah)")
////                }
//                // close button buat ngecek
//                
////                ForEach(pengeluaranns) {tralala in
////                    VStack(alignment: .leading) {
////                        Text(tralala.tanggal)
////                    }
////                }
//            }
//            .padding(.horizontal, 20)
//            .onAppear(perform: {
//                pengeluaranns = coreDM.getAllPengeluaran()
//                kategoriis = coreDM.getAllKategori()
//            })
//        }
//    }
//    
//    func testTest() {
//        var details : [[String:Any]] = [] // buat bikin variabel yg nanti bakal nyimpen getAll
//        var details2 : [[Date]] = [] // buat bikin variabel yg nanti bakal nyimpen getAll
//        var hasilFilter = Date()
//        pengeluaran.forEach{(rekap) in
//            details.append([
//                "jumlah" : rekap.jumlah            ])
//            print("\(details)")
//        }
////        hasilFilter = details.filter{$0.day}
//    }
//    
//    func getPricer(value: Float) -> String{
//        let format = NumberFormatter()
//        return format.string(from: NSNumber(value: value)) ?? ""
//    }
//    
//    func totalPemasukan() -> String {
//        var pemResult = 0
//        
//        rekap.forEach{ (n) in
//            pemResult += Int(n.jumlah)
//        }
//        
//        return String(pemResult)
//    }
//    
//    func totalPengeluaran() -> String {
//        var pengResult = 0
//        
//        pengeluaran.forEach{ (n) in
//            pengResult += Int(n.jumlah)
//        }
//        
//        return String(pengResult)
//    }
//    
//    func totalToday() -> String {
//        var pengResult = 0
//        
//        pengToday.forEach{ (n) in
//            pengResult += Int(n.jumlah)
//        }
//        
//        return String(pengResult)
//    }
//    
//    func totalYesterday() -> String {
//        var pengResult = 0
//        
//        pengYesterday.forEach{ (n) in
//            pengResult += Int(n.jumlah)
//        }
//        
//        return String(pengResult)
//    }
//    
//    func percentPrimer() -> String {
//        var pengResult: Float = 0
//        
//        persenPrimer.forEach{ (n) in
//            pengResult += Float(n.persentase)
//        }
//        
//        return getPricer(value: pengResult)
//    }
//    
//    func percentInvest() -> String {
//        var pengResult: Float = 0
//        
//        persenInvest.forEach{ (n) in
//            pengResult += Float(n.persentase)
//        }
//        
//        return getPricer(value: pengResult)
//    }
//    
//    func percentHiburan() -> String {
//        var pengResult: Float = 0
//        
//        persenHiburan.forEach{ (n) in
//            pengResult += Float(n.persentase)
//        }
//        
//        return getPricer(value: pengResult)
//    }
//    
//    func percentDarurat() -> String {
//        var pengResult: Float = 0
//        
//        persenDarurat.forEach{ (n) in
//            pengResult += Float(n.persentase)
//        }
//        
//        return getPricer(value: pengResult)
//    }
//    
//    func totalPrimer() -> Int {
//        var pemResult = 0
//        var pengResult = 0
//        
//        pemPrimer.forEach{ (n) in
//            pemResult += Int(n.jumlah)
//        }
//        
//        pengPrimer.forEach{ (n) in
//            pengResult += Int(n.jumlah)
//        }
//        
//        return pemResult - pengResult
//    }
//    
//    func totalInvest() -> Int {
//        var pemResult = 0
//        var pengResult = 0
//        
//        pemInvest.forEach{ (n) in
//            pemResult += Int(n.jumlah)
//        }
//        
//        pengInvest.forEach{ (n) in
//            pengResult += Int(n.jumlah)
//        }
//        
//        return pemResult - pengResult
//    }
//    
//    func totalHiburan() -> Int {
//        var pemResult = 0
//        var pengResult = 0
//        
//        pemHiburan.forEach{ (n) in
//            pemResult += Int(n.jumlah)
//        }
//        
//        pengHiburan.forEach{ (n) in
//            pengResult += Int(n.jumlah)
//        }
//        
//        return pemResult - pengResult
//    }
//    
//    func totalDarurat() -> Int {
//        var pemResult = 0
//        var pengResult = 0
//        
//        pemDarurat.forEach{ (n) in
//            pemResult += Int(n.jumlah)
//        }
//        
//        pengDarurat.forEach{ (n) in
//            pengResult += Int(n.jumlah)
//        }
//        
//        return pemResult - pengResult
//    }
//}
//
//struct UserModel: Identifiable {
//    let batas_min: Int
//    let id_kategori: String
//    let nama_kategori: String
//    let persentase: Int
//    let id = UUID().uuidString
//    let dateBener: Bool
//}
//
////class abc: ObservableObject {
////    @State private var pengeluaranns2: [Pengeluaran] = [Pengeluaran]()
////    @FetchRequest(entity: Pengeluaran.entity(), sortDescriptors: []) var pengeluaran2: FetchedResults<Pengeluaran>
////    @Published var popo: [UserModel] = []
////    var halo: Date
////    init() {
////        filteras()
////    }
////    func filteras(){
////        halo = pengeluaranns2.filter({ (tralala) -> Bool in
////            if day1 <= Date() {
////                return tralala.tanggal
////            }
////        })
////        halo = pengeluaranns2.filter({$0.tanggal})
////
////    }
////}
//
//public extension Date {
//
//    static func parse(_ string: String, format: String = "yyyy-MM-dd") -> Date {
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = NSTimeZone.default
//        dateFormatter.dateFormat = format
//
//        let date = dateFormatter.date(from: string)!
//        return date
//    }
//
//    func dateString(_ format: String = "yyyy-MM-dd") -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = format
//        return dateFormatter.string(from: self)
//    }
//}
//
//struct LaporanPage_Previews: PreviewProvider {
//    static var previews: some View {
//        LaporanPage(coreDM: CDManager())
//    }
//}
