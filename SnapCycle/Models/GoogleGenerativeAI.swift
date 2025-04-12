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
    
    let model: GenerativeModel
    
    init(mainViewModel: MainViewModel) {
            self.mainViewModel = mainViewModel
            self.model = GenerativeModel(name: "gemini-1.5-flash", apiKey: APIKey.default)
    }
    
    func generateRespose(input: [UIImage]) {
        isLoading = true
        response = ""
        
        Task {
            do {
                var parts: [ModelContent.Part] = []
                
                for image in input {
                    if let imageData = image.jpegData(compressionQuality: 0.8) {
                        parts.append(.data(mimetype: "image/jpeg", imageData))
                    }
                }
                
                parts.append(.text("hi"))
                
                let result = try await model.generateContent("")
                isLoading = false
                response = result.text ?? "ERROR"
            } catch {
                response = "Something went wrong\n\(error.localizedDescription)"
            }
        }
        
    }
    
}

