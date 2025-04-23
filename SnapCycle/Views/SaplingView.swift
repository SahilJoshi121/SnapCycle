//
//  SaplingView.swift
//  SnapCycle
//
//  Created by Sahil Joshi on 4/12/25.
//

import SwiftUI

struct SaplingView: View {
    @ObservedObject var genAIModel: GenAI
    @ObservedObject var saplingViewModel: SaplingViewModel
    @ObservedObject var mainViewModel: MainViewModel
    let bgColor = AppColors.backgroundColor
    @State var newName = ""
    
    
    var body: some View {
        ZStack{
            bgColor.ignoresSafeArea(edges: .all).opacity(1)
            
            Color(.white).opacity(0.9).edgesIgnoringSafeArea(.all).padding(10).cornerRadius(50)
            
            VStack {
                Text("\(saplingViewModel.currentSapling.name)")
                    .font(.system(size: 40, weight: .bold, design: .default))
                    .foregroundColor(bgColor)
                    .padding()
                
                HStack {
                    Image(saplingViewModel.currentSapling.image)
                        .resizable()
                        .frame(width: 200, height: 300)
                        .cornerRadius(20)
                        .padding(20)
                    
                    VStack{
                        Button {
                            saplingViewModel.growViewShown.toggle()
                        } label: {
                            Text("GROW")
                                .font(.system(size: 20, weight: .bold, design: .default))
                                .foregroundColor(bgColor)
                                .padding()
                                .border(bgColor, width: 4)
                                .cornerRadius(8)
                        }
                        
                        Text("\(saplingViewModel.currentSapling.progress*10)% GROWN")
                            .font(.system(size: 15, weight: .bold, design: .default))
                            .foregroundColor(bgColor)
                            .padding()
                    
                    }
 
                }
                HStack {
                    VStack {
                        Text("Rename")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .padding(.bottom, 45).italic()
                        
                        TextField("Rename", text: $saplingViewModel.currentSapling.name).italic().foregroundColor(.gray)
                    }.padding(.leading, 40)
                    VStack(alignment: .leading) {
                        Text("Statistics")
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .padding(.bottom, 12)
                        
                        VStack(alignment: .leading){
                            Text("\(saplingViewModel.currentSapling.status)")
                            Text("Progress: \(saplingViewModel.currentSapling.progress)")
                            Text("Age: \(saplingViewModel.currentSapling.age) Days")
                        }.italic()
                        .font(.system(size: 15, design: .default))
                    }.padding(40)
                    
                }.foregroundColor(bgColor)

            }
        }.sheet(isPresented: $saplingViewModel.growViewShown) {
            GrowSaplingView(genAIModel: genAIModel, saplingViewModel: saplingViewModel, mainViewModel: mainViewModel)
        }
    }
}

#Preview {
    NavigationView {
        let mainViewModel = MainViewModel()
        let genAIModel = GenAI(mainViewModel: mainViewModel)
        SaplingView(genAIModel: genAIModel, saplingViewModel: SaplingViewModel(), mainViewModel: mainViewModel)
    }
}
