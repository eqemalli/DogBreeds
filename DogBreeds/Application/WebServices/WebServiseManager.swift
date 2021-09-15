//
//  WebServiseManager.swift
//  DogBreeds
//
//  Created by Enxhi Qemalli on 14.9.21.
//

import UIKit
import Combine

enum BreedsAPIError: LocalizedError {
    case requestNotFormed
    
    var errorDescription: String? {
        switch self {
        case .requestNotFormed: return "Unable to form the request."
        }
    }
}

struct WebServiceConstants {
    static let baseURL = "https://dog.ceo/api"
    static let allBreedsAPI = "/breeds/list/all"
    static let breedImagesAPI = "/breed/"
}

class WebServiceManager: NSObject {
    
    static let sharedService = WebServiceManager()
        
    enum HTTPMethodType: String {
        case POST = "POST"
        case GET = "GET"
    }
    
    func requestAPI<T: Decodable>(url: String, parameter: [String: AnyObject]? = nil, httpMethodType: HTTPMethodType = .GET) -> AnyPublisher<T, BreedsAPIError> {
        guard let escapedAddress = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
            let url = URL(string: escapedAddress) else {
                return Fail(error: BreedsAPIError.requestNotFormed).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethodType.rawValue
        
        if let requestBodyParams = parameter {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: requestBodyParams, options: .prettyPrinted)
            } catch {
                return Fail(error: BreedsAPIError.requestNotFormed).eraseToAnyPublisher()
            }
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.0 }
            .decode(type: T.self, decoder: JSONDecoder())
            .catch { _ in Fail(error: BreedsAPIError.requestNotFormed).eraseToAnyPublisher() }
            .eraseToAnyPublisher()
    }
}

