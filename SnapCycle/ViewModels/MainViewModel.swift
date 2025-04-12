//
//  MainViewModel.swift
//  SnapCycle
//
//  Created by Sahil Joshi on 4/8/25.
//

import Foundation
import SwiftUI
import PhotosUI

class MainViewModel: ObservableObject {
    @Published var selection: [PhotosPickerItem] = []
    @Published var selectedImages: [UIImage] = []
}
