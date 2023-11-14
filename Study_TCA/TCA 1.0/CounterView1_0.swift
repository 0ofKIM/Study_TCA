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
        // fact 기능 추가를 위해 새롭게 추가한 State
        var fact: String?
        var isLoadingFact = false
    }
    
    enum Action: Equatable {
        case incrementButtonTapped
        case decrementButtonTapped
        // fact 기능 추가를 위해 새롭게 추가한 Action
        case factResponse(String)
        case getFactButtonTapped

        case toggleTimerButtonTapped
        case timerTicked
    }

    private enum CancelID {
        case timer
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .getFactButtonTapped:
                state.fact = nil
                state.isLoadingFact = true
                // .run 메서드가 사용된 부분
                // [count = state.count] 구문은 클로저 내부에서 state.count를 count로 사용하겠다는 의미입니다.
                return .run { [count = state.count] send in
                    let (data, _) = try await URLSession.shared.data(
                        from: URL(string: "url 주소가 들어갈 장소/\(count)")!
                    )
                    let fact = String(decoding: data, as: UTF8.self)
                    await send(.factResponse(fact))
                }

            case let .factResponse(fact):
                state.fact = fact
                state.isLoadingFact = false
                return .none

            case .toggleTimerButtonTapped:
                state.isTimerOn.toggle()
                if state.isTimerOn {
                    return .run { send in
                        while true {
                            try await Task.sleep(for: .seconds(1))
                            await send(.timerTicked)
                        }
                    }
                    .cancellable(id: CancelID.timer)
                    // Start the timer
                } else {
                    // Stop the timer
                    return .cancel(id: CancelID.timer)
                }

            case .timerTicked:
                state.count += 1
                return .none

            case .incrementButtonTapped:
                state.count += 1
                return .none

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
        // withViewStore가 감싸고 있는 View가 복잡하면 복잡할수록 컴파일러의 성능이 저하될 수 있음
        // 이를 방지하기 위한 두 가지 방법
        // 1. 타입을 명시해서 컴파일러의 연산을 줄여준다. 
        // => ~~ { viewStore: ViewStoreOf<CounterFeature> in
        // 2. 이니셜라이저를 통해 Store를 주입받고, 그 안에서 ViewStore를 생성한다.
        // View 계층을 줄여준다는 장점이 있음
        // =>
        //let store: StoreOf<CounterFeature>
        //@ObservedObject var viewStore: ViewStoreOf<CounterFeature>
        //
        //init(store: StoreOf<CounterFeature>) {
        //    self.store = store
        //    self.viewStore = ViewStore(self.store, observe: { $0 })
        //}
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Form {
                Section {
                    Button("Decrement") {
                        viewStore.send(.decrementButtonTapped)
                    }
                    Button("Increment") {
                        viewStore.send(.incrementButtonTapped)
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
