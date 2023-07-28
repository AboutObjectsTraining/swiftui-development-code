// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

private let imageStyle = "circle"

enum SelectedNumber: String, CaseIterable {
    case one
    case two
    case three
    
    var imageName: String {
        var baseName = ""
        switch(self) {
            case .one: baseName = "1"
            case .two:  baseName = "2"
            case .three:  baseName = "3"
        }
        
        return "\(baseName).\(imageStyle)"
    }
    
    var title: String { rawValue.capitalized }
    var imageTitle: String { "\(title).\(imageStyle)" }
}

struct Menus: View {
    @State var selectedImageName: String = imageStyle
    
    var body: some View {
        VStack(spacing: 18) {
            
            Menu("Choose Number") {
                ForEach(SelectedNumber.allCases, id: \.title) { number in
                    Button(number.title) {
                        select(number)
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            
            Image(systemName: selectedImageName)
                .imageScale(.large)
                .font(.title)
            
            Button("Reset", action: { selectedImageName = imageStyle })
        }
    }
    
    private func select(_ selectedNumber: SelectedNumber) {
        selectedImageName = selectedNumber.imageName
    }
}

struct Menus_Preview: PreviewProvider {

    static var previews: some View {
        Menus()
    }
}
