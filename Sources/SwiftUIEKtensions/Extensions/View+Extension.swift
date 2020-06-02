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
        
}
