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
    
    public var portrait: Content
    public var landscape: Content
    
    
    /// Portrait & Landscape orientation closures to represent when the related DeviceOrientation is active
    /// - Parameters:
    ///   - portrait: `View` that is represented in `Portrait` mode
    ///   - landscape: `View` that is represented in `Landscape` mode
    public init(
        @ViewBuilder portrait: () -> Content,
        @ViewBuilder landscape: () -> Content
    ) {
        self.portrait = portrait()
        self.landscape = landscape()
    }
    
    public var body: some View {
        if !device.isLandscape {
            return portrait
        } else {
            return landscape
        }
    }
    
}
