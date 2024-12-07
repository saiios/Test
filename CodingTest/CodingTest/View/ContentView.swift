//
//  ContentView.swift
//  CodingTest
//

// ContentView.swift
import SwiftUI
import Kingfisher

struct ContentView: View {
    @StateObject private var viewModel = CatViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Load Cat Image with Kingfisher caching
                    if let url = URL(string: viewModel.catImageUrl) {
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
                            .shadow(color: shadowColor, radius: 5) // Adaptive shadow
                            .transition(.opacity)
                            .animation(.easeInOut(duration: 0.5), value: viewModel.catImageUrl)
                            .accessibilityIdentifier("catImageView")
                    }

                    // Cat Fact with scroll support and adaptive padding
                    Text(viewModel.catFact)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding()
                        .foregroundColor(.primary) // Adaptive text color
                        .accessibilityIdentifier("Cat Fact")
                    
                    Spacer()
                }
                .padding()
            }
            .background(backgroundColor) // Adaptive background
            .navigationTitle("Tap to Refresh")
            .refreshable {
                viewModel.fetchCatData()
            }
            .onTapGesture {
                viewModel.fetchCatData()
            }
            .onAppear {
                viewModel.fetchCatData()
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

    // Adaptive Colors
    private var backgroundColor: Color {
        Color("BackgroundColor") // Define in Assets.xcassets for light/dark variants
    }

    private var shadowColor: Color {
        Color("ShadowColor") // Define in Assets.xcassets for light/dark variants
    }
}


