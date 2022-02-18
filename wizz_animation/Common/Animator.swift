//
//  Animator.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import Foundation
import UIKit

final class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    static let duration: TimeInterval = 0.5
    
    private let todayViewController: TodayViewController
    private let todayDetailViewController: TodayDetailViewController
    private var imageNamed: String
    private let principalImageViewRect: CGRect
    
    //MARK: - INIT FOR ANIMATION
    init?(todayViewController: TodayViewController, todayDetailViewController: TodayDetailViewController, imageNamed: String) {
        self.todayViewController = todayViewController
        self.todayDetailViewController = todayDetailViewController
        self.imageNamed = imageNamed
        
        guard
            let window = todayViewController.view.window,
            let selectedCell = todayViewController.selectedCell else {
            return nil
        }
        self.principalImageViewRect = (selectedCell.principalImage.convert(selectedCell.principalImage!.bounds, to: window))
    }
    
    //MARK: - DURATION
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }
    
    //MARK: - ANIMATION - UPDATE CONSTRAINT FOR ANIMATION
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        guard let toView = todayDetailViewController.view else {
            transitionContext.completeTransition(false)
            return
        }
        
        toView.alpha = 0
        containerView.addSubview(toView)
        
        let snapPrincipalImage = UIImageView()
        snapPrincipalImage.contentMode = .scaleAspectFill
        snapPrincipalImage.clipsToBounds = true
        snapPrincipalImage.backgroundColor = .blue
        snapPrincipalImage.layer.cornerRadius = 12
        
        snapPrincipalImage.loadData(url: URL(string: imageNamed)!) { (data, error) in
            if (error == nil) {
                snapPrincipalImage.image = UIImage(data: data!)
                containerView.addSubview(snapPrincipalImage)
                snapPrincipalImage.frame = self.principalImageViewRect
                
                UIView.animate(withDuration: Self.duration, delay: 0, options: .curveEaseOut) {
                    
                    let width = (self.todayDetailViewController.view.bounds.width - Constants.cellSpacing) / 2
                    self.todayViewController.tableView.alpha = 0
                    self.todayDetailViewController.collectionView.alpha = 0
                    
                    snapPrincipalImage.translatesAutoresizingMaskIntoConstraints = false
                    snapPrincipalImage.layer.cornerRadius = 0
                    
                    let topConstraint = NSLayoutConstraint(item: snapPrincipalImage, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: containerView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: containerView.safeAreaInsets.top)
                    
                    let leadingConstraint = NSLayoutConstraint(item: snapPrincipalImage, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: containerView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
                    
                    let widthConstraint = NSLayoutConstraint(item: snapPrincipalImage, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: width)
                    
                    let heightConstraint = NSLayoutConstraint(item: snapPrincipalImage, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: width)
                    
                    containerView.addConstraints([topConstraint, widthConstraint, heightConstraint, leadingConstraint])
                    containerView.layoutIfNeeded()
                    
                } completion: { _ in
                    toView.alpha = 1
                    UIView.animate(withDuration: 0.25, delay: 0.5, animations: {
                        
                        self.todayDetailViewController.collectionView.alpha = 1
                        self.todayViewController.tableView.alpha = 1
                        
                    }, completion: { _ in
                        
                        snapPrincipalImage.removeFromSuperview()
                        transitionContext.completeTransition(true)
                        
                    })
                }
            }
        }
    }
}
