//
//  GrafikPengeluaranBulanan.swift
//  CashOut2
//
//  Created by Adimas Surya Perdana Putra on 08/06/22.
//



import SwiftUICharts
import SwiftUI

struct GrafikPengeluaranBulanan: View {
    @ObservedObject var viewModellRekap = RekapsViewModel()
    @ObservedObject var viewModel = BooksViewModel()
    @StateObject var viewModelRekap = RekapViewModel()
    @StateObject var viewModelBooks = BooksViewModel()
    
    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter
    }()
    
    private func bookRowViewRekap(rekap: Rekap) -> some View {
          VStack(alignment: .leading) {

        VStack(alignment: .leading) {
            HStack {

                VStack(alignment: .leading) {
                    Spacer()
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
    
//    var dataku : Array<String> = RekapsViewModel.graphTotal(this)
    
    var body: some View {
            VStack{
                
                    List{
                        ForEach (viewModellRekap.rekaps) { rekap in
                          bookRowViewRekap(rekap: rekap)
                        }
                        .onDelete() { indexSetRekap in
                        viewModellRekap.removeBooksRekap(atOffsets: indexSetRekap)
                        }

                    }

                VStack{
                    Button(action: {
                        print(viewModel.grandTotal())
                    }) {
                      Text("Grafik Pengeluaran")
                    }
//                    let dataku: Array<Double> = viewModellRekap.graphTotal()

                    let colors: [Color] = [.red, .green, .blue]
                    //Legend
                    let ip = Legend(color: .blue,
                                    label: "Pengeluaran")
                    
                    let points: [DataPoint] = [
                        .init(value: viewModellRekap.PengeluaranHariIni(hariKe: 0), label: "\(Int(viewModellRekap.PengeluaranHariIni(hariKe: 0)))", legend: ip),
                        .init(value: viewModellRekap.PengeluaranHariIni(hariKe: 1), label: "\(Int(viewModellRekap.PengeluaranHariIni(hariKe: 1)))", legend: ip),
                        .init(value: viewModellRekap.PengeluaranHariIni(hariKe: 2), label: "\(Int(viewModellRekap.PengeluaranHariIni(hariKe: 2)))", legend: ip),
                        .init(value: viewModellRekap.PengeluaranHariIni(hariKe: 3), label: "\(Int(viewModellRekap.PengeluaranHariIni(hariKe: 3)))", legend: ip),
                        .init(value: viewModellRekap.PengeluaranHariIni(hariKe: 4), label: "\(Int(viewModellRekap.PengeluaranHariIni(hariKe: 4)))", legend: ip),
                        .init(value: viewModellRekap.PengeluaranHariIni(hariKe: 5), label: "\(Int(viewModellRekap.PengeluaranHariIni(hariKe: 5)))", legend: ip),
                        .init(value: viewModellRekap.PengeluaranHariIni(hariKe: 6), label: "\(Int(viewModellRekap.PengeluaranHariIni(hariKe: 6)))", legend: ip),
                        .init(value: viewModellRekap.PengeluaranHariIni(hariKe: 7), label: "\(Int(viewModellRekap.PengeluaranHariIni(hariKe: 7)))", legend: ip),
                        .init(value: viewModellRekap.PengeluaranHariIni(hariKe: 8), label: "\(Int(viewModellRekap.PengeluaranHariIni(hariKe: 8)))", legend: ip),
                        .init(value: viewModellRekap.PengeluaranHariIni(hariKe: 9), label: "\(Int(viewModellRekap.PengeluaranHariIni(hariKe: 9)))", legend: ip),
                        .init(value: viewModellRekap.PengeluaranHariIni(hariKe: 10), label: "\(Int(viewModellRekap.PengeluaranHariIni(hariKe: 10)))", legend: ip),
                    ]

                    //Line
                    
                    HorizontalBarChartView(dataPoints: points)
                        .padding()
                    //Bar
                }.navigationTitle(Text("Grafik"))

                
            }.navigationTitle(Text("Grafik"))
            .onAppear() {
                print("RekapListView appears. Subscribing to data updates.")
                self.viewModellRekap.subscribeRekap()
                  self.viewModelBooks.subscribe()
                }
    }
}


struct GrafikPengeluaranBulanan_Previews: PreviewProvider {
    static var previews: some View {
        GrafikPengeluaranBulanan()
    }
}

