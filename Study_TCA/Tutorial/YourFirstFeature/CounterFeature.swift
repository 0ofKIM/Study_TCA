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
        var isTimerRunning: Bool = false
    }

    enum Action {
        case decrementButtonTapped
        case factButtonTapped
        case factResponse(String)
        case incrementButtonTapped
        case timerTick
        case toggleTimerButtonTapped
    }

    enum CancelID { case timer }

    func reduce(into state: inout State, action: Action) -> ComposableArchitecture.Effect<Action> {
        switch action {
        case .decrementButtonTapped:
            state.count -= 1
            state.fact = nil
            return .none

        case .factButtonTapped:
            state.fact = nil
            state.isLoading = true

            return .run { [count = state.count] send in
                let (data, _) = try await URLSession.shared
                    .data(from: URL(string: "http://numbersapi.com/\(count)")!)
                let fact = String(decoding: data, as: UTF8.self)
                await send(.factResponse(fact))
            }

        case let .factResponse(fact):
            state.fact = fact
            state.isLoading = false
            return .none

        case .incrementButtonTapped:
            state.count += 1
            state.fact = nil
            return .none

        case .timerTick:
            state.count += 1
            state.fact = nil
            return .none

        case .toggleTimerButtonTapped:
            state.isTimerRunning.toggle()
            if state.isTimerRunning {
                return .run { send in
                    while true {
                        try await Task.sleep(for: .seconds(1))
                        await send(.timerTick)
                    }
                }
                .cancellable(id: CancelID.timer)
            } else {
                return .cancel(id: CancelID.timer)
            }
        }
    }
}
