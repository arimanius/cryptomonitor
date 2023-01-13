//
//  CurrencyView.swift
//  cryptomonitor
//
//  Created by Ahmad on 10/22/1401 AP.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}

struct CurrencyView: View {
    var pair: Pair
    @Binding var currentOhlc: OHLC?
    @State var from: Date = Date().addingTimeInterval(-10*24*60*60)
    @State var until: Date = Date()
    @State var error: Swift.Error? = nil
    @State var ohlcs: [OHLC] = []
    let dateformatter = DateFormatter()
    var body: some View {
        NavigationView {
            VStack {
                Text("$\(currentOhlc?.close ?? "loading")")
                    .font(.largeTitle)
                    .fontWeight(.light)
                    .foregroundColor(Color.blue)
                HStack {
                    DatePicker(
                        selection: $from.onChange(loadOhlcs),
                        in: ...until,
                        displayedComponents: [.date],
                        label: { Text("From") }
                    )
                    Spacer()
                        .frame(width: 25.0)
                    DatePicker(
                        selection: $until.onChange(loadOhlcs),
                        in: from...Date.now,
                        displayedComponents: [.date],
                        label: { Text("Until") }
                    )
                }
                .padding(.horizontal, 20.0)
                List {
                    ForEach(ohlcs, id: \.self) { ohlc in
                        HStack {
                            Text("$\(ohlc.close)")
                                .foregroundColor(Color.blue)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(dateformatter.string(from: ohlc.datetime))
                                .foregroundColor(Color.gray)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                
                        }
                    }
                }
            }
            .navigationTitle("\(pair.currency_base) (\(pair.symbol))")
        }
        .task {
            dateformatter.dateFormat = "MMMM d, yyyy"
            ohlcs = (try? await Api().loadRange(pair: pair, from: from, until: until)) ?? []
        }
    }
    
    func loadOhlcs(_: Date) {
        Task {
            ohlcs = (try? await Api().loadRange(pair: pair, from: from, until: until)) ?? []
        }
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView(pair: Pair(symbol: "BTC/USD", currency_base: "Bitcoin"), currentOhlc: .constant(OHLC(datetime: Date(), open: "1", high: "2", low: "3", close: "4")))
    }
}
