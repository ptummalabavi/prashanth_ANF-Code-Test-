import Foundation
import UIKit

class AppUtility {
    static let shared = AppUtility()
    
    /// alert controller
     func showAlert(_ title: String, _ message: String) {
         DispatchQueue.main.async {
             let alert = UIAlertController(
                 title: title,
                 message: message,
                 preferredStyle: UIAlertController.Style.alert
             )
             
             alert.addAction(UIAlertAction(
                 title: "OK",
                 style: UIAlertAction.Style.default,
                 handler: nil
             ))
             
             DispatchQueue.main.async {
                 let keyWindow = UIApplication.shared.connectedScenes
                         .filter({$0.activationState == .foregroundActive})
                         .map({$0 as? UIWindowScene})
                         .compactMap({$0})
                         .first?.windows
                         .filter({$0.isKeyWindow}).first
                 keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
             }
         }
     }
}

extension Bundle {
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
}
