//
//  DataPickerViewController.swift
//  ShowTime
//
//  Created by Miguel Solans on 12/07/2022.
//

import UIKit

protocol DataPickerViewControllerDelegate : AnyObject {
    func didSelectOption(_ option: String, atIndex: Int);
}

class DataPickerViewController: UIViewController {
    
    weak var delegate: DataPickerViewControllerDelegate?
    fileprivate let tableView = UITableView();
    let options: [String];

    init(options: [String]) {
        
        self.options = options
        super.init(nibName: nil, bundle: nil);
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupTable();
        self.style();
        self.layout();
    }
    
    func style() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    }
    
    func layout() {
        
        self.view.addSubview(self.tableView);
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]);
    }
    
    
    func setupTable() {
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    
}

extension DataPickerViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell();
        
        cell.textLabel?.text = self.options[ indexPath.row ];
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        
        self.delegate?.didSelectOption(self.options[ indexPath.row ], atIndex: indexPath.row)
        
    }
    
}

extension DataPickerViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.options.count
    }
    
}
