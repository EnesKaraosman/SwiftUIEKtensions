//
//  View+Keyboard.swift
//  
//
//  Created by Vidal Hara on 6.11.2023.
//

import Combine
import SwiftUI

public extension View {

    /// iOS only modifier to take action when keyboard appear and disappear
    func onKeyboardAppear(_ action: @escaping (CGFloat) -> ()) -> some View {
        #if os(iOS)
        modifier(KeyboardAppear(action: action))
        #else
        self
        #endif
    }

    /// iOS only modifier to take action when keyboard did show and did hide
    func onKeyboardDidAppear(_ action: @escaping (Bool) -> ()) -> some View {
        #if os(iOS)
        modifier(KeyboardDidAppear(action: action))
        #else
        self
        #endif
    }
}

public extension View {
    @ViewBuilder
    func onKeyboardChanged(
        keyboardFocusedId: Binding<String>,
        scrollTo id: String,
        applyId: Bool = true,
        scrollProxy: ScrollViewProxy,
        additionalBottomInset: CGFloat = 8
    ) -> some View {
        #if os(iOS)
        let newView = modifier(
            BottomSpacerForKeyboard(
                keyboardFocusedId: keyboardFocusedId,
                scrollTo: id,
                scrollProxy: scrollProxy,
                additionalBottomInset: additionalBottomInset
            )
        )
        if applyId {
            newView.id(id)
        } else {
            newView
        }
        #endif
    }

    @ViewBuilder
    func simultaneousTapGesture(_ action: @escaping () -> Void) -> some View {
        self.simultaneousGesture(
            TapGesture().onEnded({
                action()
            })
        )
    }
}

#if os(iOS)
// MARK: - ScrollToItemForKeyboardChange

fileprivate struct BottomSpacerForKeyboard: ViewModifier {

    private var isKeyboardForMe: Bool {
        keyboardFocusedId == scrollToId
    }

    @Binding
    private var keyboardFocusedId: String

    private let scrollToId: String
    private let scrollProxy: ScrollViewProxy
    private let additionalBottomInset: CGFloat

    init(keyboardFocusedId: Binding<String>, scrollTo id: String, scrollProxy: ScrollViewProxy, additionalBottomInset: CGFloat) {
        _keyboardFocusedId = keyboardFocusedId
        self.scrollToId = id
        self.scrollProxy = scrollProxy
        self.additionalBottomInset = additionalBottomInset
    }

    func body(content: Content) -> some View {
        content.simultaneousTapGesture {
            keyboardFocusedId = scrollToId
        }
        .onKeyboardDidAppear({ isVisible in
            guard isKeyboardForMe else { return }
            if isVisible == false {
                keyboardFocusedId = ""
            }
            scrollProxy.asyncScrollTo(
                scrollToId, position: isVisible ? .bottom : .center
            )
        })
        .padding(.bottom, isKeyboardForMe ? additionalBottomInset : 0)
    }
}

// MARK: - KeyboardAppear

fileprivate struct KeyboardAppear: ViewModifier {

    let action: (CGFloat) -> ()

    private var heightPublisher: AnyPublisher<CGFloat, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue }
                .map { $0.cgRectValue.height },
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in CGFloat(0) }
        )
        .eraseToAnyPublisher()
    }

    func body(content: Content) -> some View {
        content
            .onReceive(heightPublisher) {
                action($0)
            }
    }
}

// MARK: - KeyboardDidAppear

fileprivate struct KeyboardDidAppear: ViewModifier {

    let action: (Bool) -> Void

    private var visiblePublisher: AnyPublisher<Bool, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardDidShowNotification)
                .map { _ in true },
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardDidHideNotification)
                .map { _ in false }
        )
        .eraseToAnyPublisher()
    }

    func body(content: Content) -> some View {
        content
            .onReceive(visiblePublisher) {
                action($0)
            }
    }
}
#endif
