//
//  DataPickerViewController.swift
//  ShowTime
//
//  Created by Miguel Solans on 12/07/2022.
//

import UIKit

protocol DataPickerViewControllerDelegate : AnyObject {
    func didSelectOption(_ option: DataPickerOption);
}

class DataPickerViewController: UIViewController {
    
    weak var delegate: DataPickerViewControllerDelegate?
    fileprivate var searching = false;
    
    fileprivate let tableView = UITableView();
    fileprivate let searchBar = UISearchBar();
    
    let options: [DataPickerOption];
    let pickerWithSearch : Bool;
    fileprivate var searchResults = [DataPickerOption]();
    
    init(options: [DataPickerOption], andSearch search: Bool) {
        self.pickerWithSearch = search;
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
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false;
    }
    
    func layout() {
        
        self.view.addSubview(self.tableView);
        if(self.pickerWithSearch) {
            self.view.addSubview(self.searchBar);
            
            NSLayoutConstraint.activate([
                self.searchBar.topAnchor.constraint(equalTo: self.view.topAnchor),
                self.searchBar.leftAnchor.constraint(equalTo: self.view.leftAnchor),
                self.searchBar.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            ]);
        }
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.pickerWithSearch ? self.searchBar.bottomAnchor : self.view.topAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]);
    }
    
    
    func setupTable() {
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.searchBar.delegate = self;
    }
    
}

extension DataPickerViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell();
        
        cell.textLabel?.text = self.searching ? self.searchResults[indexPath.row].label : self.options[ indexPath.row ].label;
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        
        self.delegate?.didSelectOption(self.searching ? self.searchResults[ indexPath.row ] : self.options[ indexPath.row ]);
        
    }
    
}

extension DataPickerViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searching ? self.searchResults.count : self.options.count;
    }
    
}

extension DataPickerViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searching = true;
        
        self.searchResults = self.options.filter() { $0.label.lowercased().contains(searchText.lowercased()) };
        
        
        self.tableView.reloadData();
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searching = false;
        self.searchBar.text = "";
        self.tableView.reloadData();
    }
}
