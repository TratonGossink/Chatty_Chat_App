//
//  ProfileTextFieldStyle.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 8/1/23.
//

import Foundation
import SwiftUI

struct profileTextFieldStyle: TextFieldStyle {

    func _body(configuration: TextField<Self._Label>) -> some View {
        
     
        
        ZStack {
            Rectangle()
                .foregroundColor(Color("input"))
                .cornerRadius(8)
                .frame(height: 46)
                .padding()
            configuration
                .font(Font.buttonText)
                .padding(.leading, 36)
        }
    }
}
