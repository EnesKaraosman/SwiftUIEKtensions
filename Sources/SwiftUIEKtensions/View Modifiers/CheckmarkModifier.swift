//
//  CheckmarkModifier.swift
//  
//
//  Created by Enes Karaosman on 9.07.2020.
//

import SwiftUI

public struct CheckmarkModifier: ViewModifier {
    
    var checked: Bool
    
    public init(checked: Bool = false) {
        self.checked = checked
    }
    
    public func body(content: Content) -> some View {
        Group {
            if checked {
                ZStack(alignment: .trailing) {
                    content
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.green)
                        .shadow(radius: 1)
                }
            } else {
                content
            }
        }
    }
}

