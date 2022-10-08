//
//  GenresViewController.swift
//  ShowTime
//
//  Created by Miguel Solans on 14/08/2022.
//

import UIKit

class ManageGenresViewController : BaseViewController {
    
    let genresViewModel = GenresViewModel();
    let tableView = UITableView();
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.genresViewModel.delegate = self;
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.genresViewModel.getGenres();
    }
    
    override func style() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false;
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addGenreButtonTapped))
        navigationItem.setRightBarButton(addButton, animated: true);
        
        self.title = "Manage Genres";
    }
    
    override func layout() {
        
        self.view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ]);
    }
    
    
}

extension ManageGenresViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell();
        
        let genre = self.genresViewModel.genresOutput![ indexPath.row ];
        cell.textLabel?.text = genre.subGenre
        
        return cell;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.genresViewModel.genresOutput?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete) {
            
        }
    }
}


extension ManageGenresViewController : GenresViewModelDelegate {
    func genresOutputDidChange(_ viewModel: GenresViewModel) {
        self.tableView.reloadData();
    }
    
    func genresErrorDidChange(_ viewModel: GenresViewModel) {
        
    }
}


extension ManageGenresViewController {
    @objc func addGenreButtonTapped() {
        
    }
}
