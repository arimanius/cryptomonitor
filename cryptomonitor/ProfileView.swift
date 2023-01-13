//
//  ProfileView.swift
//  cryptomonitor
//
//  Created by Ahmad on 10/21/1401 AP.
//

import SwiftUI

struct ProfileView: View {
    @State private var showingSheet = false
    @ObservedObject var settings = SettingsStore()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Personal Info")) {
                    HStack(spacing: 20) {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text(settings.username ?? "Not set")
                            .font(.title2)
                            .foregroundColor(settings.username != nil ? .primary : .gray)
                    }
                }
            }
            .navigationTitle("Profile")
            .toolbar {
                Button {
                    showingSheet.toggle()
                } label: {
                    Text("Edit")
                }
            }
            .sheet(isPresented: $showingSheet) {
                EditProfileView()
            }
            .environmentObject(settings)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
