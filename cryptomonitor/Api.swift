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
        return try await getTimeSeries(pair: pair, otherParams: "date=today").first!
    }
    
    func loadRange(pair: Pair, from: Date, until: Date) async throws -> [OHLC] {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        
        return try await getTimeSeries(pair: pair, otherParams: "start_date=\(dateformatter.string(from: from))&end_date=\(dateformatter.string(from: until.addingTimeInterval(60*60*24)))")
    }
    
    private func getTimeSeries(pair: Pair, otherParams: String) async throws -> [OHLC] {
        guard let url = URL(string: "\(Api.endpoint)?\(Api.defaultParams)&symbol=\(pair.symbol)&\(otherParams)&apikey=\(config.apiKey)&timezone=\(TimeZone.current.identifier)") else {
            fatalError("Wrong url")
        }
        
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            fatalError("Request Error: \(url)")
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            fatalError("Status: \((response as? HTTPURLResponse)!.statusCode)")
        }
        
        let result: TimeSeriesResponse = try parse(data: data)
        return result.values
    }
}
