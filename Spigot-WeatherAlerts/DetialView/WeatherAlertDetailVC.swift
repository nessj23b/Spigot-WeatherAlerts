//
//  WeatherAlertDetailViewVC.swift
//  Spigot-WeatherAlerts
//
//  Created by Birch, Nathan J on 7/15/21.
//

import UIKit

class WeatherAlertDetailVC: UIViewController {
    
    var localTouchPosition : CGPoint?
    
    var areInstructionsBlank = false
    
    let paragraphStyle = NSMutableParagraphStyle()
    
    let monthDayYearFormatter = DateFormatter()
        
    let weatherAlert: WeatherAlert
    
    var randomImageView = UIImageView()
    let placeHolderImage = UIImage(named: "placeholderImage")
    
    lazy var scrollView = UIScrollView(frame: .zero)
    lazy var contentView = UIStackView()
    let period = UILabel()
    let severity = UILabel()
    let certainty = UILabel()
    let urgency = UILabel()
    let source = UILabel()
    let desc = UILabel()
    var instructions = UILabel()
    let instructionsBox = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
    let affectedZonesTitle = UILabel()
    let affectedZonesID = UILabel()
            
    init(weatherAlert: WeatherAlert, randomImageView: UIImageView) {
        self.weatherAlert = weatherAlert
        self.randomImageView = randomImageView
        
        monthDayYearFormatter.dateStyle = .long
        period.text = monthDayYearFormatter.string(from: weatherAlert.dateEffective) + "—" + monthDayYearFormatter.string(from: weatherAlert.dateEffective)
        severity.text = "Severity: " + weatherAlert.severity
        certainty.text = "Certainty: " + weatherAlert.certainty
        urgency.text = "Urgency: " + weatherAlert.urgency
        instructions.text = weatherAlert.instruction
        source.text = "Source: " + weatherAlert.senderName
        desc.text = weatherAlert.description
        affectedZonesTitle.text = "Affected Area Codes: "
        affectedZonesID.text = ""
        
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = weatherAlert.event
        view.backgroundColor = UIColor(named: "background")
        
        configureNavigation()
        
        checkForInstructions()
        setupStyling()
            
        configureScrollView()
        configureContentView()
        configureImage()
        configurePeriod()
        configureSeverity()
        configureCertainty()
        configureUrgency()
        configureAffectedZoneIDLabel()
        configureAffectedZoneID()
        configureIB()
        configureInstructions()
        configureSource()
        configureDescription()
        
        setScrollViewConstraints()
        setContentViewConstraints()
        setImageConstraints()
        setPeriodConstraints()
        setSeverityConstraints()
        setCertaintyConstraints()
        setUrgencyConstraints()
        setAffectedZonesIDLabelConstraints()
        setAffectedZonesIDConstraints()
        setInstructionsConstraints()
        setIBConstraints()
        setSourceConstraints()
        setDescriptionConstraints()
        
        setDragGesture()
    }

    
    
    // ***** FORMATTING *****
    func checkForInstructions() {
        if instructions.text == "" {
            areInstructionsBlank = true
        } else {
            areInstructionsBlank = false
        }
    }
    
    
    func setupStyling() {
        paragraphStyle.minimumLineHeight = CGFloat(20)
        paragraphStyle.maximumLineHeight = CGFloat(40)
    }
    
    
    func getZones() -> String {
        var count = 0
        var result = ""
        for affectedZone in weatherAlert.affectedZoneIDs {
            if count % 3 == 0 {
                result += "\n\(affectedZone.id)"
            }
            result += "        \(affectedZone.id)"
            count += 1
        }
        return result
    }
    
    
    
    // *** GESTURE HANDLERS
    func setDragGesture() {
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        randomImageView.addGestureRecognizer(panRecognizer)
    }
    
    
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let parentView = randomImageView
        
        let translation = recognizer.translation(in: parentView)
        recognizer.view?.center = CGPoint(x: recognizer.view!.center.x + translation.x, y: recognizer.view!.center.y + translation.y)
        recognizer.setTranslation(CGPoint.zero, in: randomImageView)
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    
    
