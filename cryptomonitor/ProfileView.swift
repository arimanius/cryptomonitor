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
            VStack{
                HStack {
                    HStack(alignment: .center, spacing: 10) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text(settings.username)
                            .font(Font.custom("", size: 24))
                    }
                    .padding([.top, .bottom], 2)
                    .padding(.leading, 25)
                    .cornerRadius(5)
                    Spacer(minLength: 20)
                }
                .padding(.top, 20)
                Spacer()
            }
            .navigationTitle("Personal Info")
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
