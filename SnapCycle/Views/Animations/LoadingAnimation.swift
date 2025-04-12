//
//  LoadingAnimation.swift
//  SnapCycle
//
//  Created by Sahil Joshi on 1/20/25.
//

import SwiftUI


struct LoadingAnimation: View {
    
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        Image(systemName: "arrow.3.trianglepath")
            .font(.system(size: 150, weight: .bold, design: .default))
            .foregroundColor(.green)
            .rotationEffect(.degrees(rotationAngle))
            .animation(.linear(duration: 7)
                .repeatForever(autoreverses: true), value: rotationAngle)
            .onAppear {
                withAnimation {

                    rotationAngle = 380
                }
            }
    }
}

#Preview {
    LoadingAnimation()
}
