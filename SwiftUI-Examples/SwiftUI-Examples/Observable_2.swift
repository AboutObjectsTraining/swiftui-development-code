//
//  Created 7/1/24 by Jonathan Lehr
//  Copyright © 2024 About Objects.
//  

import SwiftUI
import Observation

@Observable class BookListViewModel {
    let testData = [
        Book(title: "Book One", author: Author(name: "Fred Smith")),
        Book(title: "Book Two", author: Author(name: "Jan Jones")),
        Book(title: "Book Three", author: Author(name: "Bill Yu")),
    ]
    
    // Tracked collection property
    var books: [Book] = []
    
    // Computed properties
    var count: Int { books.count }
    var isEmpty: Bool { books.isEmpty }
    var lastBook: Book { books.last ?? Book() }
    
    init() {
        books = testData
        UITextField.appearance().clearButtonMode = .always
    }
    
    func append(_ book: Book) {
        books.append(book)
    }
    
    func removeLastBook() {
        books.removeLast()
    }
}

struct ObservableBookListContentView: View {
    let viewModel: BookListViewModel
    
    var body: some View {
        Text("Count: \(viewModel.count)")
            .font(.subheadline)
        Form {
            Section {
                TextInputView(book: viewModel.lastBook)
            }
            List {
                ForEach(viewModel.books, id: \.title) { book in
                    BookCell(book: book)
                }
            }
        }
        BookListControls(viewModel: viewModel)
    }
}

struct BookListControls: View {
    let viewModel: BookListViewModel
    
    var body: some View {
        HStack {
            Button("Delete Last Cell") {
                if !viewModel.isEmpty {
                    viewModel.removeLastBook()
                }
            }
            .disabled(viewModel.isEmpty)
            Spacer()
            Button("Restore Last Cell") {
                if viewModel.count < 3 {
                    viewModel.append(
                        viewModel.testData[viewModel.count]
                    )
                }
            }
            .disabled(viewModel.count == 3)
        }
        .padding()
    }
}

struct BookCell: View {
    let book: Book
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(book.title)
                .font(.headline)
            Text(book.author.name)
                .font(.subheadline)
        }
    }
}

#Preview {
    ObservableBookListContentView(viewModel: BookListViewModel())
}
