// Copyright (C) 2022 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct PersonView: View {
    @StateObject var viewModel = PersonViewModel()
    
    var body: some View {
        Form {
            HStack {
                Text("Name:")
                Text("\(viewModel.person?.name ?? "unknown")")
            }
            HStack {
                Text("Age:")
                Text("\(viewModel.person?.age ?? 0)")
            }
            HStack {
                Spacer()
                Button(action: change, label: { Text("Change") })
                    .buttonStyle(.borderedProminent)
            }
        }
    }
    
    func change() {
        let (name, age) = values[Int.random(in: 0..<values.count)]
        viewModel.change(name: name, age: age)
    }
}

struct Observables_Previews: PreviewProvider {
    static var previews: some View {
        PersonView()
    }
}
