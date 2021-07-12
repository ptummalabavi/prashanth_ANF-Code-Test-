import Foundation
import UIKit

typealias ResultCompletion<T> = (_ result:Result<T, Error>) -> Void

//End point name
enum EndPoint: String {
    case dev      = "https://www.abercrombie.com/anf/nativeapp/qa/"
}

///Method type
enum HTTPMethod : String {
    case get     = "GET"
}

///API resource URL
enum ApiResource : String {
    case codeTest       = "codetest/codeTest_exploreData.json"
}

class APIService: NSObject {
    static let shared = APIService()
    let requestTimeout = 10.0
    let session = URLSession.shared
    
    /// Get request
    func requestWithGet<T:Codable>(resourceType: ApiResource, value: String = "", requestType:HTTPMethod, completion : @escaping ResultCompletion<T?>) {
        var strUrl = ""
        strUrl = EndPoint.dev.rawValue + resourceType.rawValue + value
        strUrl = strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        print("URL = \(strUrl)")
        guard let url = URL(string:strUrl) else {
            return
        }
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60.0)
        session.dataTask(with: request) { (data, urlResponse, error) in
            if let error = error {
                AppUtility.shared.showAlert(Bundle.main.displayName ?? "", error.localizedDescription)
                return completion(.failure(error))
            }
            guard let data = data else {return}
            let jsonDecoder = JSONDecoder()
            do {
                let empData = try jsonDecoder.decode(T.self, from: data)
                return completion(.success(empData))
            } catch let error {
                AppUtility.shared.showAlert(Bundle.main.displayName ?? "", error.localizedDescription)
                return completion(.failure(error))
            }
        }.resume()
    }
}
