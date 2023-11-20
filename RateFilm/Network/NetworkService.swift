//
//  NetworkService.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 07.10.2023.
//

import Foundation

protocol NetworkLayer {
    func fetch<T: Decodable>(urlString: String, onCompletion: @escaping (Result<T, NetworkError>) -> Void) async
    func post<T: Encodable>(urlString: String, body: T, method: HTTPMethod, onCompletion: @escaping (Result<Data?, NetworkError>) -> Void) async
}

final class NetworkService: NetworkLayer {
    private lazy var session = URLSession.shared
    
    func fetch<T: Decodable>(urlString: String, onCompletion: @escaping (Result<T, NetworkError>) -> Void) async {
        guard let url = URL(string: urlString) else {
            onCompletion(.failure(NetworkError.invalidUrl))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        do {
            let (data, response) = try await session.data(for: urlRequest, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                onCompletion(.failure(NetworkError.unexpectedResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let responseData = try decoder.decode(T.self, from: data)
                onCompletion(.success(responseData))
            } catch {
                onCompletion(.failure(NetworkError.parseError))
                return
            }
        } catch {
            onCompletion(.failure(NetworkError.requestError))
            return
        }
    }
    
    func post<T: Encodable>(urlString: String, body: T, method: HTTPMethod, onCompletion: @escaping (Result<Data?, NetworkError>) -> Void) async {
        guard let url = URL(string: urlString) else {
            onCompletion(.failure(NetworkError.invalidUrl))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let requestData = try JSONEncoder().encode(body)
            do {
                let (data, response) = try await session.upload(for: urlRequest, from: requestData)
                guard let response = response as? HTTPURLResponse else {
                    onCompletion(.failure(NetworkError.unexpectedResponse))
                    return
                }
                
                guard Self.httpStatusCodeSuccess.contains(response.statusCode) else {
                    onCompletion(.failure(NetworkError.failedResponse(response)))
                    return
                }
            
                onCompletion(.success(data))
            } catch {
                onCompletion(.failure(NetworkError.requestError))
            }
        } catch {
            onCompletion(.failure(NetworkError.parseError))
            return
        }
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
    case requestError
}

enum HTTPMethod: String {
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
