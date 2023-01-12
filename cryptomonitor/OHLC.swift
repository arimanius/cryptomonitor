//
//  OHLC.swift
//  cryptomonitor
//
//  Created by Ahmad on 10/22/1401 AP.
//

import Foundation

struct OHLC: Hashable, Codable {
    var datetime: Date
    var open: String
    var high: String
    var low: String
    var close: String
}
