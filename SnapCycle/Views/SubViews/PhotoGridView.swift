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
        ScrollView {
            LazyHGrid(rows: [GridItem(.adaptive(minimum: 100))], alignment: .center, spacing: 10) {
                ForEach(mainViewModel.selectedImages, id: \.self) { image in
                    
                    ZStack {
                        Color.green
                            .frame(width: 100, height: 100)
                            .cornerRadius(8)
                        
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(8)
                            .shadow(radius: 3)
                            .frame(width: 90, height: 90)
                    }
                    
                }
            }
            .padding()
        }
    }
}

#Preview {
    PhotoSelectionView(mainViewModel: MainViewModel())
}
