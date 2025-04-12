//
//  PhotoGridView.swift
//  SnapCycle
//
//  Created by Sahil Joshi on 4/8/25.
//

import SwiftUI

struct PhotoGridView: View {
    
    @ObservedObject var mainViewModel: MainViewModel
    
    var body: some View {
        if mainViewModel.selectedPhotos == false {
            Text("Select some photos to view them here!")
                .foregroundColor(Color.green)
                .fontWeight(.bold)
                .padding(.all, 10.0)
                .cornerRadius(8)
                .padding(.leading, 10)
                .italic()
        }
        
        Spacer()
        
        
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
        
        Spacer()
    }
}

#Preview {
    PhotoSelectionView(mainViewModel: MainViewModel())
}
