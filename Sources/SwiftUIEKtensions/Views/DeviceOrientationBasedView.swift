//
//  OrientationBasedView.swift
//  
//
//  Created by Enes Karaosman on 2.06.2020.
//

import SwiftUI

#if canImport(UIKit)

/**
 Recommended Usage, put `DeviceOrientationBasedView` inside let say in a page's body
 
 `DeviceOrientationBasedView`(
     `portrait`: {
        // some `View`
     },
     `landscape`: {
         // some `View`
     }
 )
 */
public struct DeviceOrientationBasedView<Content: View>: View {
    
    @EnvironmentObject var device: DeviceOrientationInfo
    
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
    
    @ViewBuilder public var body: some View {
        if device.orientation == .portrait {
            portrait
        } else {
            landscape
        }
    }
    
}
#endif
