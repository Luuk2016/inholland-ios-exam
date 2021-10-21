//
//  NewsReaderAPI.swift
//  inholland-newsreader
//
//  Created by Luuk Kenselaar on 11/10/2021.
//

import Foundation
import Combine
import UIKit
import KeychainAccess

final class NewsReaderAPI : ObservableObject {
    static let shared = NewsReaderAPI()
    private var cancellable: AnyCancellable?
    
    private let keychain = Keychain()
    private var accessTokenKeychainKey: String = "accessToken"
    
    var accessToken: String? {
        get {
            try? keychain.get(accessTokenKeychainKey)
        }
        set(newValue) {
            guard let accessToken = newValue else {
                try? keychain.remove(accessTokenKeychainKey)
                isAuthenticated = false
                return
            }
            try? keychain.set(accessToken, key: accessTokenKeychainKey)
            isAuthenticated = true

        }
    }
    
    @Published var isAuthenticated: Bool = false
    
    private init() {
        isAuthenticated = accessToken != nil
    }
    
    func login() {
        
    }
    
    func logout() {
        accessToken = nil
    }
    
    func getArticles(completion: @escaping (Result<GetArticlesResponse, RequestError>) -> Void) {
        let url = URL(string: "https://inhollandbackend.azurewebsites.net/api/Articles")!
        let urlRequest = URLRequest(url: url)
        
        execute(request: urlRequest, completion: completion)
    }
    
    func getImage(
        for article: Article,
        completion: @escaping (Result<UIImage, RequestError>) -> Void) {
            let urlRequest = URLRequest(url: article.image)

            cancellable = URLSession.shared.dataTaskPublisher(for: urlRequest)
                .map({ UIImage(data: $0.data) ?? UIImage() })
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { result in
                switch result {
                    case .finished:
                        break
                    case .failure(let error):
                        completion(.failure(.urlError(error)))
                }
                }) { (image) in
            completion(.success(image))
        }
    }
    
    func execute<Response: Decodable>(
        request: URLRequest,
        completion: @escaping (Result<Response, RequestError>) -> Void) {
            cancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: Response.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (result) in
            switch result {
                case .finished:
                    break
                case .failure(let error):
                    switch error {
                    case let urlError as URLError:
                        completion(.failure(.urlError(urlError)))
                    case let decodingError as DecodingError:
                        completion(.failure(.decodingError(decodingError)))
                    default:
                        completion(.failure(.genericError(error)))
                    }
            }
            }, receiveValue: { (response) in
            completion(.success(response))
        })
    }
}

enum RequestError: Error {
    case urlError(URLError)
    case decodingError(DecodingError)
    case genericError(Error)
}
