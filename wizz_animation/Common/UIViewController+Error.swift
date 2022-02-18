//
//  UIViewController+Error.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import UIKit

extension UIViewController {
    func displayError(_ error: NSError) {
        OperationQueue.main.addOperation { [weak self] in
            let alert = UIAlertController(title: "Error", message: "An error occured, please try again later", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {_ in
                self?.dismiss(animated: true, completion: nil)
            }))
            self?.present(alert, animated: true, completion: nil)
        }
    }
}
