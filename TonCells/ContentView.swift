//
//  ContentView.swift
//  TonCells
//
//  Created by Кирилл Кириленко on 03.03.2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject
    var viewModel = TonCellsViewModel()

    @State
    var isScaled: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                if let image = viewModel.image {
                    Spacer()
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .pinchToZoom()
//                        .scaleEff?ect(isScaled ? 1 : 0)
                    Spacer()
                } else {
                    ProgressView()
                }
            }
            .onAppear {
                viewModel.loadData()
            }
            .navigationTitle("TonCells")
//            .toolbar {
//                Button {
//                    withAnimation {
//                        isScaled.toggle()
//                    }
//                } label: {
//                    Text("Zoom Epta")
//                }
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
