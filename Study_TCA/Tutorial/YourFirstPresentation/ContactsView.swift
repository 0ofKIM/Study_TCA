//
//  ContactsView.swift
//  Study_TCA
//
//  Created by Lotte on 2023/10/12.
//

import SwiftUI
import ComposableArchitecture

struct ContactsView: View {
    let store: StoreOf<ContactsFeature>

    var body: some View {
        NavigationStack {
            WithViewStore(self.store, observe: \.contacts) { viewStore in
                List {
                    ForEach(viewStore.state) { contact in
                        Text(contact.name)
                    }
                }
                .navigationTitle("Contacts")
                .toolbar {
                    ToolbarItem {
                        Button {
                            viewStore.send(.addButtonTapped)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
    }
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView(
            store: Store(
                initialState: ContactsFeature.State(
                    contacts: [
                        Contact(id: UUID(), name: "Blob"),
                        Contact(id: UUID(), name: "Blob Jr"),
                        Contact(id: UUID(), name: "Blob Sr"),
                    ]
                )
            ) {
                ContactsFeature()
            }
        )
    }
}
