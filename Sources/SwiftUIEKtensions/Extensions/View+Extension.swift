//
//  View+Extension.swift
//  
//
//  Created by Enes Karaosman on 2.06.2020.
//

import SwiftUI

public extension View {
    
    @inlinable
    func then(_ body: (inout Self) -> Void) -> Self {
        var result = self
        body(&result)
        return result
    }
    
    /// Wraps view inside `AnyView`
    func embedInAnyView() -> AnyView {
        AnyView( self )
    }
    
    /// Wraps view inside `AnyView`
    func eraseToAnyView() -> AnyView { embedInAnyView() }
    
    /// Wraps view inside `NavigationView`
    func embedInNavigation() -> some View {
        NavigationView { self }
    }
    
    /// Apply 1 of the modifiers based on condition.
    func apply1of2ModifierOnCondition<M1: ViewModifier, M2: ViewModifier>
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
    func applyModifierOnCondition<M: ViewModifier>
        (on condition: Bool, trueCase: M) -> some View {
        Group {
            if condition {
                self.modifier(trueCase)
            }
        }
    }
    
    /// Apply modifier if condition is true, otherwise returns itself.
    func applyModifierOnConditionOrReturnSelf<M: ViewModifier>
        (on condition: Bool, trueCase: M) -> some View {
        Group {
            if condition {
                self.modifier(trueCase)
            } else {
                self
            }
        }
    }
    
    @inlinable
    public func hidden(_ isHidden: Bool) -> some View {
        Group {
            if isHidden {
                hidden()
            } else {
                self
            }
        }
    }
        
}
