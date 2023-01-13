//
//  UserData.swift
//  cryptomonitor
//
//  Created by Ahmad on 10/21/1401 AP.
//

import Foundation

extension UserDefaults {
    var pairList: [Pair] {
        get {
            if let data = value(forKey: "pairList") as? Data {
                return (try? PropertyListDecoder().decode([Pair].self, from: data))!
            }
            return []
        }
        set {
            set(try? PropertyListEncoder().encode(newValue), forKey: "pairList")
        }
    }
    
    var username: String? {
        get {
            return string(forKey: "username")
        }
        set {
            set(newValue, forKey: "username")
        }
    }
}

class SettingsStore: ObservableObject{
    @Published var pairList: [Pair] = UserDefaults.standard.pairList {
        didSet {
            UserDefaults.standard.pairList = self.pairList
        }
    }
    @Published var username: String? = UserDefaults.standard.username {
        didSet {
            UserDefaults.standard.username = (self.username?.isEmpty ?? false) ? self.username : nil
        }
    }
}
