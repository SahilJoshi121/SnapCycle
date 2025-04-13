//
//  SaplingViewModel.swift
//  SnapCycle
//
//  Created by Sahil Joshi on 4/12/25.
//

import Foundation
import SwiftUI

class SaplingViewModel: ObservableObject {
    @Published var currentSapling = Sapling(type: "basic", image: "BasicTreeSeedling")
    @Published var saplingCount = 0
    @Published var saplings = [Sapling]()
}
