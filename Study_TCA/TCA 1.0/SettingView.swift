//
//  SettingView.swift
//  Study_TCA
//
//  Created by 0ofKim on 2023/11/16.
//

import SwiftUI
import ComposableArchitecture

struct Settings: Reducer {
    struct State: Equatable { 
        @BindingState var isHapticFeedbackEnabled = true

        @BindingState var digest = Digest.daily
        @BindingState var displayName = ""
        @BindingState var enableNotifications = false
        var isLoading = false
        @BindingState var protectMyPosts = false
        @BindingState var sendEmailNotifications = false
        @BindingState var sendMobileNotifications = false
    }

    enum Action: BindingAction {
        case binding(BindingAction<State>)

        case isHapticFeedbackEnabledChanged(Bool)

        case digestChanged(Digest)
        case displayNameChanged(String)
        case enableNotificationsChanged(Bool)
        case protectMyPostsChanged(Bool)
        case sendEmailNotificationsChanged(Bool)
        case sendMobileNotificationsChanged(Bool)
    }

    /* binding(get:send:)를 사용할 때
    func reduce(
        into state: inout State, action: Action
    ) -> Effect<Action> {
        switch action {
        case let .isHapticFeedbackEnabledChanged(isEnabled):
            state.isHapticFeedbackEnabled = isEnabled
            return .none

        case let digestChanged(digest):
            state.digest = digest
            return .none

        case let displayNameChanged(displayName):
            state.displayName = displayName
            return .none

        case let enableNotificationsChanged(isOn):
            state.enableNotifications = isOn
            return .none

        case let protectMyPostsChanged(isOn):
            state.protectMyPosts = isOn
            return .none

        case let sendEmailNotificationsChanged(isOn):
            state.sendEmailNotifications = isOn
            return .none

        case let sendMobileNotificationsChanged(isOn):
            state.sendMobileNotifications = isOn
            return .none
        }
    }

     // BindingReducer를 사용할 때
    var body: some Reducer<State, Action> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .binding(\.$displayName):
                state.isLoading.toggle()
            case .binding(\.$enabledNotifications):
            case .binding(_): break
            }
        }
    }
     */
}

struct SettingView: View {
    let store: StoreOf<Settings>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Form {
                Toggle(
                    "Haptic feedback",
                    isOn: viewStore.binding(
                        get: \.isHapticFeedbackEnabled,
                        send: { .isHapticFeedbackEnabledChanged($0) }
                    )
                )

                /*
                 // binding(get:send:)를 사용할 때
                   Toggle(
                     "Haptic feedback",
                     isOn: viewStore.binding(
                       get: \.isHapticFeedbackEnabled,
                       send: { .isHapticFeedbackEnabledChanged($0) }
                     )
                   )


                 // BindingState 프로퍼티 래퍼를 사용할 때
                   Toggle(
                     "Haptic feedback",
                     isOn: viewStore.$isHapticFeedbackEnabled
                   )
                 */
            }
        }
    }
}

#Preview {
    let store = Store(initialState: Settings.State()) { Settings() }
    SettingView(store: store)
}
