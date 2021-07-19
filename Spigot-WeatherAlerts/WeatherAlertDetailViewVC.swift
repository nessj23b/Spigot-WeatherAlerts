//
//  WeatherAlertDetailViewVC.swift
//  Spigot-WeatherAlerts
//
//  Created by Birch, Nathan J on 7/15/21.
//

import UIKit

class WeatherAlertDetailVC: UIViewController {
    
    let weatherAlert: WeatherAlert
    
    let randomImage = UIImage()
    let randomImageView = UIImageView()
    
    let event = UILabel()
    let dateEffective = UILabel()
    let dateEnds = UILabel()
    let senderName = UILabel()
    
    init(weatherAlert: WeatherAlert) {
        self.weatherAlert = weatherAlert
        event.text = weatherAlert.event
        dateEffective.text = weatherAlert.dateEffective
        dateEnds.text = weatherAlert.dateEnds
        senderName.text = weatherAlert.senderName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details".uppercased()
        view.backgroundColor = .white

//        configureImage()
//        configureAccountName()
//        configureDesc()
//        configureButton()
//        
//        setImageConstraints()
//        setAccountNameConstraints()
//        setDescConstraints()
//        setButtonConstraints()
    }
    
    // ***** FORMATTING / OTHER *****
    @objc func dismissView() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    func setImage(accountType: String) -> UIImage {
        return accountType == "bank" ? UIImage(named: "bank")! : UIImage(named: "card")!
    }
    
    
    
//    // ***** STYLING *****
//    func configureImage() {
//        view.addSubview(accountImageView)
//        accountImageView.image = setImage(accountType: account.accountType)
//    }
//
//
//    func configureAccountName() {
//        view.addSubview(accountName)
//        accountName.numberOfLines = 1
//        accountName.adjustsFontSizeToFitWidth = false
//        accountName.textAlignment = .center
//        accountName.textColor = VGrey.dark.color
//        accountName.font = .vryAvenirNextDemiBold(16)
//    }
//
//
//    func configureDesc() {
//        view.addSubview(desc)
//        desc.numberOfLines = 1
//        desc.adjustsFontSizeToFitWidth = false
//        desc.textAlignment = .center
//        desc.textColor = VGrey.dark.color
//        desc.font = .vryAvenirNextRegular(14)
//    }
//
//
//    func configureButton() {
//        view.addSubview(doneButton)
//        doneButton.backgroundColor = VBlue.normal.color
//        doneButton.tintColor = .white
//        doneButton.setTitle("Done".uppercased(), for: .normal)
//        doneButton.titleLabel?.font = .vryAvenirNextDemiBold(18)
//        doneButton.layer.shadowColor = UIColor.black.cgColor
//        doneButton.layer.shadowOpacity = 0.6
//        doneButton.layer.shadowOffset = CGSize(width: 0, height: 1.5)
//        doneButton.layer.shadowRadius = 2
//        doneButton.layer.cornerRadius = 2
//        doneButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
//        doneButton.translatesAutoresizingMaskIntoConstraints = false
//    }
//
//
//
//    // ***** LAYOUT *****
//    func setImageConstraints() {
//        accountImageView.translatesAutoresizingMaskIntoConstraints = false
//        accountImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
//        accountImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        accountImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        accountImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
//    }
//
//
//    func setAccountNameConstraints() {
//        accountName.translatesAutoresizingMaskIntoConstraints = false
//        accountName.topAnchor.constraint(equalTo: accountImageView.bottomAnchor, constant: 20).isActive = true
//        accountName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        accountName.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        accountName.widthAnchor.constraint(equalToConstant: 300).isActive = true
//    }
//
//
//    func setDescConstraints() {
//        desc.translatesAutoresizingMaskIntoConstraints = false
//        desc.topAnchor.constraint(equalTo: accountName.bottomAnchor, constant: 3).isActive = true
//        desc.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        desc.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        desc.widthAnchor.constraint(equalToConstant: 300).isActive = true
//    }
//
//
//    func setButtonConstraints() {
//        NSLayoutConstraint.activate([
//            doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
//            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
//            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
//            doneButton.heightAnchor.constraint(equalToConstant: 55)
//        ])
//    }
}

