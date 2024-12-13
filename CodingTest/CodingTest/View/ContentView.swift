//
//  ContentView.swift
//  CodingTest
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @StateObject private var viewModel = CatViewModel()
    @State private var isImageLoading = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Custom Image Loader View
                    DynamicImageView(imageUrl: viewModel.catImageUrl, isLoading: $isImageLoading)
                    
                    // Cat Fact with adaptive padding and scroll support
                    if !isImageLoading {
                        Text(viewModel.catFact)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .padding()
                            .foregroundColor(.primary) // Adaptive text color
                            .accessibilityIdentifier("Cat Fact")
                    }
                }
                .padding()
            }
            .background(backgroundColor) // Adaptive background
            .navigationTitle("Tap to Refresh")
            .refreshable {
                fetchCatData()
            }
            .onTapGesture {
                if !isImageLoading {
                    fetchCatData()
                }
            }
            .onAppear {
                fetchCatData()
            }
            // Error Message (if there's an error)
            if let errorMsg = viewModel.errorMessage {
                Text("Error: \(errorMsg)")
                    .foregroundColor(.red)
                    .font(.headline)
                    .padding()
                    .accessibilityIdentifier("errorLabel")
            }
        }
    }

    private func fetchCatData() {
        isImageLoading = true
        viewModel.fetchCatData {
            isImageLoading = false
        }
    }

    // Adaptive Colors
    private var backgroundColor: Color {
        Color("BackgroundColor") // Define in Assets.xcassets for light/dark variants
    }
}

struct DynamicImageView: View {
    let imageUrl: String
    @Binding var isLoading: Bool

    var body: some View {
        if let url = URL(string: imageUrl) {
            KFImage(url)
                .placeholder {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                }
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(color: Color("ShadowColor"), radius: 5)
                .onAppear { isLoading = false }
                .onDisappear { isLoading = false }
                .accessibilityIdentifier("catImageView")
        }
    }
}
