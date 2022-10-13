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
            createNavController(for: ManageArtistsViewController(), title: "Bands", image: UIImage(systemName: "house")!),
            createNavController(for: ConcertHistoryViewController(), title: "Concerts", image: UIImage(systemName: "guitars")!),
            createNavController(for: SettingsViewController(), title: "Settings", image: UIImage(systemName: "gear")!)
            // createNavController(for: GenresViewController(), title: "Settings", image: UIImage(systemName: "gear")!)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
