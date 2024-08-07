// Copyright (C) 2022 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct Navigation_1: View {
    @StateObject private var viewModel = PeopleViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.people, id: \.name) { person in
                ZStack(alignment: .leading) {
                    
                    HStack {
                        Image(systemName: "person")
                        Text(person.name)
                    }
                    
                    NavigationLink("") {
                        Form {
                            Text("Name: \(person.name)")
                            Text("Age: \(person.age)")
                        }
                        .navigationTitle("Selected Person")
                    }
                }
            }
            .navigationTitle("People")
        }
    }
}

struct Navigation_Previews: PreviewProvider {
    static var previews: some View {
        Navigation_1()
    }
}
