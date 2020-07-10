//
//  SelectableItem.swift
//  
//
//  Created by Enes Karaosman on 10.07.2020.
//

import Foundation

public protocol SelectableItem: Identifiable {
    var isSelected: Bool { get set }
}
