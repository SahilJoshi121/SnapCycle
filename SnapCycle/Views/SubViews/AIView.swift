//
//  AIView.swift
//  SnapCycle
//
//  Created by Sahil Joshi on 4/12/25.
//

import SwiftUI

struct AIView: View {
    
    @ObservedObject var mainViewModel: MainViewModel
    @ObservedObject var genAIModel: GenAI
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.green.opacity(0.1))
            .frame(minHeight: 175, maxHeight: 300)
            .overlay(
                AITextView(mainViewModel: mainViewModel, genAIModel: genAIModel)
            )
            .padding(30)
    }
}

#Preview {
    
    let mainViewModel = MainViewModel()
    let genAIModel = GenAI(mainViewModel: mainViewModel)
    
    Button {
        genAIModel.generateRespose(input: mainViewModel.selectedImages, type: "initialAnalysis")
    } label: {
        Text("generate")
    }

    
    
    AIView(mainViewModel: mainViewModel, genAIModel: genAIModel)
}
