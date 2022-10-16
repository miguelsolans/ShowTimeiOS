//
//  AddConcertViewController.swift
//  ShowTime
//
//  Created by Miguel Solans on 13/10/2022.
//

import UIKit

class AddConcertViewController : BaseViewController {
    
    let artistsViewModel = ArtistsViewModel();
    let venuesViewModel = VenueViewModel();
    let concertViewModel = ConcertViewModel();
    
    let formStackView = UIStackView();
    
    let artistPickerView = DataPickerView();
    let venuePickerView = DataPickerView();
    let datePickerView = DatePicker();
    
    let saveButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        datePickerView.initPicker(withLabel: "Concert Date");
        
        
        self.artistsViewModel.delegate = self;
        self.artistsViewModel.getArtists();
        
        self.venuesViewModel.delegate = self;
        self.venuesViewModel.getAll();
        
        self.concertViewModel.delegate = self;
    }
    
    
    override func style() {
        
        self.formStackView.translatesAutoresizingMaskIntoConstraints = false;
        self.formStackView.axis = .vertical;
        self.formStackView.distribution = .equalSpacing
        self.formStackView.spacing = 10;
        
        // Form elements
        self.artistPickerView.translatesAutoresizingMaskIntoConstraints = false;
        self.venuePickerView.translatesAutoresizingMaskIntoConstraints = false;
        self.datePickerView.translatesAutoresizingMaskIntoConstraints = false;
        
        // Save Button
        self.saveButton.translatesAutoresizingMaskIntoConstraints = false;
        self.saveButton.setTitle("Save", for: []);
        self.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchDown)
        self.saveButton.applyStyle();
    }
    
    override func layout() {
        
        self.view.addSubview(formStackView);
        self.view.addSubview(saveButton)
        
        formStackView.addArrangedSubview(artistPickerView);
        formStackView.addArrangedSubview(venuePickerView);
        formStackView.addArrangedSubview(datePickerView);
        
        NSLayoutConstraint.activate([
            self.formStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.formStackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8),
            self.formStackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8),
            self.formStackView.bottomAnchor.constraint(equalTo: self.saveButton.topAnchor),
            
            self.saveButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.saveButton.heightAnchor.constraint(equalToConstant: 50),
            self.saveButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.saveButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16)
            
        ]);
    }
    
}


extension AddConcertViewController {
    @objc func saveButtonTapped() {
        
        if let artistIndex = self.artistPickerView.selectedIndex, let venueIndex = self.venuePickerView.selectedIndex {
            
            if let artist = self.artistsViewModel.getArtistByIndex(artistIndex), let venue = self.venuesViewModel.getVenueByIndex(venueIndex) {
                let concert = ConcertInput(artistName: artist.name,
                                           date: self.datePickerView.getFormattedDate(),
                                           venueId: venue.id);
                
                self.concertViewModel.addNew(concert: concert);
            }
            
        } else {
            self.showAlertWithTitle("Error", andMessage: "Invalid input data!")
        }
    }
}


// MARK: - ViewModel Delegate Methods
extension AddConcertViewController : ArtistsViewModelDelegate {
    func artistsOutputDidChange(_ viewModel: ArtistsViewModel) {
        print("ViewModel - Artists Output didChange");
        
        var options: [String] = [];
        
        if let safeArtists = viewModel.artistsOutput {
            for artist in safeArtists {
                options.append(artist.name)
            }
        }
        
        self.artistPickerView.options = options;
        self.artistPickerView.rootViewController = self;
        // self.artistPickerView.delegate = self;
    }
    
    func artistsErrorDidChange(_ viewModel: ArtistsViewModel) {
        
    }
    
    func artistOutputDidChange(_ viewModel: ArtistsViewModel) {
        
    }
    
    func artistErrorDidChange(_ viewModel: ArtistsViewModel) {
        
    }
    
}


extension AddConcertViewController : VenueViewModelDelegate {
    func venuesOutputDidChange(_ viewModel: VenueViewModel) {
        print("ViewModel - Venues Output didChange");
        
        var options: [String] = [];
        
        if let safeVenues = viewModel.venuesOutput {
            for venue in safeVenues {
                options.append(venue.name)
            }
        }
        
        self.venuePickerView.options = options;
        self.venuePickerView.rootViewController = self;
        
    }
}

extension AddConcertViewController : ConcertViewModelDelegate {
    func concertsOutputDidChange(_ viewModel: ConcertViewModel) { }
    
    func concertOutputDidChange(_ viewModel: ConcertViewModel) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
