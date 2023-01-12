//
//  OHLC.swift
//  cryptomonitor
//
//  Created by Ahmad on 10/22/1401 AP.
//

import Foundation

struct OHLC: Hashable, Codable {
    var datetime: Date
    var open: Float
    var high: Float
    var low: Float
    var close: Float
}
