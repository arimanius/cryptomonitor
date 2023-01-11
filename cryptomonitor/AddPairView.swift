//
//  AddPairView.swift
//  cryptomonitor
//
//  Created by Ahmad on 10/21/1401 AP.
//

import SwiftUI

struct AddPairView: View {
    @State private var searchText = ""
    @EnvironmentObject private var settings: SettingsStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults, id: \.self) { pair in
                    Button(action: {
                        settings.pairList = settings.pairList + [pair]
                    }) {
                        Text("\(pair.currency_base) (\(pair.symbol))")
                    }
                }
            }
            .navigationTitle("Add a currency")
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "multiply.circle")
                }
            }
        }
        .searchable(text: $searchText, prompt: "Look for a currency")
    }

    var searchResults: [Pair] {
        let myPairs = pairs.filter {!settings.pairList.map {$0.symbol}.contains($0.symbol) }
        if searchText.isEmpty {
            return myPairs
        } else {
            return myPairs.filter { $0.currency_base.lowercased().contains(searchText.lowercased()) || String($0.symbol.split(separator: "/")[0]).lowercased().contains(searchText.lowercased()) }
        }
    }
}

struct AddPairView_Previews: PreviewProvider {
    static var previews: some View {
        AddPairView()
            .environmentObject(SettingsStore())
    }
}
