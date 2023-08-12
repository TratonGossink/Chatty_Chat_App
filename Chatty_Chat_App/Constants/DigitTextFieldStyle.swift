

import Foundation
import SwiftUI

struct DigitTextFieldStyle: TextFieldStyle {
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        ZStack {
            VStack {
                Spacer()
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 40, height: 2)
            }
            .frame(height: 60)
            configuration
                .font(.system(size: 32))
                .padding(.leading, 25)
        }
    }
}
