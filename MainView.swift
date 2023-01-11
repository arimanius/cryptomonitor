//
//  MainView.swift
//  cryptomonitor
//
//  Created by Ahmad on 10/21/1401 AP.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            CurrenciesView()
                .tabItem {
                    Label("Currencies", systemImage: "bitcoinsign.circle")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
