//
//  Service.swift
//  NWLQuiz
//
//  Created by Nawal Ahmed on 13/09/2023.
//

import Foundation

protocol Request {
    var urlRequest: URLRequest { get }
}

protocol Service {
    func get(request: Request, completion: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkService: Service {
    enum ServiceError: Error {
        case noData
    }
    
    func get(request: Request, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: request.urlRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(ServiceError.noData))
                return
            }
            completion(.success(data))
        }.resume()
    }
}
