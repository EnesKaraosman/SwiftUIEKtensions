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
struct KeyValueStorage<T: Codable> {
    
    let key: String
    let defaultValue: T
    let store: UserDefaults
    
    init(wrappedValue: T, _ key: String, store: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = wrappedValue
        self.store = store
    }
    
    var wrappedValue: T {
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
