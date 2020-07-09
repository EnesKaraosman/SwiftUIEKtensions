//
//  CheckmarkModifier.swift
//  
//
//  Created by Enes Karaosman on 9.07.2020.
//

import SwiftUI

public struct CheckmarkModifier: ViewModifier {
    
    public init() { }
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content
            Image(systemName: "checkmark")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.green)
                .shadow(radius: 1)
        }
    }
}

