//
//  Created 7/7/24 by Jonathan Lehr
//  Copyright © 2024 About Objects.
//

import XCTest
import SwiftUI
import Observation

final class AsyncAwaitTests: XCTestCase {
    
    func testClosureBasedMethod() {
        // TODO: implement me.
    }
}

@Observable class ViewModel {
    enum FetchError: Error {
        case badID, badImage
    }
    
    func thumbnailURLRequest(for id: String) -> URLRequest {
        URLRequest(url: URL(string: "id")!)
    }
    
    func fetchThumbnail(for id: String,
                        completion: @escaping (UIImage?, Error?) -> Void) {
        let request = thumbnailURLRequest(for: id)
        let size = CGSize(width: 40, height: 40)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if let error = error {
                completion(nil, error)
            } else if (response as? HTTPURLResponse)?.statusCode != 200 {
                completion(nil, FetchError.badID)
            } else {
                guard let image = UIImage(data: data!) else {
                    // Easy to forget this...
                    completion(nil, FetchError.badImage)
                    return
                }
                image.prepareThumbnail(of: size) { thumbnail in
                    guard let thumbnail = thumbnail else {
                        // Easy to forget this...
                        completion(nil, FetchError.badImage)
                        return
                    }
                    completion(thumbnail, nil)
                }
            }
        }
        task.resume()
    }
    
    func fetchThumbnail(for id: String) async throws -> UIImage {
        let request = thumbnailURLRequest(for: id)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw FetchError.badID
        }
        
        let image = UIImage(data: data)
        guard let thumbnail = await image?.thumbnail else {
            throw FetchError.badImage
        }
        
        return thumbnail
    }
}

extension UIImage {
    var thumbnail: UIImage {
        get async {
            return self
        }
    }
}

struct ThumbnailView: View {
    var viewModel: ViewModel
    @State private var image: UIImage?

    var body: some View {
        if let image = self.image {
            Image(uiImage: image)
                .onAppear {
                    Task {
                        self.image = try? await self.viewModel.fetchThumbnail(for: "X")
                    }
                }
        }
    }
}
