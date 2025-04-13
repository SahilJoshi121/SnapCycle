//
//  AITextView.swift
//  SnapCycle
//
//  Created by Sahil Joshi on 4/12/25.
//

import SwiftUI

struct AITextView: View {
    
    @ObservedObject var mainViewModel: MainViewModel
    @ObservedObject var genAIModel: GenAI
    
    var body: some View {
        
        let bgColor = AppColors.backgroundColor
        
        VStack {
            if genAIModel.isLoading == false {
                if genAIModel.response == "" {
                    Text("Tap analyze to analyze your images!")
                        .foregroundColor(bgColor)
                        .fontWeight(.bold)
                        .padding(.all, 10.0)
                        .cornerRadius(8)
                        .padding(.leading, 10)
                        .italic()
                } else {
                    Text(genAIModel.response)
                        .foregroundColor(bgColor)
                        .fontWeight(.bold)
                        .padding(.all, 10.0)
                        .cornerRadius(8)
                        .padding(.leading, 10)
                        .italic()
                }
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.green))
                    .scaleEffect(3)
            }
        }.padding()
    }
}

#Preview {
    let mainViewModel = MainViewModel()
    let genAIModel = GenAI(mainViewModel: mainViewModel)
    AIView(mainViewModel: mainViewModel, genAIModel: genAIModel)
}
