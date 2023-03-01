//
//  SpeechButton2.swift
//  Speech to Text
//
//  Created by Adimas Surya Perdana Putra on 03/04/22.
//  Copyright © 2022 Joel Joseph. All rights reserved.
//

import Speech
import SwiftUI
import Foundation

struct SpeechButtonForNominal: View {
    
    @State var isPressed:Bool = false
    @State var actionPop:Bool = false
    @EnvironmentObject var swiftUISpeechNominal:SwiftUISpeechForNominal
    
    var body: some View {
        
        Button(action:{// Button
            if(self.swiftUISpeechNominal.getSpeechStatus() == "Denied - Close the App"){// checks status of auth if no auth pop up error
                self.actionPop.toggle()
            }else{
                withAnimation(.spring(response: 0.4, dampingFraction: 0.3, blendDuration: 0.3)){self.swiftUISpeechNominal.isRecording.toggle()}// button animation
                self.swiftUISpeechNominal.isRecording ? self.swiftUISpeechNominal.startRecording() : self.swiftUISpeechNominal.stopRecording()
            }
        }){
            Image(systemName: "waveform")// Button Image
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.white)
                .background(swiftUISpeechNominal.isRecording ? Circle().foregroundColor(.red).frame(width: 85, height: 85) : Circle().foregroundColor(.blue).frame(width: 70, height: 70))
        }.actionSheet(isPresented: $actionPop){
            ActionSheet(title: Text("ERROR: - 1"), message: Text("Access Denied by User"), buttons: [ActionSheet.Button.destructive(Text("Reinstall the Appp"))])// Error catch if the auth failed or denied
        }
    }
}

struct ButtonForNominal_Previews: PreviewProvider {
    static var previews: some View {
        SpeechButtonForNominal().environmentObject(SwiftUISpeechForNominal())
            .environmentObject(BookViewModel())
    }
}

