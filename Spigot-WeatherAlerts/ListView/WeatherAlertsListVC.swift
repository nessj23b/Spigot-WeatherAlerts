//
//  ViewController.swift
//  Spigot-WeatherAlerts
//
//  Created by Birch, Nathan J on 7/15/21.
//

import UIKit

class WeatherAlertsListVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var collectionView: UICollectionView!
    let layout = UICollectionViewFlowLayout()
    
    var weatherAlerts: [WeatherAlert] = []
    var selectedCell: WeatherAlert?
    
    var randomImageView = UIImageView()
        
    // makes it so that we dont' have to retype this string a lot (minimizes spelling errors)
    struct Cells {
        static let weatherAlertCell = "WeatherAlertCell"
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather Alerts ⚡️"
        view.backgroundColor = UIColor(named: "background")
        configureFlowLayout()
        configureCollectionView()
        getWeatherAlerts()
    }

    
    // setup for collection view cell size and spacing
    func configureFlowLayout() {
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: view.bounds.width-40, height: 80)
        layout.minimumLineSpacing = 20;
    }
    
    
    // setup for collection view, where to look for data, type of cells, etc.
    func configureCollectionView() {
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        view.addSubview(collectionView ?? UICollectionView())
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(WeatherAlertCell.self, forCellWithReuseIdentifier: Cells.weatherAlertCell)
        collectionView?.backgroundColor = .clear
    }

    
    // fetching and loading data on success, handling errors on failiure
    func getWeatherAlerts() {
        NetworkManager.shared.getWeatherAlerts() { [weak self] (result) in
            // instead of making all self calls below optionals, we unwrap self here to ensure it has a value (makes for cleaner code)
            guard let self = self else { return }
            switch result {
            // if we succeed in our network call...
            case .success(let weatherAlerts):
                DispatchQueue.main.async {
                    self.weatherAlerts = weatherAlerts
                    self.collectionView.reloadData()
                }
            // if we fail in our network call...
            case .failure(let error):
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    // adding visual effects to each cell
    func configureCell(_ cell: UICollectionViewCell) {
        cell.backgroundColor = UIColor(named: "cell")
        cell.layer.cornerRadius = 5.0
        cell.contentView.layer.cornerRadius = 5.0
        cell.layer.shadowColor = UIColor(named: "shadow")?.cgColor
        cell.layer.shadowOffset = CGSize(width: 1, height: 2.0)
        cell.layer.shadowRadius = 5.0
        cell.layer.shadowOpacity = 1.5
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    }
    
    
    // handles tap gesture --> presents detailed view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCell = weatherAlerts[indexPath.row]
        let destVC = WeatherAlertDetailVC(weatherAlert: selectedCell!, randomImageView: randomImageView)
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
    
    // handles size of collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherAlerts.count
    }
    
    
    // configures cells and injects with weatherAlert data
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.weatherAlertCell, for: indexPath) as! WeatherAlertCell
        configureCell(cell)
        let weatherAlert = weatherAlerts[indexPath.row]
        cell.set(weatherAlert: weatherAlert, indexPath: indexPath)
        
        // ***** this (below) line passes AN image to the detail view, but not the selected cell's image *****
        // ***** and also produces a layout/styling bug on some of the cells in the WAListVC after going to the detailVC and back. *****
        // ***** when it's commented out, there is no bug, but no image is passed... *****
        
        //self.randomImageView = cell.randomImageView
        return cell
    }
}
