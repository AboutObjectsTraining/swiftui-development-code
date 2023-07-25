// Copyright (C) 2022 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct Sheets_1: View {
    @State private var isShowingSheet = false
    
    var body: some View {
        VStack {
            TitledButton(title: "Main View",
                         action: showSheet,
                         label: "Show Sheet",
                         backgroundColor: .brown)
        }
        .sheet(isPresented: $isShowingSheet) {
            TitledButton(title: "Sheet",
                         action: dismissSheet,
                         label: "Dismiss Sheet",
                         backgroundColor: .orange)
        }
    }
    
    private func showSheet() {
        isShowingSheet = true
    }
    
    private func dismissSheet() {
        isShowingSheet = false
    }
}

struct TitledButton: View {
    let title: String
    let action: () -> Void
    let label: String
    let backgroundColor: Color
    
    var body: some View {
        VStack() {
            Text(title)
                .padding()
                .font(.title)
            Button(action: action, label: { Text(label) })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor.opacity(0.2))
    }
}


struct Sheets_1_Previews: PreviewProvider {
    static var previews: some View {
        Sheets_1()
    }
}
