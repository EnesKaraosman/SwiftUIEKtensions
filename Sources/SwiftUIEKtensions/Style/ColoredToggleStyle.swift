//
//  ColoredToggleStyle.swift
//  
//
//  Created by Enes Karaosman on 14.07.2020.
//

import SwiftUI

public struct ColoredToggleStyle: ToggleStyle {
    
//    var label = ""
    var onColor = Color(UIColor.green)
    var offColor = Color(UIColor.systemGray5)
    var thumbColor = Color.white
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Button(action: { configuration.isOn.toggle() } )
            {
                RoundedRectangle(cornerRadius: 16, style: .circular)
                    .fill(configuration.isOn ? onColor : offColor)
                    .frame(width: 50, height: 29)
                    .overlay(
                        Circle()
                            .fill(thumbColor)
                            .shadow(radius: 1, x: 0, y: 1)
                            .padding(1.5)
                            .offset(x: configuration.isOn ? 10 : -10))
                    .animation(Animation.easeInOut(duration: 0.1))
            }
        }
        .font(.title)
        .padding(.horizontal)
    }
}

struct ColoredToggleStyle_Previews: PreviewProvider {
    static var previews: some View {
        Toggle(isOn: .constant(true), label: {
            Text("Label")
        }).toggleStyle(ColoredToggleStyle(onColor: .blue, offColor: .orange, thumbColor: .black))
    }
}
