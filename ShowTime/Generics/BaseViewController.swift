//
//  BaseViewController.swift
//  ShowTime
//
//  Created by Miguel Solans on 13/07/2022.
//

import UIKit

class BaseViewController: UIViewController {
    
    fileprivate var loaderAlert: UIAlertController!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view
        self.view.backgroundColor = .white;
        self.initGenericLoading();
        self.style();
        self.layout();
    }
    
    func style() { }
    
    func layout() { }
    
    fileprivate func initGenericLoading() {
        self.loaderAlert = UIAlertController(title: nil, message: "Loading...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating();

        self.loaderAlert.view.addSubview(loadingIndicator);
    }
    
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
    
    func startGenericLoading() {
        self.present(self.loaderAlert, animated: true);
    }
    
    func stopGenericLoading() {
        self.loaderAlert.dismiss(animated: true)
    }
}
