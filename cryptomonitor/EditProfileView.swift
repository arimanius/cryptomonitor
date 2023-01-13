//
//  EditProfileView.swift
//  cryptomonitor
//
//  Created by Pouya Esmaili on 1/13/23.
//

import SwiftUI

struct EditProfileView: View {
    @ObservedObject var settings = SettingsStore()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack{
                HStack {
                    Spacer(minLength: 20)
                    HStack(alignment: .center, spacing: 10) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                        TextField("Username", text: $settings.username)
                            .font(Font.custom("", size: 24))
                    }
                    .padding([.top, .bottom], 2)
                    .padding(.leading, 5)
                    .cornerRadius(5)
                    Spacer(minLength: 20)
                }
                .padding(.top, 20)
                Spacer()
            }
            .navigationTitle("Edit Personal Info")
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "multiply.circle")
                }
            }
            .environmentObject(settings)
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
