//
//  TabBarViewController.swift
//  ShowTime
//
//  Created by Miguel Solans on 14/08/2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemBackground;
        UITabBar.appearance().barTintColor = .systemBackground;
        tabBar.tintColor = .label
        
        self.setupViewControllers();
    }
    
    func setupViewControllers() {
        viewControllers = [
            createNavController(for: ManageArtistsViewController(), title: NSLocalizedString("artists", comment: ""), image: UIImage(systemName: "house")!),
            createNavController(for: ConcertHistoryViewController(), title: NSLocalizedString("concerts", comment: ""), image: UIImage(systemName: "guitars")!),
            createNavController(for: SettingsViewController(), title: NSLocalizedString("settings", comment: ""), image: UIImage(systemName: "gear")!)
        ];
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController);
        navController.tabBarItem.title = title;
        navController.tabBarItem.image = image;
        navController.navigationBar.prefersLargeTitles = true;
        rootViewController.navigationItem.title = title;
        return navController;
    }

}
