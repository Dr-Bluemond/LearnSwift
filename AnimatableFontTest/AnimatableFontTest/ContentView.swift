//
//  ContentView.swift
//  AnimatableFontTest
//
//  Created by bluemond on 2021/6/15.
//

import SwiftUI

// A modifier that animates a font through various sizes.
struct AnimatableCustomFontModifier: AnimatableModifier {
    var name: String
    var size: CGFloat

    var animatableData: CGFloat {
        get { size }
        set { size = newValue }
    }

    func body(content: Content) -> some View {
        content
            .font(.custom(name, size: size))
    }
}

// To make that easier to use, I recommend wrapping
// it in a `View` extension, like this:
extension View {
    func animatableFont(name: String, size: CGFloat) -> some View {
        self.modifier(AnimatableCustomFontModifier(name: name, size: size))
    }
}

// An example View trying it out
struct ContentView: View {
    @State private var fontSize: CGFloat = 32

    var body: some View {
        Text("Hello, World!")
            .animatableFont(name: "Georgia", size: fontSize)
            .onTapGesture {
                withAnimation(Animation.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1).repeatForever()) {
                    fontSize = 72
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
