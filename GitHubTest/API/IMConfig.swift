//
//  IMConfig.swift
//  GitHubTest
//
//  Created by bruno on 08/02/20.
//  Copyright © 2020 bruno. All rights reserved.
//

import Foundation

typealias CompletionSuccess = (() -> Void)?

class IMConfig<T: Fetcher> {
    
    public func fetch<V: Codable>(target: T,
                                  dataType: V.Type,
                                  completion: ((Result<V, Error>, URLResponse?) -> Void)?) {
        
        if !Reachability.isConnectedToNetwork() {
            completion?(.failure(IMError()), nil)
            return
        }
        
        let url = API.baseUrl + target.path
        let parameters = target.task?.dictionary() ?? [:]
        let method = target.method
        guard let urlRequest = URL(string: url) else {
            completion?(.failure(IMError()), nil)
            return
        }
        
        var request = URLRequest(url: urlRequest)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        
        if method == .POST {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
                return
            }
            request.httpBody = httpBody
            print("\n\n===========JSON===========")
            parameters.printJson()
            print("===========================\n\n")
        }
        
        session.dataTask(with: request) { (dataRequest, response, error) in
            guard let data = dataRequest else {
                print("\n\n===========Error===========")
                print("Error Code: \(error?._code ?? 0)")
                print("Error Messsage: \(error?.localizedDescription ?? "")")
                if let data = dataRequest, let str = String(data: data, encoding: String.Encoding.utf8) {
                    print("Server Error: " + str)
                }
                debugPrint(error as Any)
                print("===========================\n\n")
                completion?(.failure(IMError()), nil)
                return
            }
            do {
                let decodedResponse = try JSONDecoder().decode(dataType.self, from: data)
                completion?(.success(decodedResponse), response)
            } catch let error {
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription )")
                debugPrint(error as Any)
                print("===========================\n\n")
                completion?(.failure(IMError()), nil)
                return
            }
        }.resume()
    }
}
