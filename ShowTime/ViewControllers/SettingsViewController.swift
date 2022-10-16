//
//  SettingsViewController.swift
//  ShowTime
//
//  Created by Miguel Solans on 08/10/2022.
//

import UIKit

class SettingsViewController : BaseViewController {
    
    let tableView = UITableView();
    var settings = [
        MenuItem(option: NSLocalizedString("profile", comment: "Menu option label"), id: "profile", viewController: BaseViewController()),
        MenuItem(option: NSLocalizedString("security", comment: "Menu option label"), id: "security", viewController: BaseViewController()),
        MenuItem(option: NSLocalizedString("manageGenres", comment: "Menu option label"), id: "genres", viewController: ManageGenresViewController()),
        MenuItem(option: NSLocalizedString("manageVenues", comment: "Menu option label"), id: "venues", viewController: BaseViewController())
    ]
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        self.layout();
        self.style();
    }
    
    
    
    
    override func layout() {
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(self.tableView);
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        
        NSLayoutConstraint.activate([
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ]);
    }
    
    override func style() {
        
    }
    
}

extension SettingsViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settings.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = self.settings[ indexPath.row ].option;
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        
        let viewController = self.settings[ indexPath.row ].viewController
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
