//
//  ContentView.swift
//  CodingTest
//
//  Created by APPLE on 07/12/24.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @StateObject private var viewModel = CatViewModel()

    var body: some View {
        VStack {
            // Load Cat Image with Kingfisher caching and fit to screen width
            if let url = URL(string: viewModel.catImageUrl) {
                KFImage(url)
                    .placeholder {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1.5)
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)  // Ensures the image fits the screen width
                    .padding(.bottom, 20)       // Adds some spacing below the image
            }

            // Cat Fact Text Below the Image
            Text(viewModel.catFact)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
                .padding(.bottom, 30)

            Spacer()
        }
        .background(Color.clear)  // Ensures background taps are captured
        .contentShape(Rectangle()) // Ensures tap gestures work on the entire rectangle
        .onTapGesture {
            print("Screen tapped")  // Debugging
            viewModel.fetchCatData()
        }
        .onAppear {
            viewModel.fetchCatData()
        }
        .navigationTitle("Tap to Refresh")
    }
}
