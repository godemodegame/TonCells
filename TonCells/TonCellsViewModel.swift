//
//  TonCellsViewModel.swift
//  TonCells
//
//  Created by Кирилл Кириленко on 03.03.2023.
//

import UIKit
import Combine

@MainActor
final class TonCellsViewModel: ObservableObject {
    @Published
    public var image: UIImage?

    func loadData() {
        Task {
            do {
                let (data, _) = try await URLSession
                    .shared
                    .data(from: URL(string: "https://app.toncells.org:9917/API/getMAPEDIT")!)
                image = UIImage(data: data)!
            } catch let error {
                print(error)
            }
        }
    }
}
