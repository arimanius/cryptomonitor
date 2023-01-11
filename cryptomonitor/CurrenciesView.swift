//
//  CurrenciesView.swift
//  cryptomonitor
//
//  Created by Ahmad on 10/21/1401 AP.
//

import SwiftUI

struct CurrenciesView: View {
    @State private var showingSheet = false
    @ObservedObject var settings = SettingsStore()

    var body: some View {
        NavigationView {
            List {
                ForEach($settings.pairList, id: \.self) { pair in
                    NavigationLink {
                        Text("\(pair.currency_base.wrappedValue) (\(pair.symbol.wrappedValue))")
                    } label: {
                        Text("\(pair.currency_base.wrappedValue) (\(pair.symbol.wrappedValue)) <price>")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .disabled($settings.pairList.isEmpty)
            .navigationTitle("Currencies")
            .toolbar {
                Button {
                    showingSheet.toggle()
                } label: {
                    Image(systemName: "plus.circle")
                }
                .id(UUID())
            }
            .fullScreenCover(isPresented: $showingSheet) {
                AddPairView()
            }
            .environmentObject(settings)
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        settings.pairList.remove(atOffsets: offsets)
    }
}

struct CurrenciesView_Previews: PreviewProvider {
    static var previews: some View {
        CurrenciesView()
    }
}
