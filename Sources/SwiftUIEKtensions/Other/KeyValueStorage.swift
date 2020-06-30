//
//  KeyValueStorage.swift
//  
//
//  Created by Enes Karaosman on 30.06.2020.
//

import Foundation

/*
 Usage:
 
 struct AppData {
     @KeyValueStorage("user_name", defaultValue: "")
     static var userName: String
 }
 
 AppData.userName // ""
 AppData.userName = "Enes"
 AppData.userName // "Enes"

 **/

@propertyWrapper
public struct KeyValueStorage<T: Codable> {
    
    private let key: String
    private let defaultValue: T
    private let store: UserDefaults
    
    public init(wrappedValue: T, _ key: String, store: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = wrappedValue
        self.store = store
    }
    
    public var wrappedValue: T {
        get {
            guard let data = store.object(forKey: key) as? Data else {
                return defaultValue
            }
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            store.set(data, forKey: key)
            store.synchronize()
        }
    }
    
}
