//
//  ViewExtensions.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 9/19/23.
//

import Foundation
import SwiftUI

extension View {
    
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
            
            ZStack(alignment: alignment) {
                placeholder().opacity(shouldShow ? 1 : 0)
                self
            }
            
        }
    
}
