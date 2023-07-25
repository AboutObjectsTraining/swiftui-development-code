// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct Navigation_3: View {
    let colors: [Color] = [.red, .green, .blue, .brown, .cyan]
    
    var body: some View {
        NavigationStack {
            List(colors, id: \.description) { color in
                NavigationLink(color.description, value: color)
            }
            .navigationDestination(for: Color.self) { color in
                color
            }
        }
    }
}


struct Navigation_4: View {
    @StateObject private var viewModel = DogsViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.dogs) { dog in
                HStack {
                    Image(systemName: "pawprint.fill")
                    NavigationLink(dog.name, value: dog)
                }
            }
            .navigationTitle("Dogs")
            .navigationDestination(for: Dog.self) { dog in
                Form {
                    Text("Name: \(dog.name)")
                    Text("Breed: \(dog.breed)")
                }
                .navigationTitle("Selected Dog")
            }
        }
    }
}

struct Navigation_3_Previews: PreviewProvider {
    static var previews: some View {
        Navigation_3()
    }
}

struct Navigation_4_Previews: PreviewProvider {
    static var previews: some View {
        Navigation_4()
            .previewDisplayName("Nav 4")
    }
}
