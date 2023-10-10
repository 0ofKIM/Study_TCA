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
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges()
    }

    var body: some Scene {
        WindowGroup {
            //코드 스쿼드
//            let store = Store(initialState: RepoSearch.State()) { RepoSearch() }
//            RepoSearchView(store: store)

            //Tutorial 1. Your First Feature
            CounterView(store: Study_TCAApp.store)
        }
    }
}
