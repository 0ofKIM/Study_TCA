//
//  CounterView1_0.swift
//  Study_TCA
//
//  Created by 0ofKim on 2023/11/12.
//

import SwiftUI
import ComposableArchitecture

struct CounterFeature1_0: Reducer {
    struct State: Equatable {
        var count = 0
    }
    
    enum Action: Equatable {
        case decrementButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .decrementButtonTapped:
                state.count -= 1
                return .none
            }
        }
    }
    
    //    위 body 클로저나 아래 reduce 함수 둘 중 한 가지 방법으로 구현.
    //    func reduce(into state: inout State, action: Action) -> Effect<Action> {
    //        switch action {
    //        case .decrementButtonTapped:
    //            state.count -= 1
    //            return .none
    //        }
    //    }
}

struct CounterView1_0: View {
    // let store: Store<CounterFeature.State, CounterFeature.Action>의 축약형
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Form {
                Section {
                    Button("Decrement") {
                        /* code */
                    }
                    Button("Increment") {
                        /* code */
                    }
                }
            }
        }
    }
}

struct CounterView1_0_Previews: PreviewProvider {
    static var previews: some View {
        CounterView1_0()
    }
}
