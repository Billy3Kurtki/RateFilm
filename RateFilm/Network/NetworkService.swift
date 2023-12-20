//
//  NetworkService.swift
//  RateFilm
//
//  Created by Кирилл Казаков on 07.10.2023.
//

import Foundation

protocol NetworkLayer {
    func fetchAsync<T: Decodable>(urlString: String, token: String?, body: [String : String]?, _ type: T.Type) async -> Result<T, NetworkError>
    func postAsync<T: Encodable>(urlString: String, body: T, method: HTTPMethod, token: String?) async -> Result<Data?, NetworkError>
}

final class NetworkService: NetworkLayer {
    private lazy var session = URLSession.shared
    
    func fetchAsync<T: Decodable>(urlString: String, token: String? = nil, body: [String : String]? = nil, _ type: T.Type = T.self) async -> Result<T, NetworkError> {
        guard let url = URL(string: urlString) else {
            return .failure(NetworkError.invalidUrl)
        }
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return .failure(NetworkError.invalidUrl)
        }
        
        components.queryItems = body?.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        guard let url = components.url else {
            return .failure(NetworkError.invalidUrl)
        }
        
        
        var urlRequest = URLRequest(url: url)
        if let token = token {
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        do {
            let (data, response) = try await session.data(for: urlRequest, delegate: nil)
            guard let _ = response as? HTTPURLResponse else {
                print(NetworkError.unexpectedResponse)
                return .failure(NetworkError.unexpectedResponse)
            }
            
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(T.self, from: data)
                return .success(responseData)
            } catch {
                print(NetworkError.parseError)
                return .failure(NetworkError.parseError)
            }
        } catch {
            print(NetworkError.requestError)
            return .failure(NetworkError.requestError)
        }
    }
    
    func postAsync<T: Encodable>(urlString: String, body: T, method: HTTPMethod, token: String? = nil) async -> Result<Data?, NetworkError> {
        guard let url = URL(string: urlString) else {
            return .failure(NetworkError.invalidUrl)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = token {
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        do {
            let requestData = try JSONEncoder().encode(body)
            do {
                let (data, response) = try await session.upload(for: urlRequest, from: requestData)
                guard let response = response as? HTTPURLResponse else {
                    return .failure(NetworkError.unexpectedResponse)
                }
                
                guard Self.httpStatusCodeSuccess.contains(response.statusCode) else {
                    return .failure(NetworkError.failedResponse(response))
                }
            
                return .success(data)
            } catch {
                return .failure(NetworkError.requestError)
            }
        } catch {
            return .failure(NetworkError.parseError)
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
    case serverError
}

enum HTTPMethod: String {
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum ServerString: String {
    case baseUrlString = "https://покаНепонятноКуда"
    case login = "https://0f65-31-28-198-216.ngrok-free.app/Account/Login"
    case register = "https://0f65-31-28-198-216.ngrok-free.app/Account/Register"
    case changePassword = "https://покаНепонятноКуда/account/changePassword"
    case movies = "https://0f65-31-28-198-216.ngrok-free.app/Movie"
    case film = "https://покаНепонятноКуда/film"
    case serial = "https://покаНепонятноКуда/serial"
    case user = "https://0f65-31-28-198-216.ngrok-free.app/User"
    case users = "https://0f65-31-28-198-216.ngrok-free.app/User/FindUsers"
}
