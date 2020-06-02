//
//  Bundle+Extension.swift
//  
//
//  Created by Enes Karaosman on 2.06.2020.
//

import Foundation

public extension Bundle {
    
    func decode<T: Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate file \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        guard let loaded = try? JSONDecoder().decode(T.self, from: data) else {
            fatalError("Failed to decode file \(file) from bundle.")
        }
        
        return loaded
    }
    
}
