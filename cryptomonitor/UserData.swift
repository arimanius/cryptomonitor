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
            if let data = UserDefaults.standard.value(forKey: "pairList") as? Data {
                return (try? PropertyListDecoder().decode([Pair].self, from: data))!
            }
            return []
        }
        set {
            set(try? PropertyListEncoder().encode(newValue), forKey: "pairList")
        }
    }
    
    var username: String {
        get {
            if let data = UserDefaults.standard.value(forKey: "username") as? String {
                return data
            }
            return ""
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
    @Published var username: String = UserDefaults.standard.username {
        didSet {
            UserDefaults.standard.username = self.username
        }
    }
}
