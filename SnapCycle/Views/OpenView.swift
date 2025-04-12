//
//  OpenView.swift
//  SnapCycle
//
//  Created by Sahil Joshi on 1/20/25.
//

import SwiftUI

struct OpenView: View {
    var body: some View {
        ZStack {
            Color(Color(red: 0.2, green: 0.5, blue: 0.2)).ignoresSafeArea(edges: .all)
            VStack {
                LoadingAnimation()
                
                Text("SnapCycle")
                    .font(.system(size: 50, weight: .bold, design: .default))
                    .foregroundColor(.white)
                
        
                NavigationLink {
                    MainView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    Text("Get Started")
                        .font(.system(size: 30, weight: .bold, design: .default))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
            }
        }
    }
}

#Preview {
    NavigationView{
        OpenView()
    }
}
