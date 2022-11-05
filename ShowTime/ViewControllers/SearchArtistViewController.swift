//
//  SearchArtistViewController.swift
//  ShowTime
//
//  Created by Miguel Solans on 01/11/2022.
//

import UIKit
import SDWebImage

private enum LayoutConstant {
    static let spacing: CGFloat = 1.0
    static let itemHeight: CGFloat = 150.0
}

class SearchArtistViewController : BaseViewController {
    
    let viewModel = SpotifySearchViewModel()
    
    fileprivate let cellIdentifier = "ArtistCell";
    fileprivate let searchBar = UISearchBar()
    fileprivate let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }();
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.viewModel.delegate = self;
        self.searchBar.delegate = self;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
    }
    
    override func style() {
        
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false;
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false;
        
        self.collectionView.register(ImageWithTitleViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        
    }
    
    override func layout() {
        
        self.view.addSubview(searchBar)
        self.view.addSubview(collectionView);
        
        NSLayoutConstraint.activate([
            self.searchBar.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.searchBar.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.searchBar.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            
            self.collectionView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ]);
        
    }
}

extension SearchArtistViewController : UICollectionViewDelegateFlowLayout {
    // Item Size
    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 2
        
        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        
        return finalWidth - 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: view.frame.width, spacing: 0)

        return CGSize(width: width, height: LayoutConstant.itemHeight)
    }
    
    // Spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: LayoutConstant.spacing, left: LayoutConstant.spacing, bottom: LayoutConstant.spacing, right: LayoutConstant.spacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstant.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstant.spacing
    }
    
}

extension SearchArtistViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    // Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.spotifySearchOutput?.artists.items.count ?? 0;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ImageWithTitleViewCell;
        
        guard let artist = self.viewModel.spotifySearchOutput?.artists.items[ indexPath.row ] else { return ImageWithTitleViewCell() }
        
        
        cell.titleLabel.text = artist.name
        
        if(artist.images.count > 0) {
            let url = URL(string: artist.images[ 0 ].url);
            cell.imageView.sd_setImage(with: url)
            // cell.imageView.image = UIImage(data: data!)
            
        } else {
            // TODO: Default Image
        }
        
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


extension SearchArtistViewController : SpotifySearchViewModelDelegate {
    func spotifySearchOutputDidChange(_ viewModel: SpotifySearchViewModel) {
        self.collectionView.reloadData();
    }
}


extension SearchArtistViewController : UISearchBarDelegate {
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return; }
        
        
        self.viewModel.search(artist: searchText);
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return; }
        
        
        self.viewModel.search(artist: searchText);
    }
}
