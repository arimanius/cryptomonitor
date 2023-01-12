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

    func loadToday(pairs: [Pair]) async throws -> [String: OHLC] {
        let symbols = pairs.map { $0.symbol }.joined(separator: ",")
        guard let url = URL(string: "\(Api.endpoint)?\(Api.defaultParams)&symbol=\(symbols)&date=today&apikey=\(config.apiKey)") else {
            fatalError("Wrong url")
        }
        
        guard let (data, response) = try? await URLSession.shared.data(from: url) else{
            fatalError("Request Error: \(url)")
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            fatalError("Status: \((response as? HTTPURLResponse)!.statusCode)")
        }
        
        let result: [String: TimeSeriesResponse] = try parse(data: data)
        return Dictionary(uniqueKeysWithValues: result.map { ($0, $1.values.first!) })
    }
}
