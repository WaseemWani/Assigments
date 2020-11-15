//
//  ContentView.swift
//  ContactsApp
//
//  Created by Waseem Wani on 09/10/20.
//  Copyright © 2020 Waseem Wani. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            AllContactsView()
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Contacts")
            }
            
            FavouriteContactsView()
                .tabItem {
                    Image(systemName: "star")
                    Text("Favourites")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
