//
//  BaseViewController.swift
//  ShowTime
//
//  Created by Miguel Solans on 13/07/2022.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.style();
        self.layout();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.shouldHideBottomBar(false);
    }
    
    func style() { }
    
    func layout() { }
    
    func showAlertWithTitle(_ title : String, andMessage message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        
        let okAction = UIAlertAction(title: "Ok", style: .default);
        
        alert.addAction(okAction);
        
        self.present(alert, animated: true);
    }
    
    func shouldHideBottomBar(_ hidden: Bool) {
        
        guard let tabBarController = self.tabBarController else {
            return;
        }
        
        tabBarController.tabBar.isHidden = hidden;
        
    }
    
}
