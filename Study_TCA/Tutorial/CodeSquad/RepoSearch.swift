//
//  RepoSearch.swift
//  Study_TCA
//
//  Created by 0ofKim on 2023/10/10.
//

//import SwiftUI
import ComposableArchitecture

struct RepoSearch: Reducer {
    private let sampleRepoLists = [
        "Swift",
        "SwiftyJSON",
        "SwiftGuide",
        "SwifterSwift"
    ]

    struct State: Equatable {
        var keyword: String = ""
        var searchResults: [String] = []
    }

    enum Action {
        case keywordChanged(String)
        case search
    }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .keywordChanged(keyword):
            state.keyword = keyword

        case .search:
            state.searchResults = sampleRepoLists.filter {
                $0.contains(state.keyword)
            }
        }

        return .none
    }
}
