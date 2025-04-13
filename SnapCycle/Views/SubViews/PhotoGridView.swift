//
//  PhotoGridView.swift
//  SnapCycle
//
//  Created by Sahil Joshi on 4/8/25.
//

import SwiftUI

struct PhotoGridView: View {
    
    @ObservedObject var mainViewModel: MainViewModel
    
    let bgColor = AppColors.backgroundColor
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.green.opacity(0.1))
            .frame(minHeight: 100, maxHeight: 150)
            .overlay(
                VStack {
   
                    Spacer()
                    
                    if mainViewModel.selectedPhotos == false {
                        Text("Select some photos to view them here!")
                            .foregroundColor(bgColor)
                            .fontWeight(.bold)
                            .cornerRadius(8)
                            .italic()
                    }
                    
                    if mainViewModel.selectedPhotos == true {
                        ScrollView {
                            LazyHGrid(rows: [GridItem(.adaptive(minimum: 100))], alignment: .center, spacing: 10) {
                                ForEach(mainViewModel.selectedImages, id: \.self) { image in
                                    
                                    ZStack {
                                        Color.green
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(8)
                                            .opacity(0.8)
                                        
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFit()
                                            .cornerRadius(8)
                                            .shadow(radius: 3)
                                            .frame(width: 90, height: 90)
                                    }
                                    
                                }
                            }.frame(alignment: .center)
                        }
                    }
                    Spacer()
                    
                }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            ).padding(30)
        
    }
}

#Preview {
    let mainViewModel = MainViewModel()
    let genAIModel = GenAI(mainViewModel: mainViewModel)
    PhotoSelectionView(mainViewModel: mainViewModel, genAIModel: genAIModel)
}
