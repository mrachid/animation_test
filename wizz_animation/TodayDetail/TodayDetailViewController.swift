//
//  TodayDetailViewController.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import UIKit

protocol TodayDetailDisplayLogic: AnyObject {
    func displayUserPhotos(_ userPhotos: [String])
    func displayStatisticsPhoto(_ statistics: Statistics)
    func displayError(_ error: NSError)
}

enum Constants {
    static let cellSpacing: CGFloat = 8
}

class TodayDetailViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.backgroundColor = .white
            closeButton.layer.cornerRadius = closeButton.frame.width / 2
        }
    }
    
    var interactor: TodayDetailBusinessLogic?
    var username: String?
    var photoAnimation: Photo?
    var userPhotos: [String] = []
    var statistics: Statistics?
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        registerCell()
        loadUserPhotos()
    }
    
    func registerCell() {
        collectionView.register(TodayDetailCollectionViewCell.nib, forCellWithReuseIdentifier: TodayDetailCollectionViewCell.reuseIdentifier)
        collectionView.register(TodayDetailFooterCollectionViewCell.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: TodayDetailFooterCollectionViewCell.reuseIdentifier)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        closeButton.alpha = 0
        UIView.animate(withDuration: 0.25, delay: 1,  animations: {
            self.closeButton.alpha = 1
        }, completion: nil)
    }
    
    func configure() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Constants.cellSpacing
        layout.minimumInteritemSpacing = Constants.cellSpacing
        
        collectionView.setCollectionViewLayout(layout, animated: false)
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: Do something
    
    func loadUserPhotos() {
        guard let username = username, let photoAnimation = photoAnimation else { return }
        interactor?.getUserPhotos(username, photoAnimation: photoAnimation)
    }
    
    @IBAction func closeTodayDetail(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension TodayDetailViewController: TodayDetailDisplayLogic {
    func displayUserPhotos(_ userPhotos: [String]) {
        self.userPhotos = userPhotos
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func displayStatisticsPhoto(_ statistics: Statistics) {
        self.statistics = statistics
        DispatchQueue.main.async {
            self.collectionView.visibleSupplementaryViews(ofKind: TodayDetailFooterCollectionViewCell.reuseIdentifier)
        }
    }
}

extension TodayDetailViewController: StoryboardInstantiable {
    static var storyboardName: String {
        return "TodayDetail"
    }
}

extension TodayDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayDetailCollectionViewCell.reuseIdentifier, for: indexPath) as! TodayDetailCollectionViewCell
        cell.configure(url: userPhotos[indexPath.row])
        
        return cell
    }
}

extension TodayDetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.bounds.width - Constants.cellSpacing) / 2
        return .init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TodayDetailFooterCollectionViewCell.reuseIdentifier, for: indexPath) as! TodayDetailFooterCollectionViewCell
            footerView.configure(statistics)
            return footerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 150)
    }
}
