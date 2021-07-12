import Foundation
import UIKit

struct AFDetailsViewModel {
    ///fetch AfDetail from API
    func getAFDetails(value: String = "", completion: @escaping (_ result: [AFDetailModel]?) -> Void) {
        APIService.shared.requestWithGet(resourceType: .codeTest, value: value, requestType: .get, completion: { (result:Result<[AFDetailModel]?, Error>) in
            switch result {
            case .success(let respone):
                return completion(respone)
            case .failure(let error):
                print(error)
                return completion(nil)
            }
        })
    }
}
