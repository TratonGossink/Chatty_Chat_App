//
//  Fonts.swift
//  Chatty_Chat_App
//
//  Created by Traton Gossink on 7/28/23.
//

import Foundation
import SwiftUI

extension Font{
    
    public static var bodyParagraph: Font {
        return Font.custom("LexendDeca-Regular", size: 14)
    }
    
    public static var buttonText: Font {
        return Font.custom("LexendDeca-SemiBold", size: 14)
    }
    
    public static var smallCaption: Font {
        return Font.custom("LexendDeca-Regular", size: 12)
    }
    
    public static var mainHeading: Font {
        return Font.custom("LexendDeca-SemiBold", size: 28)
    }
    
    public static var subHeading: Font {
        return Font.custom("LexendDeca-SemiBold", size: 19)
    }
    
    public static var subFooter: Font {
        return Font.custom("LexendDeca-Regular", size: 10)
    }
    
    public static var mainTitle: Font {
        return Font.custom("LexendDeca-SemiBold.ttf", size: 23)
    }
    public static var chatName: Font {
        return Font.custom("LexendDeca-SemiBold", size: 12)
    }
}


