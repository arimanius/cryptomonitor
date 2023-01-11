//
//  AddPairView.swift
//  cryptomonitor
//
//  Created by Ahmad on 10/21/1401 AP.
//

import SwiftUI

struct AddPairView: View {
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults, id: \.self) { pair in
                    NavigationLink {
                        Text(pair.currency_base)
                    } label: {
                        Text(pair.currency_base)
                    }
                }
            }
            .navigationTitle("Add a currency")
        }
        .searchable(text: $searchText, prompt: "Look for a currency")
    }
            
    var searchResults: [Pair] {
        if searchText.isEmpty {
            return pairs
        } else {
            return pairs.filter { $0.currency_base.contains(searchText) }
        }
    }
}

struct AddPairView_Previews: PreviewProvider {
    static var previews: some View {
        AddPairView()
    }
}
