//
//  NetworkService.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 07.10.2023.
//

import Foundation

protocol NetworkLayer {
    func fetch<T: Decodable>(urlString: String, onCompletion: @escaping (Result<T, NetworkError>) -> Void)
    func post<T: Encodable>(urlString: String, body: T, method: HTTPMethod, onCompletion: @escaping (Result<Data?, NetworkError>) -> Void)
}

struct NetworkService: NetworkLayer {
    
    func fetch<T: Decodable>(urlString: String, onCompletion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            onCompletion(.failure(NetworkError.invalidUrl))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                if error != nil {
                    onCompletion(.failure(NetworkError.networkError))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    onCompletion(.failure(NetworkError.unexpectedResponse))
                    return
                }
                
                guard Self.httpStatusCodeSuccess.contains(response.statusCode) else {
                    onCompletion(.failure(NetworkError.failedResponse(response)))
                    return
                }
                
                guard let data else {
                    onCompletion(.failure(NetworkError.dataError))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let responseData = try decoder.decode(T.self, from: data)
                    onCompletion(.success(responseData))
                } catch {
                    onCompletion(.failure(NetworkError.parseError))
                }
            }
        }.resume()
    }
    
    func post<T: Encodable>(urlString: String, body: T, method: HTTPMethod, onCompletion: @escaping (Result<Data?, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            onCompletion(.failure(NetworkError.invalidUrl))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            urlRequest.httpBody = try JSONEncoder().encode(body)
        } catch {
            onCompletion(.failure(NetworkError.parseError))
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                if error != nil {
                    onCompletion(.failure(NetworkError.networkError))
                }
                
                guard let response = response as? HTTPURLResponse else {
                    onCompletion(.failure(NetworkError.unexpectedResponse))
                    return
                }
                
                guard Self.httpStatusCodeSuccess.contains(response.statusCode) else {
                    onCompletion(.failure(NetworkError.failedResponse(response)))
                    return
                }
            
                onCompletion(.success(data))
            }
        }.resume()
    }
    
    private static let httpStatusCodeSuccess = 200..<300
}

enum NetworkError: Error {
    case invalidUrl
    case networkError
    case dataError
    case parseError
    case unexpectedResponse
    case failedResponse(HTTPURLResponse)
}

enum HTTPMethod: String {
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
