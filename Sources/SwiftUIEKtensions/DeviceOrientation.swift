//
//  OrientationInfo.swift
//
//
//  Created by Enes Karaosman on 6.08.2020.
//

import class UIKit.UIDevice
import SwiftUI

final public class DeviceOrientationInfo: ObservableObject {
    enum Orientation {
        case portrait
        case landscape
    }
    
    @Published var orientation: Orientation
    
    private var _observer: NSObjectProtocol?
    
    public init() {
        // fairly arbitrary starting value for 'flat' orientations
        self.orientation = UIDevice.current.orientation.isLandscape ? .landscape : .portrait
        
        // unowned self because we unregister before self becomes invalid
        _observer = NotificationCenter.default.addObserver(
            forName: UIDevice.orientationDidChangeNotification,
            object: nil,
            queue: nil
        ) { [unowned self] note in
            guard let device = note.object as? UIDevice else {
                return
            }
            if device.orientation.isPortrait {
                orientation = .portrait
            }
            else if device.orientation.isLandscape {
                orientation = .landscape
            }
        }
    }
    
    deinit {
        if let observer = _observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
}
