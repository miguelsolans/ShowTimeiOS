//
//  AddArtistViewController.swift
//  ShowTime
//
//  Created by Miguel Solans on 09/10/2022.
//

import Foundation
import UIKit

class AddArtistViewController : BaseViewController {
    
    let genresViewModel = GenresViewModel();
    let artistViewModel = ArtistsViewModel();
    
    let genrePicker = DataPickerView();
    let artistTextField = UITextField();
    let saveButton = UIButton(type: .system);
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        self.shouldHideBottomBar(true);
        
        self.genresViewModel.delegate = self;
        self.genresViewModel.getGenres();
        
        self.artistViewModel.delegate = self;
    }
    
    override func style() {
        self.title = "New Artist";
        
        self.genrePicker.translatesAutoresizingMaskIntoConstraints = false;
        self.artistTextField.translatesAutoresizingMaskIntoConstraints = false;
        artistTextField.placeholder = "Artist Name";
        
        self.saveButton.setTitle("Save", for: [])
        self.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchDown);
        self.saveButton.translatesAutoresizingMaskIntoConstraints = false;
        self.saveButton.applyStyle();
        
    }
    
    
    
    override func layout() {
        
        self.view.addSubview(genrePicker);
        self.view.addSubview(artistTextField);
        self.view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            
            self.genrePicker.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.genrePicker.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.genrePicker.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.genrePicker.heightAnchor.constraint(equalToConstant: 40),
            
            self.artistTextField.topAnchor.constraint(equalTo: self.genrePicker.bottomAnchor, constant: 8),
            self.artistTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.artistTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.artistTextField.heightAnchor.constraint(equalToConstant: 40),
            
            self.saveButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.saveButton.heightAnchor.constraint(equalToConstant: 50),
            self.saveButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.saveButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16)
        ]);
        
    }
    
}

// MARK: - Picker Delegate Methods
extension AddArtistViewController : DataPickerViewDelegate {
    func didSelectPicker(_ pickerView: DataPickerView, withOption option: String) {
        //
    }
}

// MARK: - Genres ViewModel Delegates
extension AddArtistViewController : GenresViewModelDelegate {
    func genresOutputDidChange(_ viewModel: GenresViewModel) {
        var options: [String] = [];
        
        if let safeGenres = viewModel.genresOutput {
            for genre in safeGenres {
                options.append(genre.subGenre)
            }
        }
        
        self.genrePicker.options = options;
        self.genrePicker.rootViewController = self;
        self.genrePicker.delegate = self;
    }
    
    func genresErrorDidChange(_ viewModel: GenresViewModel) {
        // TODO: Handle Error
    }
}

extension AddArtistViewController : ArtistsViewModelDelegate {
    func artistsOutputDidChange(_ viewModel: ArtistsViewModel) {
        
    }
    
    func artistsErrorDidChange(_ viewModel: ArtistsViewModel) {
        // TODO: Handle Error
    }
    
    func artistOutputDidChange(_ viewModel: ArtistsViewModel) {
        self.navigationController?.popViewController(animated: true);
    }
    
    func artistErrorDidChange(_ viewModel: ArtistsViewModel) {
        // TODO: Handle Error
    }
    
    
}

// MARK: - Actions
extension AddArtistViewController {
    
    @objc func saveButtonTapped() {
        // Save Artist
        if let selectedIndex = self.genrePicker.selectedIndex {
            
            if let genre = self.genresViewModel.getGenreByIndex(selectedIndex), let artistName = self.artistTextField.text {
                let artist = ArtistInput(name: artistName, genreName: genre.subGenre);
                self.artistViewModel.createArtist(artist)
            } else {
                self.showAlertWithTitle("Error", andMessage: "The inserted data is incorrect!");
            }
        } else {
            self.showAlertWithTitle("Error", andMessage: "No genres have been selected!");
        }
        
    }
    
}
