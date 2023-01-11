//
//  CurrenciesView.swift
//  cryptomonitor
//
//  Created by Ahmad on 10/21/1401 AP.
//

import SwiftUI

struct CurrenciesView: View {
    @State private var myPairs = userData.pairList
    
    var body: some View {
        NavigationView {
            List {
                ForEach(myPairs, id: \.self) { pair in
                    NavigationLink {
                        Text("\(pair.currency_base) (\(pair.symbol))")
                    } label: {
                        Text("\(pair.currency_base) (\(pair.symbol)) <price>")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .disabled(myPairs.isEmpty)
            .navigationTitle("Currencies")
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        userData.removePair(at: offsets)
        myPairs.remove(atOffsets: offsets)
    }
}

struct CurrenciesView_Previews: PreviewProvider {
    static var previews: some View {
        CurrenciesView()
    }
}
