//
//  View+Extension.swift
//  
//
//  Created by Enes Karaosman on 2.06.2020.
//

import SwiftUI

public extension View {
    
    @inlinable
    func then(_ body: (inout Self) -> Void) -> Self {
        var result = self
        body(&result)
        return result
    }
    
    /// Wraps view inside `AnyView`
    func embedInAnyView() -> AnyView {
        AnyView( self )
    }
    
    /// Wraps view inside `AnyView`
    func eraseToAnyView() -> AnyView { embedInAnyView() }
    
    /// Wraps view inside `NavigationView`
    func embedInNavigation() -> some View {
        NavigationView { self }
    }
    
    /// Apply 1 of the modifiers based on condition.
    @ViewBuilder func apply1of2ModifierOnCondition<M1: ViewModifier, M2: ViewModifier>
        (on condition: Bool, trueCase: M1, falseCase: M2) -> some View {
        if condition {
            modifier(trueCase)
        } else {
            modifier(falseCase)
        }
    }
    
    /// Apply modifier if condition matches, otherwise do nothing.
    @ViewBuilder func applyModifierOnCondition<M: ViewModifier>
        (on condition: Bool, trueCase: M) -> some View {
        if condition {
            modifier(trueCase)
        }
    }
    
    /// Apply modifier if condition is true, otherwise returns itself.
    @ViewBuilder func applyModifierOnConditionOrReturnSelf<M: ViewModifier>
        (on condition: Bool, trueCase: M) -> some View {
        if condition {
            modifier(trueCase)
        } else {
            self
        }
    }
    
    @inlinable
    @ViewBuilder func hidden(_ isHidden: Bool) -> some View {
        if isHidden {
            hidden()
        } else {
            self
        }
    }

    @ViewBuilder
    func modifier<Content: View>(for platform: Platform, _ modifier: (Self) -> Content) -> some View {
        switch platform {
        case .iOS:
            self.iOSOnlyModifier(modifier)
        case .macOS:
            self.macOSOnlyModifier(modifier)
        case .tvOS:
            self.tvOSOnlyModifier(modifier)
        case .watchOS:
            self.watchOSOnlyModifier(modifier)
        }
    }

    /// Performed if device has iOS.
    func iOSOnlyModifier<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(iOS)
        return modifier(self)
        #else
        return self
        #endif
    }
    
    /// Performed if device has macOS.
    func macOSOnlyModifier<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(macOS)
        return modifier(self)
        #else
        return self
        #endif
    }
    
    /// Performed if device has tvOS.
    func tvOSOnlyModifier<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(tvOS)
        return modifier(self)
        #else
        return self
        #endif
    }
    
    /// Performed if device has watchOS.
    func watchOSOnlyModifier<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if os(watchOS)
        return modifier(self)
        #else
        return self
        #endif
    }

    /// Read view's size and bind it to `size` property
    func readSize(to size: Binding<CGSize>) -> some View {
        readSize { size.wrappedValue = $0 }
    }

    /// Read view's size and take action on change
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { proxy in
                Color.clear
                    .preference(
                        key: SizePreferenceKey.self,
                        value: proxy.size
                    )
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

public enum Platform {
    case iOS
    case macOS
    case tvOS
    case watchOS
}
