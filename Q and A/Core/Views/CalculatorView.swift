//
//  CalculatorView.swift
//  Q and A
//
//  Created by GIGL-PC on 11/06/2026.
//

import Foundation


import SwiftUI

// MARK: - Calculator Logic

enum CalcButton: String {
    case zero = "0", one = "1", two = "2", three = "3", four = "4"
    case five = "5", six = "6", seven = "7", eight = "8", nine = "9"
    case dot = "."
    case add = "+", subtract = "−", multiply = "×", divide = "÷"
    case equals = "="
    case clear = "AC"
    case toggleSign = "+/−"
    case percent = "%"

    var color: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equals:
            return Color("AccentOrange")
        case .clear, .toggleSign, .percent:
            return Color("ButtonGray")
        default:
            return Color("ButtonDark")
        }
    }

    var foregroundColor: Color {
        switch self {
        case .clear, .toggleSign, .percent:
            return .black
        default:
            return .white
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

class CalculatorViewModel: ObservableObject {
    @Published var display: String = "0"
    @Published var activeOperation: Operation = .none
    @Published var highlightedOperator: CalcButton? = nil

    private var currentValue: Double = 0
    private var storedValue: Double = 0
    private var shouldResetDisplay = false
    private var hasDecimal = false

    func press(_ button: CalcButton) {
        switch button {
        case .zero, .one, .two, .three, .four,
             .five, .six, .seven, .eight, .nine:
            handleDigit(button.rawValue)

        case .dot:
            handleDot()

        case .clear:
            reset()

        case .toggleSign:
            toggleSign()

        case .percent:
            applyPercent()

        case .add:
            setOperation(.add, button: button)

        case .subtract:
            setOperation(.subtract, button: button)

        case .multiply:
            setOperation(.multiply, button: button)

        case .divide:
            setOperation(.divide, button: button)

        case .equals:
            calculate()
        }
    }

    private func handleDigit(_ digit: String) {
        if shouldResetDisplay {
            display = digit
            shouldResetDisplay = false
            hasDecimal = false
        } else {
            if display == "0" && digit != "." {
                display = digit
            } else {
                if display.count < 9 {
                    display += digit
                }
            }
        }
    }

    private func handleDot() {
        if shouldResetDisplay {
            display = "0."
            shouldResetDisplay = false
            hasDecimal = true
            return
        }
        if !hasDecimal {
            display += "."
            hasDecimal = true
        }
    }

    private func reset() {
        display = "0"
        currentValue = 0
        storedValue = 0
        activeOperation = .none
        highlightedOperator = nil
        shouldResetDisplay = false
        hasDecimal = false
    }

    private func toggleSign() {
        if let value = Double(display) {
            let toggled = value * -1
            display = formatResult(toggled)
        }
    }

    private func applyPercent() {
        if let value = Double(display) {
            let result = value / 100
            display = formatResult(result)
        }
    }

    private func setOperation(_ op: Operation, button: CalcButton) {
        if let value = Double(display) {
            if activeOperation != .none && !shouldResetDisplay {
                storedValue = computeResult(storedValue, value)
                display = formatResult(storedValue)
            } else {
                storedValue = value
            }
        }
        activeOperation = op
        highlightedOperator = button
        shouldResetDisplay = true
    }

    private func calculate() {
        guard let value = Double(display) else { return }
        currentValue = value
        let result = computeResult(storedValue, currentValue)
        display = formatResult(result)
        storedValue = result
        activeOperation = .none
        highlightedOperator = nil
        shouldResetDisplay = true
    }

    private func computeResult(_ a: Double, _ b: Double) -> Double {
        switch activeOperation {
        case .add:      return a + b
        case .subtract: return a - b
        case .multiply: return a * b
        case .divide:   return b != 0 ? a / b : 0
        case .none:     return b
        }
    }

    private func formatResult(_ value: Double) -> String {
        if value.truncatingRemainder(dividingBy: 1) == 0 && abs(value) < 1_000_000_000 {
            return String(Int(value))
        }
        let formatted = String(format: "%.6g", value)
        return formatted
    }
}

// MARK: - Views

struct CalculatorButtonView: View {
    let button: CalcButton
    let isHighlighted: Bool
    let action: () -> Void

    private let size: CGFloat = 72
    private let spacing: CGFloat = 12

    var body: some View {
        Button(action: action) {
            Text(button.rawValue)
                .font(.system(size: 28, weight: .medium, design: .rounded))
                .foregroundColor(isHighlighted ? button.color : button.foregroundColor)
                .frame(width: size, height: size)
                .background(
                    isHighlighted
                        ? Color.white
                        : button.color
                )
                .clipShape(Circle())
        }
        .buttonStyle(CalculatorButtonStyle())
    }
}

struct CalculatorButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.93 : 1.0)
            .opacity(configuration.isPressed ? 0.85 : 1.0)
            .animation(.spring(response: 0.2, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

struct CalculatorView: View {
    @StateObject private var vm = CalculatorViewModel()
    let onDismiss : () -> Void

    private let buttons: [[CalcButton]] = [
        [.clear, .toggleSign, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .dot, .equals]
    ]

    var body: some View {
        ZStack {
            Color("BackgroundBlack")
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                HStack {
                    Spacer()
                    Button(action: { onDismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 26))
                            .foregroundColor(Color.white.opacity(0.3))
                    }
                    .padding(.trailing, 20)
                    .padding(.top, 16)
                }

                Spacer()

                // Display
                HStack {
                    Spacer()
                    Text(vm.display)
                        .font(.system(size: displayFontSize, weight: .thin, design: .rounded))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.4)
                        .padding(.horizontal, 24)
                }
                .padding(.bottom, 28)

                // Buttons
                VStack(spacing: 12) {
                    ForEach(buttons, id: \.self) { row in
                        HStack(spacing: 12) {
                            ForEach(row, id: \.self) { button in
                                if button == .zero {
                                    // Wide zero button
                                    Button(action: { vm.press(button) }) {
                                        Text(button.rawValue)
                                            .font(.system(size: 28, weight: .medium, design: .rounded))
                                            .foregroundColor(.white)
                                            .frame(width: 156, height: 72, alignment: .leading)
                                            .padding(.leading, 28)
                                            .background(Color("ButtonDark"))
                                            .clipShape(Capsule())
                                    }
                                    .buttonStyle(CalculatorButtonStyle())
                                } else {
                                    CalculatorButtonView(
                                        button: button,
                                        isHighlighted: vm.highlightedOperator == button
                                    ) {
                                        vm.press(button)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
            }
        }
    }

    private var displayFontSize: CGFloat {
        let len = vm.display.count
        if len <= 6  { return 80 }
        if len <= 9  { return 60 }
        return 44
    }
}

// MARK: - Color Assets (define in Assets.xcassets)
// BackgroundBlack  → #1C1C1E
// ButtonDark       → #333333
// ButtonGray       → #A5A5A5
// AccentOrange     → #FF9F0A

// MARK: - Entry Point (for standalone preview / dialog usage)

struct CalculatorDialog: View {
    @State private var showCalculator = false

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            Button("Open Calculator") {
                showCalculator = true
            }
            .font(.headline)
            .sheet(isPresented: $showCalculator) {
                CalculatorView(onDismiss: {})
                    .presentationDetents([.height(560)])
                    .presentationDragIndicator(.visible)
                    .presentationCornerRadius(32)
            }
        }
    }
}

#Preview("Dialog") {
    CalculatorDialog()
}

#Preview("Full") {
    CalculatorView(onDismiss: {})
}


