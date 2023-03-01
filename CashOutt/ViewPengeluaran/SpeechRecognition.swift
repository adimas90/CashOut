//
//  SpeechRecognition.swift
//  LibFirebase
//
//  Created by Adimas Surya Perdana Putra on 05/04/22.
//

import SwiftUI
import Foundation
import Combine
import FirebaseFirestore
import Speech

enum Mode {
  case new
  case edit
}
 
enum Action {
  case delete
  case done
  case cancel
}

struct SpeechRecognition: View {
    @State var clicked:Bool = false
    @EnvironmentObject var swiftUISpeech:SwiftUISpeech
    @EnvironmentObject var swiftUISpeechNominal:SwiftUISpeechForNominal
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
    @State var textPengeluaran:String = ""
    @State var textspeechs: String = ""
    @ObservedObject var viewModel = BookViewModel()
    var mode: Mode = .new
    var completionHandler: ((Result<Action, Error>) -> Void)?
     
     
    var cancelButton: some View {
      Button(action: { self.handleCancelTapped() }) {
        Text("Batal")
      }
    }
    
    public class SpeechRecog: ObservableObject{
        @EnvironmentObject var swiftUISpeech:SwiftUISpeech
        @Published var textspeechs: String = ""
        @ObservedObject var sre = SwiftUISpeech()

//        func speechCovertz(text: String) -> String{
////            textspeechs = sre.outputText
//            textspeechs = "helloow"
////            return speechCovertz()
//            return text
//        }
        func getSpeech(value: String) -> String{

            return String(value)
        }
        
        func grandSpeech() -> String {
            var stung : String = ""
            
            stung = swiftUISpeech.outputText
            
            return getSpeech(value: stung)
            
        }
        
    }
    
    func speechConvert() {
        textspeechs = swiftUISpeech.outputText

    }
    
    func getSpeech(value: String) -> String{

        return String(value)
    }
    
    func grandSpeech() -> String {
        var stung : String = ""
        
        stung = swiftUISpeech.outputText
        
        return getSpeech(value: stung)
        
    }
    
    
     
    var saveButton: some View {
        
      Button(action: {
//          clicked = true
          
          self.handleDoneTapped(nama: swiftUISpeech.outputText, nominal: swiftUISpeechNominal.outputNominal)
          self.textspeechs = swiftUISpeech.outputText


          
      }) {
        Text(mode == .new ? "Selesai" : "Save")
      }
//      .disabled(!viewModel.modified)
    }

    
    var body: some View {
        NavigationView{

            
//                let textSpeech = self.$viewModel.book.nama_pengeluaran
                
                VStack(alignment: .center, spacing: 10) {
                    DatePicker("Tanggal", selection: $viewModel.book.tanggal, in: ...Date() , displayedComponents: .date)
                        .labelsHidden()
                        .hidden()
                        .padding(.top, -30)
                    VStack(spacing: 15){
                        Text("Apa Pengeluaran mu?")
                            .bold()
                        
//                        Text("\(swiftUISpeech.outputText)")
//                            .fontWeight(.bold)
//                            .foregroundColor(.orange)
//                            .multilineTextAlignment(.center)
//                            .font(.title)
                        TextField("", text: $swiftUISpeech.outputText)
                            .foregroundColor(.orange)
                            .font(.title)
                            
    //
    //                    TextField("",text: $swiftUISpeech.outputText, $viewModel.book.nama_pengeluaran)
                        
//                        TextField(swiftUISpeech.outputText,   text :
////                                    $swiftUISpeech.outputText
//                                  $viewModel.book.nama_pengeluaran
//                                  
//                        ).submitScope()
//                            .onSubmit({
//                                self.viewModel.book.nama_pengeluaran = swiftUISpeech.outputText
//                            })

                        
                            .multilineTextAlignment(.center)
                            .disableAutocorrection(true)
                        
                    
    //                        .fontWeight(.bold)
    //                        .foregroundColor(.orange)
    //                        .multilineTextAlignment(.center)
    //                        .font(.title)
                        // prints results to screen
                            
                        
                    }.frame(width: 300,height: 250)
                    
                    VStack {// Speech button
                        
                        swiftUISpeech.getButton()
                            
                        
                    }
                    
                    VStack(spacing: 15){
                        Text("Berapa Nominalnya?")
                            .bold()
                        
//                        Text("Rp. \(swiftUISpeechNominal.outputNominal),-")
//                            .fontWeight(.bold)
//                            .foregroundColor(.orange)
//                            .multilineTextAlignment(.center)
//                            .font(.title)
                        TextField("", text: $swiftUISpeechNominal.outputNominal)
                            .foregroundColor(.orange)
                            .font(.title)
//                        
//                        TextField(swiftUISpeechNominal.outputNominal, value: $viewModel.book.nominal, formatter: NumberFormatter())
                            .multilineTextAlignment(.center)
                        
                    
                            
                        // prints results to screen
                            
                        
                    }.frame(width: 300,height: 250)
                    
                    VStack {// Speech button
                        
                        swiftUISpeechNominal.getButton()
                            
                        
                    }
                    Spacer()
                    
                    VStack(spacing: -3){
                        VStack(alignment: .leading){
                            Text("* Note : ")
                                .padding()
                                .multilineTextAlignment(.leading)
                                .font(.caption)
                        }
                        
                        VStack{
                            Text("Tekan tombol sampai berwarna \(Text("merah").foregroundColor(.red)),")
                                .multilineTextAlignment(.center)
                                .font(.caption)
                                .padding(.top, -5)

                            Text("lalu mulailah berbicara secara jelas")
                                .multilineTextAlignment(.center)
                                .font(.caption)
                            Spacer()
                        }
        
                    
                    }.padding()
                    Spacer()

    //                Button(action: {
    //
    //                }){
    //                    HStack(alignment:.center){
    //                        Spacer()
    //                        HStack{
    //                            Image(systemName: "mic.badge.plus")
    ////                                .fixedSize(horizontalvertical: 20)
    //                            Text("Tambahkan pengeluaran").bold()
    //                        }
    //
    //                        .foregroundColor(Color.black)
    //                        .multilineTextAlignment(.center)
    //
    //                        Spacer()
    //
    //                    }.padding()
    //                        .background(Color.green)
    //                        .cornerRadius(9)
    //                }
                }
                .padding(.bottom, 50)
                .navigationTitle(mode == .new ? "Input Pengeluaran Baru" : viewModel.book.nama_pengeluaran)
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
     
    func handleDoneTapped(nama: String, nominal: String) {
        self.viewModel.handleDoneTapped(nama: nama, nominal: nominal)
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
    






struct SpeechRecognition_Previews: PreviewProvider {
    @EnvironmentObject var swiftUISpeech:SwiftUISpeech
    @EnvironmentObject var swiftUISpeechNominal:SwiftUISpeechForNominal
    var bookView = BookViewModel()

    static var previews: some View {
       
        let book = Book(nama_pengeluaran: "", nominal: 0, tanggal: Date())
        let bookViewModel = BookViewModel(book: book)
        return  SpeechRecognition(viewModel: bookViewModel, mode: .edit).environmentObject(SwiftUISpeech())
            .environmentObject(BookViewModel())
            
        
    }
}

