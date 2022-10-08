//
//  ViewController.swift
//  ShowTime
//
//  Created by Miguel Solans on 12/07/2022.
//

import UIKit

class ViewController: BaseViewController {
    

    let genresViewModel = GenresViewModel();
    let artistsViewModel = ArtistsViewModel();
    let pickerView = DataPickerView();
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.artistsViewModel.delegate = self;
        self.genresViewModel.delegate = self;
        self.genresViewModel.getGenres();
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
    }

    
    override func style() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    }
    
    override func layout() {
        self.view.addSubview(self.tableView);
        self.view.addSubview(self.pickerView);
        
        
        NSLayoutConstraint.activate([
            self.pickerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.pickerView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            self.pickerView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            self.pickerView.heightAnchor.constraint(equalToConstant: 40),
            
            self.tableView.topAnchor.constraint(equalTo: self.pickerView.bottomAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]);
    }

}


extension ViewController : GenresViewModelDelegate {
    func genresOutputDidChange(_ viewModel: GenresViewModel) {
        print("ViewModel - Genres Output didChange");
        
        var options: [String] = [];
        
        if let safeGenres = viewModel.genresOutput {
            for genre in safeGenres {
                options.append(genre.subGenre)
            }
        }
        
        self.pickerView.options = options;
        self.pickerView.rootViewController = self;
        self.pickerView.delegate = self;
    }
    
    func genresErrorDidChange(_ viewModel: GenresViewModel) {
        
    }
}

extension ViewController : ArtistsViewModelDelegate {
    func artistsErrorDidChange(_ viewModel: ArtistsViewModel) {
        
    }
    
    func artistsOutputDidChange(_ viewModel: ArtistsViewModel) {
        self.tableView.reloadData();
    }
}


extension ViewController : DataPickerViewDelegate {
    func didSelectPicker(_ pickerView: DataPickerView, withOption option: String) {
        self.artistsViewModel.getArtistsByGenre(option);
    }
}


extension ViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.artistsViewModel.artistsOutput?.count ?? 0;
    }
}
extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell();
        
        cell.textLabel?.text = self.artistsViewModel.artistsOutput?[ indexPath.row ].name
        
        return cell;
    }
}
