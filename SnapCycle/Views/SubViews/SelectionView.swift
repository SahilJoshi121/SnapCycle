//
//  PhotoSelectionView.swift
//  SnapCycle
//
//  Created by Sahil Joshi on 4/8/25.
//

import SwiftUI
import PhotosUI

struct PhotoSelectionView: View {
    
    @ObservedObject var mainViewModel: MainViewModel
    @ObservedObject var genAIModel: GenAI
    let bgColor = AppColors.backgroundColor
    let image = UIImage(named: "CardboardBox")
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    mainViewModel.selection.removeAll()
                    genAIModel.response = ""
                    mainViewModel.selectedPhotos = true
                } label: {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(bgColor)
                        .fontWeight(.bold)
                        .padding(.all, 10.0)
                        .border(bgColor, width: 3)
                        .cornerRadius(8)
                }

                
                PhotosPicker(selection: $mainViewModel.selection, matching: .images) {
                        Text("Select Photos")
                            .foregroundColor(bgColor)
                            .fontWeight(.bold)
                            .padding(.all, 10.0)
                            .border(bgColor, width: 3)
                            .cornerRadius(8)
                }
                
                Button {
                    mainViewModel.isAnalyzing = true
                    genAIModel.generateRespose(input: mainViewModel.selectedImages, type: "initialAnalysis")
                } label: {
                    Text("Analyze")
                        .foregroundColor(bgColor)
                        .fontWeight(.bold)
                        .padding(.all, 10.0)
                        .border(bgColor, width: 3)
                        .cornerRadius(8)
                }
                
                Button {
                    mainViewModel.selectedImages.append(image!)
                    mainViewModel.selectedPhotos = true
                } label: {
                    Image(systemName: "plus.diamond.fill")
                        .foregroundColor(bgColor)
                        .fontWeight(.bold)
                        .padding(.all, 10.0)
                        .border(bgColor, width: 3)
                        .cornerRadius(8)
                }

            }
            PhotoGridView(mainViewModel: mainViewModel)
                
            
        }.onChange(of: mainViewModel.selection) {_, newValue in
            
            mainViewModel.selectedPhotos = true
            
            Task {
                mainViewModel.selectedImages.removeAll()
                for photosPickerItem in mainViewModel.selection {
                    if let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                        if let image = UIImage(data: data) {
                            mainViewModel.selectedImages.append(image)
                        }
                    }
                }
            }
        }

    }
}

#Preview {
    let mainViewModel = MainViewModel()
    let genAIModel = GenAI(mainViewModel: mainViewModel)
    PhotoSelectionView(mainViewModel: mainViewModel, genAIModel: genAIModel)
}
