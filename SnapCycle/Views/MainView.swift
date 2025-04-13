//
//  MainView.swift
//  SnapCycle
//
//  Created by Sahil Joshi on 1/20/25.
//

import SwiftUI
import PhotosUI




struct MainView: View {
    
    @StateObject var mainViewModel: MainViewModel
    @StateObject var genAIModel: GenAI
    
    let bgColor = AppColors.backgroundColor

    init() {
        let mainViewModel = MainViewModel()
        _mainViewModel = StateObject(wrappedValue: mainViewModel)
        _genAIModel = StateObject(wrappedValue: GenAI(mainViewModel: mainViewModel))
    }

    var body: some View {
        ZStack{
            
            bgColor.ignoresSafeArea(edges: .all).opacity(1)
            
            Color(.white).opacity(0.9).edgesIgnoringSafeArea(.all).padding(10).cornerRadius(50)
            
 
            VStack {
                HStack{
                    Text("SnapCycle")
                        .font(.system(size: 40, weight: .bold, design: .default))
                        .foregroundColor(bgColor)
                        .padding()
                    
                    Image(systemName: "arrow.3.trianglepath")
                        .font(.system(size: 30, weight: .bold, design: .default))
                        .foregroundColor(bgColor)
                }
                
                PhotoSelectionView(mainViewModel: mainViewModel, genAIModel: genAIModel)
                
                AIView(mainViewModel: mainViewModel, genAIModel: genAIModel)
                
                SaplingPreviewView(genAIModel: genAIModel, mainViewModel: mainViewModel)
                
            }
        }
    }

    
}



#Preview {
    NavigationView{
        MainView()
    }
}
