//
//  Nibable.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import Foundation
import UIKit

protocol StoryboardInstantiable {
    static var storyboardName: String { get }
}

extension StoryboardInstantiable where Self: UIViewController {
    
    static var storyboardInstance: Self? {
        guard let storyboardId = String(describing: self).components(separatedBy: (".")).last else {
            return nil
        }
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: storyboardId)
        return viewController as? Self
    }
}

protocol Nibable {
    static var viewFromNib: Self { get }
    static var nib: UINib { get }
}

extension Nibable where Self: UIView {
    static var viewFromNib: Self {
        return nib.instantiate(withOwner: self, options: nil).first as! Self
    }
    
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: Bundle.main)
    }
    
    static var nibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}


protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {}
extension UICollectionReusableView: Reusable {}
