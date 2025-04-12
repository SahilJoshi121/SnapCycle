//
//  APIKey.swift
//  SnapCycle
//
//  Created by Sahil Joshi on 4/6/25.
//

import Foundation

enum APIKey {
    //Fetch API Key

    static var `default`: String {
        guard let filePath = Bundle.main.path(forResource: "GenAI-Info", ofType: "plist")
        else {
            fatalError("Couldn't find GenAI-Info.plist")
        }
        
        let plist = NSDictionary(contentsOfFile: filePath)
        
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("API_KEY Not found in GenAI-Info.plist")
        }
        
        return value
    }
}
