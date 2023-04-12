//
//  AddToDoView.swift
//  ToDoApp
//
//  Created by Rafael Carvalho on 31/03/23.
//

import SwiftUI

struct AddToDoView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var managedObjectContext

    @State private var name: String = ""
    @State private var priority: String = "Normal"
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""

    @ObservedObject var theme = ThemeSettings.shared
    
    let priorities = ["High", "Normal", "Low"]
    var themes: [Theme] = themeData

    var body: some View {
        NavigationView {
            VStack {
                VStack (alignment: .leading, spacing: 20) {
                    // MARK: - To Do Name

                    TextField("To Do", text: $name)
                        .padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(9)
                        .font(.system(size: 24, weight: .bold, design: .default))

                    // MARK: - To Do Priority

                    Picker("Priority", selection: $priority, content: {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    })
                    .pickerStyle(.segmented)

                    // MARK: - To Do Save Button

                    Button(action: {
                        if !self.name.isEmpty {
                            let todo = ToDo(context: self.managedObjectContext)
                            todo.name = self.name
                            todo.priority = self.priority

                            do {
                                try self.managedObjectContext.save()
                                self.name = ""
                            } catch {
                                print(error)
                            }
                        } else {
                            self.errorShowing = true
                            self.errorTitle = "Invalid Name"
                            self.errorMessage = "Make sure to enter something for\nthe new todo item."
                            return
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text("Save")
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(themes[self.theme.themeSettings].themeColor)
                            .cornerRadius(9)
                            .foregroundColor(.white)
                    })
                }
                .padding(.horizontal)
                .padding(.vertical, 30)

                Spacer()
            } //: VStack
            .navigationTitle("New To Do")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                })
            )
            .alert(isPresented: $errorShowing) {
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        } //: NavigationView
        .accentColor(themes[self.theme.themeSettings].themeColor)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoView()
    }
}
