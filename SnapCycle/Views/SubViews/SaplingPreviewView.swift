//
//  SaplingPreviewView.swift
//  SnapCycle
//
//  Created by Sahil Joshi on 4/12/25.
//

import SwiftUI

struct SaplingPreviewView: View {
    let bgColor = AppColors.backgroundColor
    @StateObject var saplingViewModel = SaplingViewModel()
    @ObservedObject var genAIModel: GenAI
    @ObservedObject var mainViewModel: MainViewModel
    
    var body: some View {
        HStack{
            VStack {
                Text(saplingViewModel.currentSapling.name)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .foregroundColor(bgColor)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.green.opacity(0.1))
                    .frame(maxWidth: 100, minHeight: 100, maxHeight: 150)
                    .overlay(
                        Image(saplingViewModel.currentSapling.image)
                            .resizable()
                            .frame(width: 90, height: 120)
                    )
                    .padding(10)
                
                Spacer()
            }.padding(10)

            
            VStack(alignment: .leading) {
                Text("Statistics")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .padding(.bottom, 12)
                
                VStack(alignment: .leading){
                    Text("\(saplingViewModel.currentSapling.status)")
                    Text("Points until next stage: \(10 - saplingViewModel.currentSapling.progress)")
                    Text("Age: \(saplingViewModel.currentSapling.age) Days")
                }.italic()
                .font(.system(size: 15, design: .default))
                
                NavigationLink(destination: SaplingView(genAIModel: genAIModel, saplingViewModel: saplingViewModel, mainViewModel: mainViewModel)) {
                    Text("View More")
                        .fontWeight(.bold)
                        .padding(.all, 10.0)
                        .border(bgColor, width: 3)
                        .cornerRadius(8)
                }
                
                Spacer()
            }.padding(10)
            .foregroundColor(bgColor)
        }
    }
}

#Preview {
    let mainViewModel = MainViewModel()
    let genAIModel = GenAI(mainViewModel: mainViewModel)
    SaplingPreviewView(genAIModel: genAIModel, mainViewModel: mainViewModel)
}
