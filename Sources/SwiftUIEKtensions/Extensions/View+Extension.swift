//
//  View+Extension.swift
//  
//
//  Created by Enes Karaosman on 2.06.2020.
//

import SwiftUI

public extension View {
    
    /// Wraps view inside `AnyView`
    func embedInAnyView() -> AnyView {
        return AnyView( self )
    }
    
    /// Wraps view inside `AnyView`
    func eraseToAnyView() -> AnyView { return embedInAnyView() }
    
    /// Apply 1 of the modifiers based on condition.
    func conditionalModifier<M1: ViewModifier, M2: ViewModifier>
        (on condition: Bool, trueCase: M1, falseCase: M2) -> some View {
        Group {
            if condition {
                self.modifier(trueCase)
            } else {
                self.modifier(falseCase)
            }
        }
    }
    
    /// Apply modifier if condition matches, otherwise do nothing.
    func conditionalModifier<M: ViewModifier>
        (on condition: Bool, trueCase: M) -> some View {
        Group {
            if condition {
                self.modifier(trueCase)
            }
        }
    }
        
}
