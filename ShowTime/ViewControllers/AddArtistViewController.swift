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
    let genericTableViewModel = GenericTableViewModel();
    
    var genrePicker: DataPickerView!
    var countryPicker: DataPickerView!
    
    let artistTextField = TextField(placeholder: "Artist Name");
    let saveButton = UIButton(type: .system);
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        
        self.genresViewModel.delegate = self;
        self.genresViewModel.getGenres();
        
        self.artistViewModel.delegate = self;
        self.genericTableViewModel.delegate = self;
        self.genericTableViewModel.getGenericTable(GenericTableConstants.Countries)
        
        
        self.startGenericLoading()
        
    }
    
    override func style() {
        self.title = NSLocalizedString("newArtist", comment: "Page title")
        
        self.genrePicker = DataPickerView(target: self, placeholder: "Genre", withSearchBar: true)
        self.genrePicker.translatesAutoresizingMaskIntoConstraints = false;
        
        self.countryPicker = DataPickerView(target: self, placeholder: "Countries", withSearchBar: true);
        self.countryPicker.translatesAutoresizingMaskIntoConstraints = false;
        
        self.artistTextField.translatesAutoresizingMaskIntoConstraints = false;
        
        self.saveButton.setTitle(NSLocalizedString("save", comment: "Action title"), for: [])
        self.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchDown);
        self.saveButton.translatesAutoresizingMaskIntoConstraints = false;
        self.saveButton.applyStyle();
        
    }
    
    
    
    override func layout() {
        
        self.view.addSubview(genrePicker);
        self.view.addSubview(countryPicker);
        self.view.addSubview(artistTextField);
        self.view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            
            self.genrePicker.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.genrePicker.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8),
            self.genrePicker.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8),
            self.genrePicker.heightAnchor.constraint(equalToConstant: 55),
            
            self.countryPicker.topAnchor.constraint(equalTo: self.genrePicker.bottomAnchor, constant: 8),
            self.countryPicker.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8),
            self.countryPicker.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8),
            self.countryPicker.heightAnchor.constraint(equalToConstant: 55),
            
            self.artistTextField.topAnchor.constraint(equalTo: self.countryPicker.bottomAnchor, constant: 8),
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
    func didSelectPicker(_ pickerView: DataPickerView, withOption option: DataPickerOption) {
        //
    }
}

// MARK: - Genres ViewModel Delegates
extension AddArtistViewController : GenresViewModelDelegate {
    func genresOutputDidChange(_ viewModel: GenresViewModel) {
        var options: [DataPickerOption] = [];
        
        if let safeGenres = viewModel.genresOutput {
            for genre in safeGenres {
                let option = DataPickerOption(id: genre.id, label: genre.subGenre);
                options.append(option)
            }
        }
        
        self.genrePicker.options = options;
        self.genrePicker.rootViewController = self;
        self.genrePicker.delegate = self;
        
        self.stopGenericLoading()
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

// MARK: - Generic Table ViewModel Delegate Methods
extension AddArtistViewController : GenericTableViewModelDelegate {
    func genericTableOutputDidChange(_ viewModel: GenericTableViewModel) {
        self.countryPicker.options = viewModel.convertOptionsToPicker();
        
        self.stopGenericLoading()
    }
}

// MARK: - Actions
extension AddArtistViewController {
    
    @objc func saveButtonTapped() {
        // Save Artist
        
        if(self.isValidForm()) {
            if let selectedGenre = self.genrePicker.selectedOption, let selectedCountry = self.countryPicker.selectedOption {
                let artist = ArtistInput(name: self.artistTextField.getText(), genreName: selectedGenre.label, country: selectedCountry.id);
                self.artistViewModel.createArtist(artist)
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

