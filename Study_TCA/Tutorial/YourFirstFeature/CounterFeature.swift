//
//  CounterFeature.swift
//  Study_TCA
//
//  Created by 0ofKim on 2023/10/10.
//

import ComposableArchitecture

struct CounterFeature: Reducer {
    struct State: Equatable {
        var count: Int = 0
    }

    enum Action {
        case decrementButtonTapped
        case incrementButtonTapped
    }

    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.Effect<Action> {
        switch action {
        case .decrementButtonTapped:
            state.count -= 1
            return .none

        case .incrementButtonTapped:
            state.count += 1
            return .none
        }
    }
}
