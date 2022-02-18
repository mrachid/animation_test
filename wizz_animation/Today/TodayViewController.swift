//
//  TodayViewController.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import UIKit

var imgs = ["file1", "file2", "file3", "file4", "file5", "file6"]

protocol TodayDisplayLogic: AnyObject {
    func displayPhoto(_ photos: [Photo])
    func displayError(_ error: NSError)
}

class TodayViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: TodayBusinessLogic?
    var selectedCell: TodayTableViewCell?
    var animator: Animator?
    var imageNamed: String?
    var photos: [Photo] = []
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        configure()
        loadPhotos()
    }
    
    // MARK: Setup
    
    func registerCell() {
        tableView.register(TodayTableViewCell.nib, forCellReuseIdentifier: TodayTableViewCell.reuseIdentifier)
        tableView.register(TodayHeaderTableViewCell.nib, forCellReuseIdentifier: TodayHeaderTableViewCell.reuseIdentifier)
    }
    
    func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        navigationController?.isNavigationBarHidden = true
    }
    
    func loadPhotos() {
        interactor?.loadPhotos()
    }
}

extension TodayViewController: TodayDisplayLogic {
    func displayPhoto(_ photos: [Photo]) {
        DispatchQueue.main.async {
            self.photos = photos
            self.tableView.reloadData()
        }
    }
}

extension TodayViewController: StoryboardInstantiable {
    static var storyboardName: String {
        return "Today"
    }
}

extension TodayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0){
            return 1
        }
        return photos.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            return tableView.dequeueReusableCell(withIdentifier: TodayHeaderTableViewCell.reuseIdentifier, for: indexPath) as! TodayHeaderTableViewCell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TodayTableViewCell.reuseIdentifier, for: indexPath) as! TodayTableViewCell
        
        cell.configure(photo: photos[indexPath.row])
        
        return cell
    }
    
}

extension TodayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = tableView.cellForRow(at: indexPath) as? TodayTableViewCell
        let photo = photos[indexPath.row]
        imageNamed = photo.urls?.image
        
        interactor?.goDetailAction(username: photo.user.username, photoAnimation: photo, transitionDelegate: self)
    }
}

extension TodayViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let navigation = presenting as? UINavigationController,
              let tabbarController = navigation.viewControllers.first as? HomeTabBarViewController,
              let todayViewController = tabbarController.viewControllers?.first as? TodayViewController,
              let todayDetailViewController = presented as? TodayDetailViewController,
              let imageNamed = imageNamed
        else {
            return nil
            
        }
        
        return Animator(todayViewController: todayViewController, todayDetailViewController: todayDetailViewController, imageNamed: imageNamed)
    }
}
