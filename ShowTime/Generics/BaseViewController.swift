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

        // Do any additional setup after loading the view
        self.view.backgroundColor = .white;
        self.style();
        self.layout();
    }
    
    func style() { }
    
    func layout() { }
    
    func showAlertWithTitle(_ title : String, andMessage message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        
        let okAction = UIAlertAction(title: "Ok", style: .default);
        
        alert.addAction(okAction);
        
        self.present(alert, animated: true);
    }
    
    func pushToViewController(_ viewController: BaseViewController) {
        
        viewController.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(viewController, animated: true);
    }
    
}
