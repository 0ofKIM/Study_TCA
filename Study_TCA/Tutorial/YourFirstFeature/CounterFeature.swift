//
//  CounterFeature.swift
//  Study_TCA
//
//  Created by 0ofKim on 2023/10/10.
//

import Foundation
import ComposableArchitecture

struct CounterFeature: Reducer {
    struct State: Equatable {
        var count: Int = 0
        var fact: String?
        var isLoading: Bool = false
    }

    enum Action {
        case decrementButtonTapped
        case factButtonTapped
        case incrementButtonTapped
    }

    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.Effect<Action> {
        switch action {
        case .decrementButtonTapped:
            state.count -= 1
            state.fact = nil
            return .none

        case .factButtonTapped:
            state.fact = nil
            state.isLoading = true

            let (data, _) = try await URLSession.shared
                .data(from: URL(string: "http://numbersapi.com/\(state.count)")!)
            // 🛑 'async' call in a function that does not support concurrency
            // 🛑 Errors thrown from here are not handled

            state.fact = String(decoding: data, as: UTF8.self)
            state.isLoading = false

            return .none

        case .incrementButtonTapped:
            state.count += 1
            state.fact = nil
            return .none
        }
    }
}
