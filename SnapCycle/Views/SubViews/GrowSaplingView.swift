//
//  GrowSaplingView.swift
//  SnapCycle
//
//  Created by Sahil Joshi on 4/12/25.
//

import SwiftUI
import _PhotosUI_SwiftUI
import ConfettiSwiftUI

struct GrowSaplingView: View {
    
    let image = UIImage(named: "CardboardRecycling")
    
    @ObservedObject var genAIModel: GenAI
    @ObservedObject var saplingViewModel: SaplingViewModel
    @ObservedObject var mainViewModel: MainViewModel
    let bgColor = AppColors.backgroundColor
    @State var showingAlert = false
    
    @State private var trigger: Int = 0
    
    var body: some View {
        ZStack {
            bgColor.ignoresSafeArea(edges: .all).opacity(1)
            
            Color(.white).opacity(0.9).edgesIgnoringSafeArea(.all).padding(10).cornerRadius(50)
            
            VStack{
                Spacer()
                
                Text("Snap a photo of your succesfully recycled object to grow your sapling!")
                    .multilineTextAlignment(.center)
                    .italic()
                    .foregroundColor(bgColor).opacity(0.6)
                    .font(.system(size: 20))
                
                Image(saplingViewModel.currentSapling.image)
                    .resizable()
                    .frame(width: 125, height: 200)
                    .cornerRadius(20)
                    .padding(20)
                    .confettiCannon(trigger: $trigger, colors: [.green, bgColor], radius: 300.0)
                
                Text("Your sapling needs to grow by \(10 - saplingViewModel.currentSapling.progress) points in order to progress to the next stage!")
                    .multilineTextAlignment(.center)
                    .bold()
                    .foregroundColor(bgColor).opacity(0.6)
                    .font(.system(size: 20))
                    .padding(20)
                
                Spacer()
                
                PhotoGridView(mainViewModel: mainViewModel)
                
                HStack {
                    Button {
                        mainViewModel.selectedImages.removeAll()
                        
                        if mainViewModel.selectedImages.contains(image!) {
                            mainViewModel.selectedImages.removeAll { $0 == image! }
                        } else {
                            mainViewModel.selectedImages.append(image!)
                            mainViewModel.selectedPhotos = true
                        }
                    
                        
                    } label: {
                        Image(systemName: "plus.diamond.fill")
                            .foregroundColor(bgColor)
                            .fontWeight(.bold)
                            .padding(.all, 10.0)
                            .border(bgColor, width: 3)
                            .cornerRadius(8)
                    }
                    
                    PhotosPicker(selection: $mainViewModel.selection, matching: .images) {
                        Text("Select Photo Proof")
                            .foregroundColor(bgColor)
                            .fontWeight(.bold)
                            .padding(.all, 10.0)
                            .border(bgColor, width: 3)
                            .cornerRadius(8)
                    }
                    
                    Button {
                        if !mainViewModel.selectedImages.isEmpty {
                            genAIModel.generateRespose(input: mainViewModel.selectedImages, type: "recycleProof")
                        }
                        
                    } label: {
                        Text("Submit")
                            .foregroundColor(bgColor)
                            .fontWeight(.bold)
                            .padding(.all, 10.0)
                            .border(bgColor, width: 3)
                            .cornerRadius(8)
      
                    }.onChange(of: genAIModel.responseReady) { _,  isReady in
                        if genAIModel.response != "" {
                            if let intResponse = Int(genAIModel.response) {
                                if intResponse != 0 {
                                    saplingViewModel.currentSapling.progress += Int(genAIModel.response)!
                                    trigger += 1
                                } else {
                                    showingAlert.toggle()
                                }
                                
                                if saplingViewModel.currentSapling.progress >= 10 {
                                        saplingViewModel.currentSapling.progress = 0
                                        saplingViewModel.currentSapling.status = "Stage 2"
                                        saplingViewModel.currentSapling.image = "BasicTreeStage2"
                                    
                                    waitFor(seconds: 0.5) {
                                        saplingViewModel.growViewShown = false
                                    }
                                }
                            }
                            genAIModel.response = ""
                            genAIModel.responseReady = false
                        }
                    }

                    if genAIModel.isLoading {
                        ProgressView()
                    }
                }
                
                Spacer()
                
            }
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
    GrowSaplingView(genAIModel: genAIModel, saplingViewModel: SaplingViewModel(), mainViewModel: mainViewModel)
}
