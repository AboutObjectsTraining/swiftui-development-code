// Copyright (C) 2022 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct Shapes: View {
    
    let gradient = AngularGradient(
        colors: [.red, .orange, .yellow, .green, .blue, .purple, .pink],
        center: .center
    )
    
    var body: some View {
        Circle()
            .stroke(gradient, lineWidth: 20)
            .padding(40)
        
        ZStack {
            Circle()
                .stroke(gradient, lineWidth: 20)
                .padding(100)
            Text("Hello World!")
                .font(.system(size: 24).bold())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.ultraThinMaterial)
        }
    }
}

struct Shapes_Previews: PreviewProvider {
    static var previews: some View {
        Shapes()
    }
}