    // ***** STYLING *****
    func configureNavigation() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        doneButton.tintColor = UIColor(named: "tintColor")
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func configureContentView() {
        scrollView.addSubview(contentView)
        contentView.backgroundColor = .clear
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func configureImage() {
        contentView.addSubview(randomImageView)
        if randomImageView.image == nil {
            randomImageView.image = placeHolderImage
        }
        randomImageView.isUserInteractionEnabled = true
        randomImageView.layer.cornerRadius = 7
        randomImageView.clipsToBounds = true
        randomImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func configurePeriod() {
        contentView.addSubview(period)
        period.numberOfLines = 1
        period.adjustsFontSizeToFitWidth = true
        period.textColor = UIColor(named: "text")
        period.font = .systemFont(ofSize: 15, weight: .bold)
        period.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func configureSeverity() {
        contentView.addSubview(severity)
        severity.numberOfLines = 1
        severity.adjustsFontSizeToFitWidth = false
        severity.textColor = UIColor(named: "text")
        severity.font = .systemFont(ofSize: 13, weight: .bold)
        severity.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func configureCertainty() {
        contentView.addSubview(certainty)
        certainty.numberOfLines = 1
        certainty.adjustsFontSizeToFitWidth = false
        certainty.textColor = UIColor(named: "text")
        certainty.font = .systemFont(ofSize: 13, weight: .bold)
        certainty.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func configureUrgency() {
        contentView.addSubview(urgency)
        urgency.numberOfLines = 1
        urgency.adjustsFontSizeToFitWidth = false
        urgency.textColor = UIColor(named: "text")
        urgency.font = .systemFont(ofSize: 13, weight: .bold)
        urgency.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func configureAffectedZoneIDLabel() {
        contentView.addSubview(affectedZonesTitle)
        affectedZonesTitle.numberOfLines = 1
        affectedZonesTitle.adjustsFontSizeToFitWidth = false
        affectedZonesTitle.textColor = UIColor(named: "text")
        affectedZonesTitle.font = .systemFont(ofSize: 14, weight: .bold)
        affectedZonesTitle.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func configureAffectedZoneID() {
        contentView.addSubview(affectedZonesID)
        affectedZonesID.text! += getZones()
        affectedZonesID.numberOfLines = 0
        affectedZonesID.attributedText = NSAttributedString(string: affectedZonesID.text!, attributes: [.paragraphStyle : paragraphStyle])
        affectedZonesID.adjustsFontSizeToFitWidth = false
        affectedZonesID.textColor = UIColor(named: "text")
        affectedZonesID.font = .systemFont(ofSize: 14)
        affectedZonesID.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func configureIB() {
        if !areInstructionsBlank {
            contentView.addSubview(instructionsBox)
            instructionsBox.layer.cornerRadius = 5.0
            instructionsBox.layer.borderWidth = 1.0
            instructionsBox.layer.borderColor = UIColor(named: "tintColor")?.cgColor
            instructionsBox.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    
    func configureInstructions() {
        if !areInstructionsBlank {
            contentView.addSubview(instructions)
            instructions.numberOfLines = 0
            instructions.adjustsFontSizeToFitWidth = false
            instructions.textColor = UIColor(named: "text")
            instructions.font = .systemFont(ofSize: 13, weight: .bold)
            instructions.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    
    func configureSource() {
        contentView.addSubview(source)
        source.numberOfLines = 1
        source.adjustsFontSizeToFitWidth = false
        source.textColor = UIColor(named: "text")
        source.font = .systemFont(ofSize: 16, weight: .bold)
        source.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func configureDescription() {
        contentView.addSubview(desc)
        desc.numberOfLines = 0
        desc.adjustsFontSizeToFitWidth = false
        desc.textColor = UIColor(named: "text")
        desc.font = .systemFont(ofSize: 14)
        desc.translatesAutoresizingMaskIntoConstraints = false
    }

    
    
    // ***** LAYOUT *****
    func setScrollViewConstraints() {
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
    func setContentViewConstraints() {
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    
    func setImageConstraints() {
        randomImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        randomImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3).isActive = true
        randomImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        randomImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        randomImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
    }
    
    
    func setPeriodConstraints() {
        period.leadingAnchor.constraint(equalTo: randomImageView.trailingAnchor, constant: 20).isActive = true
        period.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        period.topAnchor.constraint(equalTo: randomImageView.topAnchor, constant: 5).isActive = true
        period.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    
    func setSeverityConstraints() {
        severity.leadingAnchor.constraint(equalTo: randomImageView.trailingAnchor, constant: 20).isActive = true
        severity.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        severity.topAnchor.constraint(equalTo: period.bottomAnchor, constant: 5).isActive = true
        severity.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    
    func setCertaintyConstraints() {
        certainty.leadingAnchor.constraint(equalTo: randomImageView.trailingAnchor, constant: 20).isActive = true
        certainty.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        certainty.topAnchor.constraint(equalTo: severity.bottomAnchor, constant: 5).isActive = true
        certainty.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    
    func setUrgencyConstraints() {
        urgency.leadingAnchor.constraint(equalTo: randomImageView.trailingAnchor, constant: 20).isActive = true
        urgency.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        urgency.topAnchor.constraint(equalTo: certainty.bottomAnchor, constant: 5).isActive = true
        urgency.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    
    func setAffectedZonesIDLabelConstraints() {
        affectedZonesTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        affectedZonesTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        affectedZonesTitle.topAnchor.constraint(equalTo: randomImageView.bottomAnchor, constant: 30).isActive = true
        affectedZonesTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    
    func setAffectedZonesIDConstraints() {
        affectedZonesID.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        affectedZonesID.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        affectedZonesID.topAnchor.constraint(equalTo: affectedZonesTitle.bottomAnchor, constant: -20).isActive = true
    }
    
    
    func setInstructionsConstraints() {
        if !areInstructionsBlank {
            instructions.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50).isActive = true
            instructions.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50).isActive = true
            instructions.topAnchor.constraint(equalTo: affectedZonesID.bottomAnchor, constant: 60).isActive = true
        }
    }
    
    
    func setIBConstraints() {
        if !areInstructionsBlank {
            instructionsBox.leadingAnchor.constraint(equalTo: instructions.leadingAnchor, constant: -20).isActive = true
            instructionsBox.trailingAnchor.constraint(equalTo: instructions.trailingAnchor, constant: 20).isActive = true
            instructionsBox.topAnchor.constraint(equalTo: instructions.topAnchor, constant: -20).isActive = true
            instructionsBox.bottomAnchor.constraint(equalTo: instructions.bottomAnchor, constant: 20).isActive = true
        }
    }
    
    
    func setSourceConstraints() {
        if !areInstructionsBlank {
            source.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
            source.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
            source.topAnchor.constraint(equalTo: instructions.bottomAnchor, constant: 60).isActive = true
        } else {
            source.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
            source.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
            source.topAnchor.constraint(equalTo: affectedZonesID.bottomAnchor, constant: 60).isActive = true
        }
    }
    
    
    func setDescriptionConstraints() {
        desc.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30).isActive = true
        desc.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30).isActive = true
        desc.topAnchor.constraint(equalTo: source.bottomAnchor, constant: 10).isActive = true
        desc.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30).isActive = true
    }
}
