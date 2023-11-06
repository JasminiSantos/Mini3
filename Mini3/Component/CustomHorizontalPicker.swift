//
//  CustomHorizontalPicker.swift
//  Mini3
//
//  Created by Jasmini Rebecca Gomes dos Santos on 01/11/23.
//

import SwiftUI

struct CustomHorizontalPicker: View {
    @Binding var selectedItem: Int
    var items: [(id: Int, name: String)]
    var selectedBackgroundColor: Color
    var selectedTextColor: Color
    var unselectedTextColor: Color
    var borderColor: Color
    var cornerRadius: CGFloat = 20
    var fontSize: CGFloat = 20
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(items, id: \.id) { item in
                PickerButton(
                    text: item.name,
                    isSelected: item.id == selectedItem,
                    selectedBackgroundColor: selectedBackgroundColor,
                    selectedTextColor: selectedTextColor,
                    unselectedTextColor: unselectedTextColor,
                    borderColor: borderColor,
                    cornerRadius: cornerRadius,
                    isLeading: item.id == items.first?.id,
                    isTrailing: item.id == items.last?.id
                )
                .onTapGesture {
                    self.selectedItem = item.id
                }
            }
        }
    }
}


struct PickerButton: View {
    var text: String
    var isSelected: Bool
    var selectedBackgroundColor: Color
    var selectedTextColor: Color
    var unselectedTextColor: Color
    var borderColor: Color
    var cornerRadius: CGFloat
    var isLeading: Bool
    var isTrailing: Bool
    var fontSize: CGFloat = 20
    
    var body: some View {
        Text(text)
            .font(.system(size: fontSize, weight: .semibold))
            .frame(width: 200)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(
                isSelected ? selectedBackgroundColor : Color.clear
            )
            .foregroundColor(isSelected ? selectedTextColor : unselectedTextColor)
            .conditionalModifier(isLeading || isTrailing) {
                $0.cornerRadius(cornerRadius, corners: isLeading ? [.topLeft, .bottomLeft] : [.topRight, .bottomRight])
            }
            .overlay(
                PickerButtonBorder(isLeading: isLeading, isTrailing: isTrailing, cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: 1)
            )
    }
}

struct PickerButtonBorder: Shape {
    var isLeading: Bool
    var isTrailing: Bool
    var cornerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        if isLeading {
            path.move(to: CGPoint(x: cornerRadius, y: 0))
            path.addLine(to: CGPoint(x: width, y: 0))
            path.addLine(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: cornerRadius, y: height))
            path.addArc(center: CGPoint(x: cornerRadius, y: height - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
            path.addLine(to: CGPoint(x: 0, y: cornerRadius))
            path.addArc(center: CGPoint(x: cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        } else if isTrailing {
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: width - cornerRadius, y: 0))
            path.addArc(center: CGPoint(x: width - cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
            path.addLine(to: CGPoint(x: width, y: height - cornerRadius))
            path.addArc(center: CGPoint(x: width - cornerRadius, y: height - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
            path.addLine(to: CGPoint(x: 0, y: height))
        } else {
            path.addRect(rect)
        }
        
        return path
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
extension View {
    @ViewBuilder
    func conditionalModifier<Content: View>(
        _ condition: Bool,
        transform: (Self) -> Content
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
