//
//  ViewController.swift
//  ShowTime
//
//  Created by Miguel Solans on 12/07/2022.
//

import UIKit

class ManageArtistsViewController: BaseViewController {
    

    let genresViewModel = GenresViewModel();
    let artistsViewModel = ArtistsViewModel();
    var pickerView: DataPickerView!;
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        self.pickerView = DataPickerView(target: self, placeholder: "Genre")
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        self.artistsViewModel.delegate = self;
        self.genresViewModel.delegate = self;
        self.genresViewModel.getGenres();
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.title = NSLocalizedString("manageArtists", comment: "Page Title")
        
    }

    
    override func style() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false;
        self.pickerView.translatesAutoresizingMaskIntoConstraints = false;
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addArtistButtonTapped))
        navigationItem.setRightBarButton(addButton, animated: true);
    }
    
    override func layout() {
        self.view.addSubview(self.tableView);
        self.view.addSubview(self.pickerView);
        
        
        NSLayoutConstraint.activate([
            self.pickerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.pickerView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 8),
            self.pickerView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -8),
            self.pickerView.heightAnchor.constraint(equalToConstant: 55),
            
            self.tableView.topAnchor.constraint(equalTo: self.pickerView.bottomAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ]);
    }

}


extension ManageArtistsViewController : GenresViewModelDelegate {
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

extension ManageArtistsViewController : ArtistsViewModelDelegate {
    func artistOutputDidChange(_ viewModel: ArtistsViewModel) {
        
    }
    
    func artistErrorDidChange(_ viewModel: ArtistsViewModel) {
        
    }
    
    func artistsErrorDidChange(_ viewModel: ArtistsViewModel) {
        
    }
    
    func artistsOutputDidChange(_ viewModel: ArtistsViewModel) {
        self.tableView.reloadData();
    }
}


extension ManageArtistsViewController : DataPickerViewDelegate {
    func didSelectPicker(_ pickerView: DataPickerView, withOption option: String) {
        self.artistsViewModel.getArtistsByGenre(option);
    }
}


extension ManageArtistsViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.artistsViewModel.artistsOutput?.count ?? 0;
    }
}
extension ManageArtistsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell();
        
        cell.textLabel?.text = self.artistsViewModel.artistsOutput?[ indexPath.row ].name
        
        return cell;
    }
}

extension ManageArtistsViewController {
    @objc func addArtistButtonTapped() {
        let addArtistViewController = AddArtistViewController();
        
        self.pushToViewController(addArtistViewController);
    }
}
