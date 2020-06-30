
import UIKit

//MARK:- Responsbility: To hide keyboard when tapping around.
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
        
        func showAlertDialog(title: String, message: String, dismissHandler: ((UIAlertAction) -> Void)?) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: dismissHandler))
            self.present(alert, animated: true)
        }
        
       
   

}


