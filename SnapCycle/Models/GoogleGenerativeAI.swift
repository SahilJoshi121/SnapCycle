//
//  GoogleGenerativeAI.swift
//  SnapCycle
//
//  Created by Sahil Joshi on 4/6/25.
//

import Foundation
import GoogleGenerativeAI
import SwiftUI


var isLoading: Bool = false
var response = ""


let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)

func generateRespose(input: [UIImage]) {
    isLoading = true
    response = ""
    
    Task {
        do {
            let result = try await model.generateContent("")
            isLoading = false
            response = result.text ?? "ERROR"
        } catch {
            
        }
    }
    
}

