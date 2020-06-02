//
//  EdgeInsets+Extension.swift
//  
//
//  Created by Enes Karaosman on 2.06.2020.
//

import SwiftUI

public extension EdgeInsets {
    
    /// Inset for all side
    static func all(_ amount: CGFloat) -> EdgeInsets {
        EdgeInsets(top: amount, leading: amount, bottom: amount, trailing: amount)
    }
    
    /// Inset for Left-Right edges
    static func left_right(_ amount: CGFloat) -> EdgeInsets {
        EdgeInsets(top: 0, leading: amount, bottom: 0, trailing: amount)
    }
    
    /// Inset for Top-Bottom edges
    static func top_bottom(_ amount: CGFloat) -> EdgeInsets {
        EdgeInsets(top: amount, leading: 0, bottom: amount, trailing: 0)
    }
    
}
