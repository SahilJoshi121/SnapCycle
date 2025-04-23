//
//  MiscellaneousMethods.swift
//  SnapCycle
//
//  Created by Sahil Joshi on 4/23/25.
//

import Foundation

func waitFor(seconds: Double, thenExecute: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        thenExecute()
    }
}
