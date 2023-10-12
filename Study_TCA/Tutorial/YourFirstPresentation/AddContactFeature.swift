//
//  AddContactFeature.swift
//  Study_TCA
//
//  Created by Lotte on 2023/10/12.
//

import ComposableArchitecture

struct AddContactFeature: Reducer {
    struct State: Equatable {
        var contact: Contact
    }

    enum Action: Equatable {
        case cancelButtonTapped
        case saveButtonTapped
        case setName(String)
    }

    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .cancelButtonTapped:
            return .none

        case .saveButtonTapped:
            return .none

        case let .setName(name):
            state.contact.name = name
            return .none
        }
    }
}
