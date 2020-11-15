//
//  AddNewContact.swift
//  ContactsApp
//
//  Created by Waseem Wani on 09/10/20.
//  Copyright © 2020 Waseem Wani. All rights reserved.
//

import SwiftUI

struct AddNewContact: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var number = ""
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("First name", text: $firstName)
                    TextField("Last name", text: $lastName)
                    TextField("Contact number", text: $number)
                        .keyboardType(.phonePad)
                }
                Section {
                    Button("Save") {
                        if !self.firstName.isEmpty &&  !self.number.isEmpty  { //!self.lastName.isEmpty
                            let newContact = Contact(context: self.moc)
                            newContact.contactNumber = self.number
                            newContact.firstName = self.firstName
                            newContact.lastName = self.lastName
                            newContact.isFavourite = false
                            do {
                                try self.moc.save()
                            }
                            catch {
                                print(error.localizedDescription)
                            }
                            self.showAlert = false
                            self.presentationMode.wrappedValue.dismiss()
                        } else {
                            self.showAlert = true
                        }
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text("Please enter first name and number"), dismissButton: .default(Text("OK")))
            }
            .navigationBarTitle("Add contact")
        }
    }
}

struct AddNewContact_Previews: PreviewProvider {
    static var previews: some View {
        AddNewContact()
    }
}
