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
    @StateObject var vm = OHLCViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.data, id: \.self) { data in
                    NavigationLink {
                        CurrencyView(pair: data.pair)
                    } label: {
                        Text("\(data.pair.currency_base) (\(data.pair.symbol)): ")
                    }
                    .onAppear() {
                        
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .task {
                await vm.getOHLCs(pairs: settings.pairList)
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

struct PairOHLC: Hashable, Codable {
    var pair: Pair
    var ohcl: OHLC
}

class OHLCViewModel: ObservableObject {
    @Published var data: [PairOHLC] = []
    
    func getOHLCs(pairs: [Pair]) async {
        guard let data = try? await Api().loadToday(pairs: pairs) else {
            self.data = []
            return
        }
        self.data = pairs.map { pair in
            PairOHLC(pair: pair, ohcl: data[pair.symbol]!)
        }
    }
}
