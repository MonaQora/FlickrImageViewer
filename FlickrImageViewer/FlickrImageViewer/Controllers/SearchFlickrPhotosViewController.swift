//
//  SearchFlickrPhotosViewController.swift
//  FlickrImageViewer
//
//  Created by Mona Qora on 11/2/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import UIKit
import Kingfisher

class SearchFlickrPhotosViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var chooseListTypeButton: UIButton!

    private var searchFlickrViewModel = SearchFlickrPhotosViewModel()
    private let reuseIdentifier = "FlickrCell"
    private var itemsPerRow: CGFloat = 3

    override func viewDidLoad() {
      super.viewDidLoad()
        searchBar.delegate = self
        collectionView.delegate = self
        chooseListTypeButton.addTarget(self, action: #selector(chooseListType), for: .touchUpInside)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Flicker Search"
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(!(searchBar.text?.isEmpty)!){
            // set activity indicator on search bar
            let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
            searchBar.addSubview(activityIndicator)
            activityIndicator.frame = searchBar.bounds
            activityIndicator.startAnimating()
            searchBar.resignFirstResponder()
            
            searchFlickrViewModel.getListOfPhotots(searchKey: searchBar.text!, completionHandler: { errorMessage in
                if let errorMsg = errorMessage {
                    
                }
                else {
                    self.collectionView?.reloadData()
                }
                activityIndicator.removeFromSuperview()
                searchBar.text = nil
            })
        }
    }
    
    
    @objc func chooseListType(sender: UIButton!) {
        if itemsPerRow == 3 {
            chooseListTypeButton.setTitle("Grid", for: .normal)
            itemsPerRow = 1
        }
        else {
            chooseListTypeButton.setTitle("List", for: .normal)
            itemsPerRow = 3
        }
        self.collectionView.reloadData()
    }
}

extension SearchFlickrPhotosViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    return searchFlickrViewModel.searchResults?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                  for: indexPath) as! FlickrPhotoCell
    cell.backgroundColor = .white
    let flickrPhoto = searchFlickrViewModel.searchResults![indexPath.row]
    cell.imageView.kf.indicatorType = .activity
    cell.imageView.kf.setImage(with: flickrPhoto.photoSmallUrl)
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "PhotoDetailsViewController") as! PhotoDetailsViewController
    viewController.photoItem = searchFlickrViewModel.searchResults![indexPath.row]
    self.navigationController?.pushViewController(viewController, animated: true)
  }
}

// MARK: - Collection View Flow Layout Delegate
extension SearchFlickrPhotosViewController : UICollectionViewDelegateFlowLayout {
    
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let availableWidth = view.frame.width - 4
    let widthPerItem = availableWidth / itemsPerRow
    return CGSize(width: widthPerItem, height: widthPerItem)
  }
    
}
