//
//  ContentView.swift
//  CodingTest
//

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
            ZStack {
                ScrollView {
                    VStack(spacing: 20) {
                        CustomLoaderView(isLoading: isImageLoading) {
                            if let url = URL(string: viewModel.catImageUrl) {
                                KFImage(url)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .shadow(color: Color("ShadowColor"), radius: 5)
                                    .accessibilityIdentifier("catImage") // Added for UI Testing
                            }
                        }

                        if !isImageLoading {
                            Text(viewModel.catFact)
                                .font(.headline)
                                .multilineTextAlignment(.center)
                                .padding()
                                .accessibilityIdentifier("catFactText") // Added for UI Testing
                        }
                    }
                    .padding()
                }
                .background(Color("BackgroundColor"))

                // Disable interaction while loading by overlaying a transparent view
                if isImageLoading {
                    Color.black.opacity(0.001) // Almost invisible but captures taps
                        .ignoresSafeArea()
                        .accessibilityIdentifier("loadingOverlay") // Added for UI Testing
                }
                
                if let errorMsg = viewModel.errorMessage {
                    VStack {
                        Spacer()
                        Text("Error: \(errorMsg)")
                            .foregroundColor(.red)
                            .font(.headline)
                            .padding()
                            .accessibilityIdentifier("errorMessage") // Added for UI Testing
                    }
                }
            }
            .navigationTitle("Tap to Refresh")
            .accessibilityIdentifier("NavigationTitle")

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
        }
    }

    private func fetchCatData() {
        isImageLoading = true
        viewModel.fetchCatData {
            isImageLoading = false
        }
    }
}

// A reusable loader view that handles loading state
struct CustomLoaderView<Content: View>: View {
    let isLoading: Bool
    let content: () -> Content

    init(isLoading: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.isLoading = isLoading
        self.content = content
    }

    var body: some View {
        Group {
            if isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(1.5)
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .accessibilityIdentifier("progressView") // Added for UI Testing
            } else {
                content()
            }
        }
        .animation(.easeInOut, value: isLoading)
    }
}
