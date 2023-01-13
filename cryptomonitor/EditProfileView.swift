//
//  EditProfileView.swift
//  cryptomonitor
//
//  Created by Pouya Esmaili on 1/13/23.
//

import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var settings: SettingsStore
    @State var username: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List {
                HStack(alignment: .center, spacing: 10) {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                    TextField("Username", text: $username)
                        .font(.title2)
                }
            }
            .navigationTitle("Edit Personal Info")
            .toolbar {
                Button {
                    settings.username = username
                    dismiss()
                } label: {
                    Text("Submit")
                }
            }
            .task {
                username = settings.username ?? ""
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
            .environmentObject(SettingsStore())
    }
}
