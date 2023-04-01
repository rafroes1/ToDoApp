//
//  SettingsView.swift
//  ToDoApp
//
//  Created by Rafael Carvalho on 01/04/23.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Form {
                    // MARK: - Section 3

                    Section(header: Text("Follow us in social media"), content: {
                        FormRowLinkView(icon: "globe", color: .pink, text: "Website", link: "https://www.github.com/rafroes1")
                        FormRowLinkView(icon: "link", color: .blue, text: "Twitter", link: "https://www.twitter.com/raafaelfroes")
                        FormRowLinkView(icon: "play.rectangle", color: .purple, text: "Instagram", link: "https://www.instagram.com/rafafrs")
                    })
                    .padding(.vertical, 1)

                    // MARK: - Section 4

                    Section(header: Text("About the application"), content: {
                        FormRowStaticView(icon: "gear", firstText: "Application", secondText: "To Do")
                        FormRowStaticView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone, iPad")
                        FormRowStaticView(icon: "keyboard", firstText: "Developer", secondText: "Rafael Carvalho")
                        FormRowStaticView(icon: "paintbrush", firstText: "Designer", secondText: "Robert Petras")
                        FormRowStaticView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                    })
                    .padding(.vertical, 1)
                } //: Form
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular)

                // MARK: - Footer

                Text("Copyright © All rights reserved.\nBetter Apps ♡ Less Code.")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(.secondary)
            } //: VStack
            .navigationBarItems(trailing:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                })
            )
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color("ColorBackground").edgesIgnoringSafeArea(.all))
        } //: NavigationView
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
