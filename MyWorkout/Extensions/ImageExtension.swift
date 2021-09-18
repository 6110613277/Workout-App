//
//  ImageExtension.swift
//  MyWorkout
//
//  Created by Siriluk Rachaniyom on 11/9/2564 BE.
//

import SwiftUI

extension Image {
    func resizedToFill(width: CGFloat, height: CGFloat) -> some View {
        self.resizable()
            .scaledToFill()
            .frame(width: width, height: height)
    }
}
