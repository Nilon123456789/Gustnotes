//
//  Settings.swift
//  Quick notes
//
//  Created by Nils Lahaye on 2022-12-15.
//

import Foundation
import LaunchAtLogin

extension UserDefaults {
    enum Key {
        static let globalKey = "globalKey"
        static let autoStart = "autoStart"
        static let saveOnClose = "saveOnClose"
        static let floatingNote = "floatingNote"
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) { }
}

enum Settings {
    
    static var globalKey: GlobalKeybindPreferences? {
        get {
            guard let data = UserDefaults.standard.value(forKey: UserDefaults.Key.globalKey) as? Data else { return nil }
            return try? JSONDecoder().decode(GlobalKeybindPreferences.self, from: data)
        }
        
        set {
            guard let data = try? JSONEncoder().encode(newValue) else { print("Faild to save shortcut"); return }
            UserDefaults.standard.set(data, forKey: UserDefaults.Key.globalKey)
        }
    }
    
    static var autoStart: Bool {
        get {
            return UserDefaults.standard.bool(forKey: UserDefaults.Key.autoStart)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaults.Key.autoStart)
            
            LaunchAtLogin.isEnabled = newValue
        }
    }
    
    static var saveOnClose: Bool {
        get {
            UserDefaults.standard.bool(forKey: UserDefaults.Key.saveOnClose)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaults.Key.saveOnClose)
        }
    }
    
    static var floatingNote: Bool {
        get {
            UserDefaults.standard.bool(forKey: UserDefaults.Key.floatingNote)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaults.Key.floatingNote)
        }
    }
    
    
}
