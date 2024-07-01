//
//  Created 6/27/24 by Jonathan Lehr
//  Copyright © 2024 About Objects.
//  

import Observation
import SwiftUI

// MARK: - Model Objects
@Observable class Author {
    var name: String
    
    init(name: String = "") {
        self.name = name
    }
}

@Observable class Book {
    var title: String
    var author: Author
    
    init(title: String = "", author: Author = Author()) {
        self.title = title
        self.author = author
    }
}

// MARK: - View Model
@Observable class BookViewModel {
    var book = Book(title: "Book One",
                    author: Author(name: "Fred Smith"))
}

// MARK: - Views
struct ObservableBookContentView: View {
    @State private var viewModel = BookViewModel()
    
    var body: some View {
        Form {
            Section {
                TextInputView(book: viewModel.book)
            }
            Section {
                SummaryViewOne(book: viewModel.book)
            }
            Section {
                SummaryViewTwo()
                    .environment(viewModel)
            }
        }
    }
    
    init() {
        UITextField.appearance().clearButtonMode = .always
    }
}

struct TextInputView: View {
    @Bindable var book: Book
    
    var body: some View {
        VStack {
            TextField("Title", text: $book.title)
            TextField("Author", text: $book.author.name)
        }
    }
}

struct SummaryViewOne: View {
    let book: Book
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Summary One").bold()
            Text("Title: \(book.title)")
            Text("Author: \(book.author.name)")
        }
        .font(.callout.monospaced())
    }
}

struct SummaryViewTwo: View {
    @Environment(BookViewModel.self) var viewModel: BookViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Summary Two").bold()
            Text("Title: \(viewModel.book.title)")
            Text("Author: \(viewModel.book.author.name)")
        }
        .font(.callout.smallCaps())
    }
}

#if DEBUG
#Preview {
    Group {
        ObservableBookContentView()
    }
}
#endif
