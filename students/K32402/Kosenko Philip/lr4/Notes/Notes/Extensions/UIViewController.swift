

import UIKit

extension UIViewController {


    func showAlert(with title: String, and message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

       
        present(alertController, animated: true, completion: nil)
    }

}
