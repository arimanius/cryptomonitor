//
//  UserData.swift
//  cryptomonitor
//
//  Created by Ahmad on 10/21/1401 AP.
//

import Foundation

struct UserData {
    private static func getValue(key: String) -> String {
        return UserDefaults.standard.string(forKey: key) ?? ""
    }
    
    private static func setValue(key: String, value: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    public var pairList: [Pair] {
        get {
            let value = UserData.getValue(key: "userPairList")
            let data = Data(value.utf8)
            let decoder = JSONDecoder()
            do {
                return try decoder.decode([Pair].self, from: data)
            } catch {
                return []
            }
        }
        set {
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(newValue)
                let value = String(decoding: data, as: UTF8.self)
                UserData.setValue(key: "userPairList", value: value)
            } catch {
                fatalError("Cannot encode data")
            }
        }
    }
    
    public mutating func addPair(pair: Pair) {
        let currentPairList = self.pairList
        if (!currentPairList.map {$0.symbol}.contains(pair.symbol)) {
            self.pairList = currentPairList + [pair]
        }
    }
}

var userData = UserData()

