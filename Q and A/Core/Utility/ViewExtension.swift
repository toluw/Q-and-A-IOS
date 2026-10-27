//
//  ViewExtension.swift
//  Q and A
//
//  Created by GIGL-PC on 05/04/2026.
//

import Foundation

import SwiftUI

extension View {
    func toastBanner(toast: Binding<ToastData?>) -> some View {
        self.modifier(ToastBannerModifier(toast: toast))
    }
    
    func globalBottomSheet() -> some View {
            self.modifier(GlobalBottomSheetModifier())
    }
}

/// Launch with -ForceIOS15Compatibility to exercise fallback paths on newer OSes.
/// This is fixed for the process lifetime and cannot be enabled in Release builds.
enum AppCompatibility {
    static let forceIOS15: Bool = {
        #if DEBUG
        let enabled = ProcessInfo.processInfo.arguments.contains("-ForceIOS15Compatibility")
        if enabled {
            print("[Compatibility] iOS 15 fallback paths enabled; using a separate debug cart.")
        }
        return enabled
        #else
        return false
        #endif
    }()
}

// Compatibility helpers keep newer SwiftUI behavior where available and use
// standard iOS 15 navigation and full-height sheets on older phones.
struct CompatibleNavigationView<Content: View>: View {
    @ViewBuilder let content: () -> Content

    var body: some View {
        if #available(iOS 16.0, *), !AppCompatibility.forceIOS15 {
            NavigationStack { content() }
        } else {
            NavigationView { content() }
                .navigationViewStyle(.stack)
        }
    }
}

private struct CompatibleChangeModifier<Value: Equatable>: ViewModifier {
    let value: Value
    let initial: Bool
    let action: (Value, Value) -> Void
    @State private var previous: Value
    @State private var appeared = false

    init(value: Value, initial: Bool, action: @escaping (Value, Value) -> Void) {
        self.value = value
        self.initial = initial
        self.action = action
        _previous = State(initialValue: value)
    }

    func body(content: Content) -> some View {
        content
            .onAppear {
                guard !appeared else { return }
                appeared = true
                previous = value
                if initial { action(value, value) }
            }
            .onChange(of: value) { newValue in
                let oldValue = previous
                previous = newValue
                action(oldValue, newValue)
            }
    }
}

enum CompatibleDetent: Hashable {
    case medium, large, height(CGFloat)

    @available(iOS 16.0, *)
    var native: PresentationDetent {
        switch self {
        case .medium: return .medium
        case .large: return .large
        case .height(let height): return .height(height)
        }
    }
}

enum CompatibleVisibility { case visible, hidden }
enum CompatibleKeyboardDismissMode { case interactively }

extension View {
    func onCompatibleChange<Value: Equatable>(
        of value: Value, initial: Bool = false,
        _ action: @escaping (Value, Value) -> Void
    ) -> some View {
        modifier(CompatibleChangeModifier(value: value, initial: initial, action: action))
    }

    @ViewBuilder
    func compatiblePresentationDetents(_ detents: Set<CompatibleDetent>) -> some View {
        if #available(iOS 16.0, *), !AppCompatibility.forceIOS15 {
            presentationDetents(Set(detents.map(\.native)))
        } else {
            self
        }
    }

    @ViewBuilder
    func compatiblePresentationDragIndicator(_ visibility: CompatibleVisibility) -> some View {
        if #available(iOS 16.0, *), !AppCompatibility.forceIOS15 {
            presentationDragIndicator(visibility == .visible ? .visible : .hidden)
        } else {
            self
        }
    }

    @ViewBuilder
    func compatiblePresentationCornerRadius(_ radius: CGFloat) -> some View {
        if #available(iOS 16.4, *), !AppCompatibility.forceIOS15 {
            presentationCornerRadius(radius)
        } else {
            self
        }
    }

    @ViewBuilder
    func compatiblePresentationBackground(_ color: Color) -> some View {
        if #available(iOS 16.4, *), !AppCompatibility.forceIOS15 {
            presentationBackground(color)
        } else {
            background(ClearBackgroundView())
        }
    }

    @ViewBuilder
    func compatibleScrollContentBackground(_ visibility: CompatibleVisibility) -> some View {
        if #available(iOS 16.0, *), !AppCompatibility.forceIOS15 {
            scrollContentBackground(visibility == .hidden ? .hidden : .visible)
        } else {
            self
        }
    }

    @ViewBuilder
    func compatibleScrollDismissesKeyboard(_ mode: CompatibleKeyboardDismissMode) -> some View {
        if #available(iOS 16.0, *), !AppCompatibility.forceIOS15 {
            scrollDismissesKeyboard(.interactively)
        } else {
            self
        }
    }

    @ViewBuilder
    func compatibleNavigationBarBackground(_ color: Color) -> some View {
        if #available(iOS 16.0, *), !AppCompatibility.forceIOS15 {
            toolbarBackground(color, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
        } else {
            self
        }
    }
}

struct CompatibleRoundedRectangle: Shape {
    var topLeadingRadius: CGFloat = 0
    var bottomLeadingRadius: CGFloat = 0
    var bottomTrailingRadius: CGFloat = 0
    var topTrailingRadius: CGFloat = 0
    @Environment(\.layoutDirection) private var layoutDirection

    func path(in rect: CGRect) -> Path {
        let limit = min(rect.width, rect.height) / 2
        let rtl = layoutDirection == .rightToLeft
        let tl = min(max(rtl ? topTrailingRadius : topLeadingRadius, 0), limit)
        let tr = min(max(rtl ? topLeadingRadius : topTrailingRadius, 0), limit)
        let bl = min(max(rtl ? bottomTrailingRadius : bottomLeadingRadius, 0), limit)
        let br = min(max(rtl ? bottomLeadingRadius : bottomTrailingRadius, 0), limit)
        var path = Path()
        path.move(to: CGPoint(x: rect.minX + tl, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - tr, y: rect.minY))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY + tr),
                          control: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - br))
        path.addQuadCurve(to: CGPoint(x: rect.maxX - br, y: rect.maxY),
                          control: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + bl, y: rect.maxY))
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY - bl),
                          control: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + tl))
        path.addQuadCurve(to: CGPoint(x: rect.minX + tl, y: rect.minY),
                          control: CGPoint(x: rect.minX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}
