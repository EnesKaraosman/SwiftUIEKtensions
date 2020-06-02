//
//  File.swift
//  
//
//  Created by Enes Karaosman on 2.06.2020.
//

import SwiftUI

/**
 In `SceneDelegate.swift` create an instance
 let device = DeviceOrientation()
 
 For inital state,
 device.isLandscape = (windowScene.interfaceOrientation.isLandscape == true)
 assign when `windowScene` is created
 
 Then;
 
 func windowScene(_ windowScene: UIWindowScene, didUpdate previousCoordinateSpace: UICoordinateSpace, interfaceOrientation previousInterfaceOrientation: UIInterfaceOrientation, traitCollection previousTraitCollection: UITraitCollection) {
     device.isLandscape.toggle() <== Put
 }
 
 */

final public class DeviceOrientation: ObservableObject {
    @Published var isLandscape: Bool = false
}
