import Foundation

public func makeRequestUrl(masterUrl: String, path: String, queryItems: [URLQueryItem]?) -> URL? {
    guard let baseURL = URL(string: masterUrl) else {
        return nil
    }

    let requestURL: URL
    
    if path.isEmpty {
        requestURL = baseURL
    } else {
        requestURL = baseURL.appendingPathComponent(path)
    }
    
    if let queryItems = queryItems {
        var urlComponents = URLComponents(string: requestURL.absoluteString)
        urlComponents?.queryItems = queryItems
        guard let newRequestURL = urlComponents?.url else {
            return nil
        }
        return newRequestURL
    }
    return requestURL
}



