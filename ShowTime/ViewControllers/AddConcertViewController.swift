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
    
    var artistPickerView: DataPickerView!;
    var venuePickerView: DataPickerView!;
    let datePickerView = DatePicker();
    let notesTextField = TextField(placeholder: "Additional Notes")
    
    let saveButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        self.datePickerView.initPicker(withLabel: NSLocalizedString("concertDate", comment: "Picker Placeholder"));
        self.artistPickerView = DataPickerView(target: self, placeholder: "Artist", withSearchBar: true);
        self.venuePickerView = DataPickerView(target: self, placeholder: "Venue", withSearchBar: true);
        
        super.viewDidLoad();
        
        self.artistsViewModel.delegate = self;
        self.artistsViewModel.getArtists();
        
        self.venuesViewModel.delegate = self;
        self.venuesViewModel.getAll();
        
        self.concertViewModel.delegate = self;
    }
    
    
    override func style() {
        
        // Form elements
        self.artistPickerView.translatesAutoresizingMaskIntoConstraints = false;
        self.venuePickerView.translatesAutoresizingMaskIntoConstraints = false;
        self.datePickerView.translatesAutoresizingMaskIntoConstraints = false;
        self.notesTextField.translatesAutoresizingMaskIntoConstraints = false;
        
        // Save Button
        self.saveButton.translatesAutoresizingMaskIntoConstraints = false;
        self.saveButton.setTitle(NSLocalizedString("save", comment: "Action Title"), for: []);
        self.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchDown)
        self.saveButton.applyStyle();
    }
    
    override func layout() {
        
        self.view.addSubview(artistPickerView);
        self.view.addSubview(venuePickerView);
        self.view.addSubview(datePickerView);
        self.view.addSubview(notesTextField);
        self.view.addSubview(saveButton)
        
        
        NSLayoutConstraint.activate([
            self.artistPickerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.artistPickerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8),
            self.artistPickerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8),
            self.artistPickerView.heightAnchor.constraint(equalToConstant: 55),
            
            self.venuePickerView.topAnchor.constraint(equalTo: self.artistPickerView.bottomAnchor, constant: 8),
            self.venuePickerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8),
            self.venuePickerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8),
            self.venuePickerView.heightAnchor.constraint(equalToConstant: 55),
            
            self.datePickerView.topAnchor.constraint(equalTo: self.venuePickerView.bottomAnchor, constant: 8),
            self.datePickerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8),
            self.datePickerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8),
            
            self.notesTextField.topAnchor.constraint(equalTo: self.datePickerView.bottomAnchor, constant: 8),
            self.notesTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8),
            self.notesTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8),
            self.notesTextField.heightAnchor.constraint(equalToConstant: 55),
            
            self.saveButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.saveButton.heightAnchor.constraint(equalToConstant: 50),
            self.saveButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.saveButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16)
            
        ]);
    }
    
}


extension AddConcertViewController {
    @objc func saveButtonTapped() {
        
        if let selectedArtist = self.artistPickerView.selectedOption, let selectedVenue = self.venuePickerView.selectedOption {
            let concert = ConcertInput(artistName: selectedArtist.label,
                                       date: self.datePickerView.getFormattedDate(),
                                       venueId: selectedVenue.id,
                                       notes: self.notesTextField.getText());
            
            self.concertViewModel.addNew(concert: concert);
            
        } else {
            self.showAlertWithTitle(NSLocalizedString("error", comment: "Error Title"), andMessage: NSLocalizedString("invalidData", comment: "Invalid Data"))
        }
    }
}


// MARK: - ViewModel Delegate Methods
extension AddConcertViewController : ArtistsViewModelDelegate {
    func artistsOutputDidChange(_ viewModel: ArtistsViewModel) {
        print("ViewModel - Artists Output didChange");
        
        var options: [DataPickerOption] = [];
        
        if let safeArtists = viewModel.artistsOutput {
            for artist in safeArtists {
                let option = DataPickerOption(id: artist.id, label: artist.name)
                options.append(option)
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
        
        var options: [DataPickerOption] = [];
        
        if let safeVenues = viewModel.venuesOutput {
            for venue in safeVenues {
                let option = DataPickerOption(id: venue.id, label: venue.name)
                options.append(option)
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
