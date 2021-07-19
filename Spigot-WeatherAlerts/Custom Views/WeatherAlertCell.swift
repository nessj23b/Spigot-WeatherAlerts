//
//  WeatherAlertCell.swift
//  Spigot-WeatherAlerts
//
//  Created by Birch, Nathan J on 7/15/21.
//

import UIKit

// for formatting the custom cell layouts
class WeatherAlertCell: UICollectionViewCell {
    
    private var randomImageURL = "https://picsum.photos/200"
    
    let placeHolderImage = UIImage(named: "placeholderImage")
    
    var downloadedImages = [IndexPath: UIImage]()
    
    // data displayed in each cell
    let event = UILabel()
    let period = UILabel()
    let source = UILabel()
    
    var randomImageView = UIImageView()
    
    let monthDayYearFormatter = DateFormatter()
    
    var cellIndexPath = IndexPath()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        configureEvent()
        configurePeriod()
        configureSource()
        
        setImageConstraints()
        setEventConstraints()
        setPeriodConstraints()
        setSourceConstraints()
    }
    
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    // assigning values to variables
    func set(weatherAlert: WeatherAlert, indexPath: IndexPath) {
        downloadImage(from: randomImageURL, for: indexPath)
        if randomImageView.image == nil {
            randomImageView.image = placeHolderImage
        }
        event.text = weatherAlert.event
        monthDayYearFormatter.dateStyle = .medium
        period.text = monthDayYearFormatter.string(from: weatherAlert.dateEffective) + "—" + monthDayYearFormatter.string(from: weatherAlert.dateEffective)
        source.text = weatherAlert.senderName
    }
    
    
    
    // ***** STYLING *****
    func configureEvent() {
        addSubview(event)
        event.numberOfLines = 1
        event.adjustsFontSizeToFitWidth = true
        event.textColor = UIColor(named: "text")
        event.font = .systemFont(ofSize: 15, weight: .bold)
    }
    
    
    func configurePeriod() {
        addSubview(period)
        period.numberOfLines = 1
        period.adjustsFontSizeToFitWidth = false
        period.textColor = UIColor(named: "text")
        period.font = .systemFont(ofSize: 12)
    }
    
    
    func configureSource() {
        addSubview(source)
        source.numberOfLines = 1
        source.adjustsFontSizeToFitWidth = false
        source.textColor = UIColor(named: "text")
        source.font = .systemFont(ofSize: 9, weight: .bold)
    }
    
    
    
    // ***** LAYOUT *****
    func setImageConstraints() {
        contentView.addSubview(randomImageView)
        randomImageView.translatesAutoresizingMaskIntoConstraints = false
        randomImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        randomImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        randomImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        randomImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    
    func setEventConstraints() {
        event.translatesAutoresizingMaskIntoConstraints = false
        event.leadingAnchor.constraint(equalTo: randomImageView.trailingAnchor, constant: 15).isActive = true
        event.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        event.topAnchor.constraint(equalTo: randomImageView.topAnchor, constant: 10).isActive = true
        event.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    
    func setPeriodConstraints() {
        period.translatesAutoresizingMaskIntoConstraints = false
        period.leadingAnchor.constraint(equalTo: randomImageView.trailingAnchor, constant: 15).isActive = true
        period.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        period.heightAnchor.constraint(equalToConstant: 10).isActive = true
        period.topAnchor.constraint(equalTo: event.bottomAnchor, constant: 5).isActive = true
    }
    
    
    func setSourceConstraints() {
        source.translatesAutoresizingMaskIntoConstraints = false
        source.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        source.heightAnchor.constraint(equalToConstant: 10).isActive = true
        source.bottomAnchor.constraint(equalTo: randomImageView.bottomAnchor, constant: -10).isActive = true
    }
    
    
    
    // ***** NETWORKING *****
    func downloadImage(from urlString: String, for cellNumber: IndexPath) {
                
        // ***** doesn't seem like the image storing is working... *****
        
        // look to see if the image we need has been downloaded previously
        if downloadedImages.keys.contains(cellNumber) {
            // if it has, use it for our image
            self.randomImageView.image = downloadedImages[cellNumber]
            return
        }
                
        // check for good url
        guard let url = URL(string: urlString) else { return }
        
        // GET request for a new image
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            // error handling
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            
            // check dataType
            guard let image = UIImage(data: data) else { return }
            
            // put newly downloaded image into cache using our newly generated cacheKey (line 47)
            self.downloadedImages[cellNumber] = image
            
            // update UI on main thread
            DispatchQueue.main.async {
                self.randomImageView.image = image
            }
        }
        
        task.resume()
    }
}
