//
//  Favourite.swift
//  ContactsApp
//
//  Created by Waseem Wani on 09/10/20.
//  Copyright © 2020 Waseem Wani. All rights reserved.
//

import SwiftUI
import CoreData

struct FavouriteContactsView: View {
    
    @FetchRequest(entity: Contact.entity(), sortDescriptors: [], predicate: NSPredicate(format: "isFavourite == true")) var contacts: FetchedResults<Contact>
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(contacts, id: \.self) { contact in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(contact.firstName ?? "Unknown value")
                            Text(contact.lastName ?? "Unknown value")
                        }
                        Text(contact.contactNumber ?? "Unknown value")
                    }
                }
                .navigationBarTitle("Favourites")
            }
        }
    }
}
