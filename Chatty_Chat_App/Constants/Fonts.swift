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
        return Font.custom("LexandDeca-Regular", size: 14)
    }
    
    public static var buttonText: Font {
        return Font.custom("LexandDeca-SemiBold", size: 14)
    }
    
    public static var smallCaption: Font {
        return Font.custom("LexandDeca-Regular", size: 12)
    }
    
    public static var mainHeading: Font {
        return Font.custom("LexandDeca-SemiBold", size: 32)
    }
    
    public static var subHeading: Font {
        return Font.custom("LexandDeca-SemiBold", size: 19)
    }
    
    public static var subFooter: Font {
        return Font.custom("LexandDeca-Regular", size: 10)
    }
    
    public static var titleText: Font {
        return Font.custom("LexandDeca-Bold", size: 23)
    }
}


