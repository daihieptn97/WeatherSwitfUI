//
//  LoaddingView.swift
//  WetherDemo
//
//  Created by Hiệp Trần on 18/4/24.
//

import SwiftUI

struct LoaddingView: View {
    var body: some View {
        ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LoaddingView()
}
