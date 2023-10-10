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
    var body: some Scene {
        WindowGroup {
            let store = Store(initialState: RepoSearch.State()) { RepoSearch() }
            RepoSearchView(store: store)
        }
    }
}
