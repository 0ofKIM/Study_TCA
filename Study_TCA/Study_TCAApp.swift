//
//  Study_TCAApp.swift
//  Study_TCA
//
//  Created by 0ofKim on 2023/10/10.
//

import SwiftUI
import ComposableArchitecture

@main
struct Study_TCAApp: App {
    static let store1 = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }

    static let store2 = Store(initialState: ContactsFeature.State()) {
        ContactsFeature()
            ._printChanges()
    }

    var body: some Scene {
        WindowGroup {
            //코드 스쿼드
//            let store = Store(initialState: RepoSearch.State()) { RepoSearch() }
//            RepoSearchView(store: store)

            //Tutorial 1. Your First Feature
//            CounterView(store: Study_TCAApp.store1)

            //Tutorial 2. Your first presentation
            ContactsView(store: Study_TCAApp.store2)
        }
    }
}
