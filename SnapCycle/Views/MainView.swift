//
//  MainView.swift
//  SnapCycle
//
//  Created by Sahil Joshi on 1/20/25.
//

import SwiftUI
import PhotosUI




struct MainView: View {
    
    @StateObject var mainViewModel = MainViewModel()
    
    var body: some View {
        VStack {
            Text("SnapCycle")
                .font(.system(size: 40, weight: .bold, design: .default))
                .foregroundColor(Color(red: 0.2, green: 0.5, blue: 0.2))
            
            PhotoSelectionView(mainViewModel: mainViewModel)
            
        }
    }

    
}



#Preview {
    NavigationView{
        MainView()
    }
}
