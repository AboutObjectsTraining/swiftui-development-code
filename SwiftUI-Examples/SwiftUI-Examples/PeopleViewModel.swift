// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI
import Combine

let values:[(String, Int)] = [
    ("Rob Jones", 22), ("Jill Brown", 19), ("Jan Smith", 70),
    ("Joe James", 65), ("Pat Marks", 25), ("Will Trent", 18),
    ("Fred Smith", 72), ("Gloria Lee", 39), ("Dan Ray", 12),
]

final class PeopleViewModel: ObservableObject {
    @Published var people: [Person] = []
    @Published var averageAge: Int = 0
    
    private var subscriptions: Set<AnyCancellable> = []
    
    init() {
        loadPeople()
        
        $people
            .sink { people in
                let sumOfAges = people.reduce(0) { $0 + $1.age }
                self.averageAge = people.count == 0 ? 0 : sumOfAges / people.count
            }
            .store(in: &subscriptions)
    }
    
    private func loadPeople() {
        people = values.map { Person(name: $0.0, age: $0.1) }
    }
}
