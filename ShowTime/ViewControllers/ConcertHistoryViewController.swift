//
//  ConcertHistoryViewController.swift
//  ShowTime
//
//  Created by Miguel Solans on 08/10/2022.
//

import UIKit

fileprivate enum SegmentedOption : Int, CaseIterable {
    case past = 0
    case schedule = 1
    var description: String {
        switch self {
        case .past: return NSLocalizedString("pastEvent", comment: "")
        case .schedule: return NSLocalizedString("scheduledEvent", comment: "")
        }
    }
}

class ConcertHistoryViewController : BaseViewController {
    
    fileprivate let reusableIdentifier = "ConcertCell"
    
    let concertViewModel = ConcertViewModel()
    let titleLabel = UILabel();
    let segmentedControl = UISegmentedControl(items: SegmentedOption.allCases.map { $0.description.capitalized })
    let tableView = UITableView();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTable();
        
        self.startGenericLoading();
        self.concertViewModel.delegate = self;
        self.concertViewModel.getPastConcerts();
        
        self.segmentedControl.selectedSegmentIndex = SegmentedOption.past.rawValue;
        self.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged);
        self.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .touchUpInside);
        
        
    }
    
    func setupTable() {
        self.tableView.register(TwoLabelTableViewCell.self, forCellReuseIdentifier: "ConcertCell");
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false;
        self.tableView.rowHeight = 80;
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    
    override func layout() {
        
        self.view.addSubview(segmentedControl);
        self.view.addSubview(tableView);
        
        NSLayoutConstraint.activate([
            
            self.segmentedControl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.segmentedControl.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 8),
            self.segmentedControl.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -8),
            
            self.tableView.topAnchor.constraint(equalTo: self.segmentedControl.bottomAnchor, constant: 8),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
            
        ]);
    }
    
    override func style() {
        
        self.segmentedControl.translatesAutoresizingMaskIntoConstraints = false;
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addConcertButtonTapped));
        navigationItem.setRightBarButton(addButton, animated: true);
        
    }
    
}

extension ConcertHistoryViewController : ConcertViewModelDelegate {
    func concertsOutputDidChange(_ viewModel: ConcertViewModel) {
        self.tableView.reloadData();
        self.stopGenericLoading()
    }
    
    func concertOutputDidChange(_ viewModel: ConcertViewModel) {
        
    }
    
}

extension ConcertHistoryViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.concertViewModel.numberOfConcerts();
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.concertViewModel.numberOfRowsForSection(section);
        
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return self.concertViewModel.titleForSection(section);
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as? TwoLabelTableViewCell else { return UITableViewCell() }
        
        if let concert = self.concertViewModel.concertForSection(indexPath.section, andIndex: indexPath.row) {
            cell.titleLabel.text = concert.artist.name;
            cell.titleImageView.image = UIImage(systemName: "person.fill");
            cell.subtitleLabel.text = concert.artist.genreName;
            cell.subtitleImageView.image = UIImage(systemName: "music.note.list");
        }
        
        return cell;
    }
    
}

extension ConcertHistoryViewController {
    @objc func addConcertButtonTapped() {
        let viewController = AddConcertViewController();
        self.pushToViewController(viewController);
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0) {
            self.concertViewModel.getPastConcerts();
        } else {
            self.concertViewModel.getScheduled();
        }
    }
}


