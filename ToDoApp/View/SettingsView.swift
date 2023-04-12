//
//  SettingsView.swift
//  ToDoApp
//
//  Created by Rafael Carvalho on 01/04/23.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var iconSetting: IconNames

    @ObservedObject var theme = ThemeSettings.shared
    let themes: [Theme] = themeData

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                Form {
                    // MARK: - Section 1

                    Section(header: Text("Choose the app icon")) {
                        Picker(selection: $iconSetting.currentIndex, label:
                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .strokeBorder(.primary, lineWidth: 2)

                                    Image(systemName: "paintbrush")
                                        .font(.system(size: 28, weight: .regular, design: .default))
                                        .foregroundColor(.primary)
                                }
                                .frame(width: 44, height: 44)
                                Text("App Icons".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                            } //: HStack
                        ) {
                            ForEach(0 ..< iconSetting.iconNames.count) { index in
                                HStack {
                                    Image(uiImage: UIImage(named: self.iconSetting.iconNames[index] ?? "Blue") ?? UIImage())
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 25, height: 25)
                                        .cornerRadius(5)

                                    Text(self.iconSetting.iconNames[index] ?? "Blue")
                                        .frame(alignment: .leading)
                                }
                            }
                        }
                        .pickerStyle(.inline)
                        .onReceive([self.iconSetting.currentIndex].publisher.first()) { value in
                            let index = self.iconSetting.iconNames.firstIndex(of: UIApplication.shared.alternateIconName) ?? 0
                            if index != value {
                                UIApplication.shared.setAlternateIconName(self.iconSetting.iconNames[value]) { error in
                                    if let error = error {
                                        print(error.localizedDescription)
                                    } else {
                                        print("Success!")
                                    }
                                }
                            }
                        }
                    }
                    .padding(.vertical, 3)

                    // MARK: - Section 2

                    Section(header:
                        HStack {
                            Text("Choose the app theme")
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundColor(themes[self.theme.themeSettings].themeColor)
                        }
                    ) {
                        List {
                            ForEach(themes, id: \.id) { theme in
                                Button(action: {
                                    self.theme.themeSettings = theme.id
                                    UserDefaults.standard.set(self.theme.themeSettings, forKey: "Theme")
                                }, label: {
                                    HStack {
                                        Image(systemName: "circle.fill")
                                            .foregroundColor(theme.themeColor)

                                        Text(theme.themeName)
                                    }
                                })
                                .foregroundColor(.primary)
                            }
                        }
                    } //: Section 2
                    .padding(.vertical, 3)

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
        .accentColor(themes[self.theme.themeSettings].themeColor)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(IconNames())
    }
}
