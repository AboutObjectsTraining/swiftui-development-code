import SwiftUI

struct MyView: View {
    @State var count = 0
    
    var body: some View {
        Text("My Awesome View!")
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MyView()
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
                .previewDisplayName("Dark Mode")
            MyView()
                .previewDisplayName("Light Mode")
        }
        .font(.largeTitle)
    }
}

#Preview {
    MyView()
}
