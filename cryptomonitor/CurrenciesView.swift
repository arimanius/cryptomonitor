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
                ForEach(settings.pairList, id: \.self) { pair in
                    CurrencyRowView(pair: pair)
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
            }
            .sheet(isPresented: $showingSheet) {
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
        Group {
            CurrenciesView();
            CurrenciesView()
                .preferredColorScheme(.dark)
        }
    }
}
