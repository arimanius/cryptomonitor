//
//  Api.swift
//  cryptomonitor
//
//  Created by Ahmad on 10/22/1401 AP.
//

import Foundation

struct TimeSeriesResponse: Codable {
    var values: [OHLC]
}

class Api {
    static private let endpoint = "https://api.twelvedata.com/time_series"
    static private let defaultParams = "interval=1day"

    func loadToday(pair: Pair) async throws -> OHLC {
        guard let url = URL(string: "\(Api.endpoint)?\(Api.defaultParams)&symbol=\(pair.symbol)&date=today&apikey=\(config.apiKey)") else {
            fatalError("Wrong url")
        }
        
        guard let (data, response) = try? await URLSession.shared.data(from: url) else{
            fatalError("Request Error: \(url)")
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            fatalError("Status: \((response as? HTTPURLResponse)!.statusCode)")
        }
        
        let result: TimeSeriesResponse = try parse(data: data)
        return result.values.first!
    }
}
