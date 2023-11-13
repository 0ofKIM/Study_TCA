//
//  RecordMeetingView.swift
//  Study_TCA
//
//  Created by 0ofKim on 2023/11/13.
//

import ComposableArchitecture
import Speech
import SwiftUI

// 회의 녹화(Record Meeting) 앱의 일부 예제

struct RecordMeetingFeature: Reducer {
    struct State: Equatable {
        /* code */
        var durationRemaining: Duration {
            self.standup.duration - .seconds(self.secondsElapsed)
        }
    }
    enum Action: Equatable {
        case endMeetingButtonTapped
        case nextButtonTapped
        case timerTicked
    }
    /* code */
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .endMeetingButtonTapped:
                return .none

            case .nextButtonTapped:
                return .none

            case .onTask:
                return .run { send in
                    let status = await withUnsafeContinuation { continuation in
                        SFSpeechRecognizer.requestAuthorization { status in
                            continuation.resume(with: .success(status))
                        }
                    }
                    /* code */
                }

            case .timerTicked:
                state.secondsElapsed += 1
                return .none
            }
        }
    }
}

struct RecordMeetingView: View {
    let store: StoreOf<RecordMeetingFeature>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            /* code */
                .task { await viewStore.send(.onTask).finish() }
        }
    }
}
#Preview {
    RecordMeetingView()
}
