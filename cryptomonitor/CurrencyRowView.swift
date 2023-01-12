//
//  CurrencyRowView.swift
//  cryptomonitor
//
//  Created by Ahmad on 10/22/1401 AP.
//

import SwiftUI

struct CurrencyRowView: View {
    @State private var ohlc: OHLC? = nil
    var pair: Pair

    var body: some View {
        NavigationLink {
            CurrencyView(pair: pair, currentOhlc: $ohlc)
        } label: {
            HStack {
                Text("\(pair.currency_base)")
                    .foregroundColor(Color.green)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("\(pair.symbol)")
                    .foregroundColor(Color.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("$\(ohlc?.close ?? "loading")")
                    .foregroundColor(Color.blue)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .task {
            ohlc = try? await Api().loadToday(pair: pair)
        }
    }
}

struct CurrencyRowView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyRowView(pair: Pair(symbol: "ADA/USD", currency_base: "Cardano"))
    }
}
