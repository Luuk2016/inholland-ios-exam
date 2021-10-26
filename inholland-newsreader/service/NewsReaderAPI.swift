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
    private var cancellable: Set<AnyCancellable> = .init()
    private let keychain = Keychain()
    private var accessTokenKeychainKey: String = "accessToken"
    @Published var isAuthenticated: Bool = false
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
    
    private init() {
        isAuthenticated = accessToken != nil
    }
    
    func login(username: String, password: String) {
        let url = URL(string: "https://inhollandbackend.azurewebsites.net/api/Users/login")!
        var urlRequest = URLRequest(url: url)
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        
        let parameters = LoginRequest(
            username: username,
            password: password
        )
        
        let encoder = JSONEncoder()
        guard let body = try? encoder.encode(parameters) else { return }
        urlRequest.httpBody = body
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            
            let resData = try! JSONDecoder().decode(LoginResponse.self, from: data)
            print(resData.AuthToken)
            if resData.AuthToken != "" {
                DispatchQueue.main.async {
                    self.accessToken = resData.AuthToken
                }
            }
        }.resume()
    }
    
    func signup(username: String, password: String) {
        let url = URL(string: "https://inhollandbackend.azurewebsites.net/api/Users/register")!
        var urlRequest = URLRequest(url: url)
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        
        let parameters = SignupRequest(
            username: username,
            password: password
        )
        
        let encoder = JSONEncoder()
        guard let body = try? encoder.encode(parameters) else { return }
        urlRequest.httpBody = body
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            let resData = try! JSONDecoder().decode(SignupResponse.self, from: data)
            
            print("Message " + resData.Message)
            
            return
        }.resume()
    }
    
    func logout() {
        accessToken = nil
    }
    
    func likeArticle(articleID: Int) {
        let url = URL(string: "https://inhollandbackend.azurewebsites.net/api/Articles/\(articleID)/like")!
        var urlRequest = URLRequest(url: url)
        
        urlRequest.setValue(self.accessToken, forHTTPHeaderField: "x-authtoken")
        urlRequest.httpMethod = "PUT"
                
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
        }.resume()
    }
    
    func unlikeArticle(articleID: Int) {
        let url = URL(string: "https://inhollandbackend.azurewebsites.net/api/Articles/\(articleID)/like")!
        var urlRequest = URLRequest(url: url)
        
        urlRequest.setValue(self.accessToken, forHTTPHeaderField: "x-authtoken")
        urlRequest.httpMethod = "DELETE"
                
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
        }.resume()
    }
    
    func getArticles(completion: @escaping (Result<GetArticlesResponse, RequestError>) -> Void) {
        let url = URL(string: "https://inhollandbackend.azurewebsites.net/api/Articles")!
        let urlRequest = URLRequest(url: url)
        
        execute(request: urlRequest, completion: completion)
    }
    
    func getFavoriteArticles(completion: @escaping (Result<GetArticlesResponse, RequestError>) -> Void) {
        let url = URL(string: "https://inhollandbackend.azurewebsites.net/api/Articles/liked")!
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue(self.accessToken, forHTTPHeaderField: "x-authtoken")
        
        execute(request: urlRequest, completion: completion)
    }
        
    func getImage(
        for article: Article,
        completion: @escaping (Result<UIImage, RequestError>) -> Void) {
            let urlRequest = URLRequest(url: article.image)

            URLSession.shared.dataTaskPublisher(for: urlRequest)
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
        }.store(in: &cancellable)
    }
    
    func execute<Response: Decodable>(
        request: URLRequest,
        completion: @escaping (Result<Response, RequestError>) -> Void) {
            URLSession.shared.dataTaskPublisher(for: request)
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
        }).store(in: &cancellable)
    }
}

enum RequestError: Error {
    case urlError(URLError)
    case decodingError(DecodingError)
    case genericError(Error)
}
