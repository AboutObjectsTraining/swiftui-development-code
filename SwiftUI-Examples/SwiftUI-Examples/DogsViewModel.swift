// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import Combine
import Foundation

struct Dog: Hashable, Identifiable {
    var id = UUID()
    var name: String
    var breed: String
}

let dogData:[(String, String)] = [
    ("Rover", "Labrador Retriever"), ("Spot", "Dalmation"),
    ("Fluffy", "Golden Retriever"), ("Sarge", "German Shepherd")
]

final class DogsViewModel: ObservableObject {
    @Published var dogs: [Dog] = []
    
    init() {
        loadDogs()
    }
    
    private func loadDogs() {
        dogs = dogData.map { Dog(name: $0.0, breed: $0.1) }
    }
}
