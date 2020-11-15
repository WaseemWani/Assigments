//
//  Favourites.swift
//  ContactsApp
//
//  Created by Waseem Wani on 09/10/20.
//  Copyright © 2020 Waseem Wani. All rights reserved.
//

import SwiftUI
import CoreData

struct AllContactsView: View {
    @State private var showSheet: Bool = false
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Contact.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Contact.firstName, ascending: true)]) var contacts: FetchedResults <Contact>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(contacts, id: \.self) { contact in
                    VStack(alignment: .leading) {
                        HStack() {
                            Text(contact.firstName ?? "Unknown value")
                            Text(contact.lastName ?? "Unknown value")
                        }
                        Text(String(contact.contactNumber ?? "Unknown value"))
                    }
                    .contextMenu {
                        Button("Mark favourite") {
                            contact.isFavourite = true
                            if self.moc.hasChanges {
                                try? self.moc.save()
                            }
                        }
                    }
                }
                .onDelete(perform: deleteContacts)
            }
            .navigationBarTitle("Contacts")
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: { self.showSheet.toggle() }) {
                    Image(systemName: "plus")
            })
                .sheet(isPresented: $showSheet) {
                    AddNewContact().environment(\.managedObjectContext, self.moc)
            }
        }
    }
    
    func deleteContacts(at offsets: IndexSet) {
        for offset in offsets {
            let contact = contacts[offset]
            moc.delete(contact)
        }
        try? moc.save()
    }
}

struct Favourites_Previews: PreviewProvider {
    static var previews: some View {
        AllContactsView()
    }
}
