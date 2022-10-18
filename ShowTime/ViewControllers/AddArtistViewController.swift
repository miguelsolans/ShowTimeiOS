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
    
    var genrePicker: DataPickerView!
    
    let artistTextField = TextField(placeholder: "Artist Name");
    let saveButton = UIButton(type: .system);
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        self.genresViewModel.delegate = self;
        self.genresViewModel.getGenres();
        
        self.artistViewModel.delegate = self;
    }
    
    override func style() {
        self.title = NSLocalizedString("newArtist", comment: "Page title")
        
        self.genrePicker = DataPickerView(target: self, placeholder: "Genre")
        self.genrePicker.translatesAutoresizingMaskIntoConstraints = false;
        self.artistTextField.translatesAutoresizingMaskIntoConstraints = false;
        
        self.saveButton.setTitle(NSLocalizedString("save", comment: "Action title"), for: [])
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
            self.genrePicker.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8),
            self.genrePicker.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8),
            self.genrePicker.heightAnchor.constraint(equalToConstant: 55),
            
            self.artistTextField.topAnchor.constraint(equalTo: self.genrePicker.bottomAnchor, constant: 8),
            self.artistTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8),
            self.artistTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8),
            self.artistTextField.heightAnchor.constraint(equalToConstant: 55),
            
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
        
        if(self.isValidForm()) {
            if let selectedIndex = self.genrePicker.selectedIndex {
                
                if let genre = self.genresViewModel.getGenreByIndex(selectedIndex) {
                    let artist = ArtistInput(name: self.artistTextField.getText(), genreName: genre.subGenre);
                    self.artistViewModel.createArtist(artist)
                } else {
                    self.showAlertWithTitle(NSLocalizedString("error", comment: "Error Title"), andMessage: NSLocalizedString("invalidData", comment: "Error Description"));
                }
            } else {
                self.showAlertWithTitle(NSLocalizedString("error", comment: "Error Title"), andMessage: NSLocalizedString("genreMissingSelection", comment: "Missing Selection"));
            }
        } else {
            self.showAlertWithTitle("Error", andMessage: "Invalid data!");
        }
        
    }
    
}

// MARK: - Validations
extension AddArtistViewController {
    func validateArtistName() -> Bool {
        return !self.artistTextField.isEmtpy()
    }
    
    func isValidForm() -> Bool {
        return self.validateArtistName()
    }
}
