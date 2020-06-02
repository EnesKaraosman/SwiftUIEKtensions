//
//  OrientationBasedView.swift
//  
//
//  Created by Enes Karaosman on 2.06.2020.
//

import SwiftUI

/**
 Recommended Usage, put `OrientationBasedView` inside let say in a page's body
 
 `OrientationBasedView`(
     `portrait`: {
         {} // View
         .embedInAnyView()
     },
     `landscape`: {
         {} // View
         .embedInAnyView()
     }
 )
 */
public struct OrientationBasedView<Content: View>: View {
    
    @EnvironmentObject var device: DeviceOrientation
    
    public var portrait: () -> Content
    public var landscape: () -> Content
    
    public init(portrait: @escaping () -> Content, landscape: @escaping () -> Content) {
        self.portrait = portrait
        self.landscape = landscape
    }
    
    public var body: some View {
        if !device.isLandscape {
            return portrait()
        } else {
            return landscape()
        }
    }
    
}
