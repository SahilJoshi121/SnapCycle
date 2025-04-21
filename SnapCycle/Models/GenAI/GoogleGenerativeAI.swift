//
//  GoogleGenerativeAI.swift
//  SnapCycle
//
//  Created by Sahil Joshi on 4/6/25.
//

import Foundation
import GoogleGenerativeAI
import SwiftUI

class GenAI: ObservableObject {
    @ObservedObject var mainViewModel: MainViewModel
    @Published var isLoading: Bool = false
    @Published var response = ""
    @Published var responseReady: Bool = false
    
    let model: GenerativeModel
    
    init(mainViewModel: MainViewModel) {
            self.mainViewModel = mainViewModel
            self.model = GenerativeModel(name: "gemini-1.5-flash", apiKey: APIKey.default)
    }
    
    func generateRespose(input: [UIImage], type: String) {
        isLoading = true
        response = ""
        responseReady = false
        
        Task {
            do {
                var parts: [ModelContent.Part] = []
                
                for image in input {
                    if let imageData = image.jpegData(compressionQuality: 0.8) {
                        parts.append(.data(mimetype: "image/jpeg", imageData))
                    }
                }
                
                switch type {
                    case "initialAnalysis":
                        parts.append(.text("What item is this? Is it recyclable? Where can it be recycled? Respond concisely."))
                    case "recycleProof":
                        parts.append(.text("Has this item been recycled correctly? Respond in a single integer point value from 1-5, based on how difficult succesful recycling of this item would be. For example, a cardboard box would be twoIf this has not been responded correctly, respond with zero. "))
                    default:
                        print("fatal error")
                }
            
                
                let modelContent = try await ModelContent(parts: parts)
                
                var modelContentArray: [ModelContent] = []
                
                modelContentArray.append(modelContent)
                
                let result = try await model.generateContent(modelContentArray)
                isLoading = false
                responseReady = true
                response = result.text ?? "ERROR"
            } catch {
                response = "Something went wrong\n\(error.localizedDescription)"
            }
        }
        
    }
    
}

