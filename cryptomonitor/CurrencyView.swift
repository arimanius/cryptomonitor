//
//  CurrencyView.swift
//  cryptomonitor
//
//  Created by Ahmad on 10/22/1401 AP.
//

import SwiftUI

struct CurrencyView: View {
    var pair: Pair

    var body: some View {
        Text("\(pair.currency_base) (\(pair.symbol))")
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView(pair: Pair(symbol: "BTC/USD", currency_base: "Bitcoin"))
    }
}
