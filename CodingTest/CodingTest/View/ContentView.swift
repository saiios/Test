//
//  ContentView.swift
//  CodingTest
//
//  Created by APPLE on 07/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = CatViewModel()

    var body: some View {
        // Use a full-screen view to capture taps
        VStack {
            // Cat Image
            if let url = URL(string: viewModel.catImageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: 300)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: 300)
                    @unknown default:
                        EmptyView()
                    }
                }
            }

            // Cat Fact
            Text(viewModel.catFact)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()

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
    }
}
