//
//  CashOuttApp.swift
//  CashOutt
//
//  Created by Adimas Surya Perdana Putra on 09/06/22.
//

import SwiftUI
import Firebase

@main
struct SpeechToText: App {
 
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var swiftUISpeech = SwiftUISpeech()
    var swiftUISpeechNominal = SwiftUISpeechForNominal()
    var speech = SwiftUISpeechForNominal()
//    var bookView = BookViewModel()
    var body: some Scene {
        WindowGroup {
            Beranda().environmentObject(swiftUISpeech)
                .environmentObject(swiftUISpeechNominal)
                .environmentObject(speech)
            
//            Coba().environmentObject(swiftUISpeech)
//            ContentView()
//            SpeechRecognition().environmentObject(swiftUISpeech)
//                .environmentObject(swiftUISpeechNominal)
        }
    }
}
 
class AppDelegate: NSObject,UIApplicationDelegate{
     
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Thread.sleep(forTimeInterval: 1.0)
        FirebaseApp.configure()
        Auth.auth().signInAnonymously()
        return true
    }
}


