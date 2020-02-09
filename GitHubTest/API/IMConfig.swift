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
            completion?(.failure(IMError.connection), nil)
            return
        }
        
        let url = API.baseUrl + target.path
        let parameters = target.task?.dictionary() ?? [:]
        let method = target.method
        guard let urlRequest = URL(string: url) else {
            completion?(.failure(IMError.generic), nil)
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
        }
        
        session.dataTask(with: request) { (dataRequest, response, error) in
            self.debugResponse(request, dataRequest, response, error)
            guard let data = dataRequest else {
                print("\n\n===========Error===========")
                print("Error Code: \(error?._code ?? 0)")
                print("Error Messsage: \(error?.localizedDescription ?? "")")
                if let data = dataRequest, let str = String(data: data, encoding: String.Encoding.utf8) {
                    print("Server Error: " + str)
                }
                debugPrint(error as Any)
                print("===========================\n\n")
                completion?(.failure(IMError.generic), nil)
                return
            }
            do {
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                let decodedResponse = try decoder.decode(dataType.self, from: data)
                completion?(.success(decodedResponse), response)
            } catch let error {
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription )")
                debugPrint(error as Any)
                print("===========================\n\n")
                completion?(.failure(IMError.parse), nil)
                return
            }
        }.resume()
    }
}

private extension IMConfig {
    private func debugResponse(_ request: URLRequest,
                               _ responseData: Data?,
                               _ response: URLResponse?,
                               _ error: Error?) {
        let uuid = UUID().uuidString
        print("\n↗️ ======= REQUEST =======")
        print("↗️ REQUEST #: \(uuid)")
        print("↗️ URL: \(request.url?.absoluteString ?? "")")
        print("↗️ HTTP METHOD: \(request.httpMethod ?? "GET")")
        
        if let requestHeaders = request.allHTTPHeaderFields,
            let requestHeadersData = try? JSONSerialization.data(withJSONObject: requestHeaders, options: .prettyPrinted),
            let requestHeadersString = String(data: requestHeadersData, encoding: .utf8) {
            print("↗️ HEADERS:\n\(requestHeadersString)")
        }
        
        if let requestBodyData = request.httpBody,
            let requestBody = String(data: requestBodyData, encoding: .utf8) {
            print("↗️ BODY: \n\(requestBody)")
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            print("\n↙️ ======= RESPONSE =======")
            switch httpResponse.statusCode {
            case 200...202:
                print("↙️ CODE: \(httpResponse.statusCode) - ✅")
            case 400...505:
                print("↙️ CODE: \(httpResponse.statusCode) - 🆘")
            default:
                print("↙️ CODE: \(httpResponse.statusCode) - ✴️")
            }
            
            if let responseHeadersData = try? JSONSerialization.data(withJSONObject: httpResponse.allHeaderFields, options: .prettyPrinted),
                let responseHeadersString = String(data: responseHeadersData, encoding: .utf8) {
                print("↙️ HEADERS:\n\(responseHeadersString)")
            }
            
            if let responseBodyData = responseData,
                let responseBody =  String(data: responseBodyData, encoding: .utf8),
                !responseBody.isEmpty {
                
                print("↙️ BODY:\n\(responseBody)\n")
            }
        }
        
        if let urlError = error as? URLError {
            print("\n❌ ======= ERROR =======")
            print("❌ CODE: \(urlError.errorCode)")
            print("❌ DESCRIPTION: \(urlError.localizedDescription)\n")
        }
        
        print("======== END OF: \(uuid) ========\n\n")
    }
}
