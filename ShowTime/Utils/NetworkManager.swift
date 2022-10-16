//
//  NetworkManager.swift
//  ShowTime
//
//  Created by Miguel Solans on 12/07/2022.
//

import Foundation

class NetworkManager {
    
    enum ManagerErrors: Error {
        case invalidResponse
        case invalidStatusCode(Int)
    }
    
    enum HttpMethod: String {
        case get
        case post
        
        var method: String { rawValue.uppercased() }
    }
    
    
    // Used to make request to any API outside our base url
    func request<T: Decodable>(toURL urlString: String, httpMethod: HttpMethod, parameters: Dictionary<String, Any>?, completion: @escaping (Result<T, Error>) -> Void) {
        let completionOnMain: (Result<T, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        let baseURL = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as! String
        let fullURL = "\(baseURL)/\(urlString)";
        
        var request = URLRequest(url: URL(string: fullURL)!)
        request.httpMethod = httpMethod.method;
        request.allHTTPHeaderFields = self.configureHeaders(customEndpoint: false);
        
        if((parameters != nil) && !(httpMethod == .get)) {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                completionOnMain(.failure(error));
                return
            }
        }
        
        let urlSession = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completionOnMain(.failure(error))
                return;
            }
            
            guard let urlResponse = response as? HTTPURLResponse else { return completionOnMain(.failure(ManagerErrors.invalidResponse)) }
            if !(200..<300).contains(urlResponse.statusCode) {
                return completionOnMain(.failure(ManagerErrors.invalidStatusCode(urlResponse.statusCode)))
            }
            
            guard let data = data else { return }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completionOnMain(.success(decodedData))
            } catch {
                debugPrint("Could not translate the data to the requested type. Reason: \(error.localizedDescription)")
                completionOnMain(.failure(error))
            }
        }
        
        urlSession.resume()
    }
    
    
    
    private func configureHeaders(customEndpoint: Bool) -> Dictionary<String, String> {
        
        if(!customEndpoint) {
            /* TODO: Later when Auth Services have been developed */
            return [
                "Content-Type": "application/json",
                "Accept": "application/json"
            ];
        } else {
            return [
                "Content-Type": "application/json",
                "Accept": "application/json"
            ];
        }
        
    }
}
