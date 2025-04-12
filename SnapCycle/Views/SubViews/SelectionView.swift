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
    
    var body: some View {
        VStack {
            HStack {
                
                Button {
                    mainViewModel.selection.removeAll()
                } label: {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(Color.green)
                        .fontWeight(.bold)
                        .padding(.all, 10.0)
                        .border(Color.green, width: 3)
                        .cornerRadius(8)
                }

                
                PhotosPicker(selection: $mainViewModel.selection, matching: .images) {
                        Text("Select Photos")
                            .foregroundColor(Color.green)
                            .fontWeight(.bold)
                            .padding(.all, 10.0)
                            .border(Color.green, width: 3)
                            .cornerRadius(8)
                }
                
                Button {
                    
                } label: {
                    Text("Analyze")
                        .foregroundColor(Color.green)
                        .fontWeight(.bold)
                        .padding(.all, 10.0)
                        .border(Color.green, width: 3)
                        .cornerRadius(8)
                }

            }
            PhotoGridView(mainViewModel: mainViewModel)
            
        }.onChange(of: mainViewModel.selection) {_, newValue in
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
    PhotoSelectionView(mainViewModel: MainViewModel())
}
