//
//  ScrollViewProxy.swift
//  
//
//  Created by Enes Karaosman on 9.04.2024.
//

import SwiftUI

public extension ScrollViewProxy {
    func asyncScrollTo(
        _ id: String,
        position: UnitPoint = .center,
        animate: Bool = true
    ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            if animate {
                withAnimation(.easeInOut(duration: 1)) {
                    self.scrollTo(id, anchor: position)
                }
            } else {
                self.scrollTo(id, anchor: position)
            }
        }
    }
}
