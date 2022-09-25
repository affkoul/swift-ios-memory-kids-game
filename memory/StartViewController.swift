//
//  StartviewController.swift
//  memory
//
//  Created by ANATOLI DIMITROV KOUEMO NGAYO on 2020/4/5.
//  Copyright © 2020 AnatDim. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    var game1StartLabel = CustomLabel()
    var game1StartButton = CustomButton()
    var game1StartImage = CustomImageView(image: UIImage(named: "flamingo2.png"))
    
    let topLabelContainerView = UIView()
    let midImageContainerView = UIView()
    let bottomButtomContainerView = UIView()
    
    @IBOutlet var bgImageView: UIImageView! // Background Image View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgImageView = UIImageView(image: UIImage(named: "v1Bkgrd-2048x1536"))
        bgImageView.contentMode = .scaleAspectFill
        self.view.addSubview(bgImageView)
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        bgImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bgImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bgImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -0).isActive = true
        bgImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -0).isActive = true
        setupGame1StartLabelConstraints()
        game1StartLabel.text = "Memory Game"
        setupGame1StartImageConstraints()
        setupGame1StartButtonConstraints()
        game1StartButton.setTitle("Play", for: .normal)
        addActionToStartButtons()
    }
    
    func setupGame1StartLabelConstraints() {
        view.addSubview(topLabelContainerView)
        topLabelContainerView.translatesAutoresizingMaskIntoConstraints = false
        topLabelContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topLabelContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.33).isActive = true
        topLabelContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topLabelContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topLabelContainerView.addSubview(game1StartLabel)
        game1StartLabel.translatesAutoresizingMaskIntoConstraints = false
        game1StartLabel.minimumScaleFactor = 10/UIFont.labelFontSize
        game1StartLabel.adjustsFontSizeToFitWidth = true
        game1StartLabel.centerXAnchor.constraint(equalTo: topLabelContainerView.centerXAnchor).isActive = true
        game1StartLabel.centerYAnchor.constraint(equalTo: topLabelContainerView.centerYAnchor).isActive = true
        game1StartLabel.heightAnchor.constraint(equalTo: topLabelContainerView.heightAnchor, multiplier: 0.3).isActive = true
        game1StartLabel.widthAnchor.constraint(equalTo: topLabelContainerView.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func setupGame1StartImageConstraints() {
        view.addSubview(midImageContainerView)
        midImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        midImageContainerView.topAnchor.constraint(equalTo: topLabelContainerView.bottomAnchor).isActive = true
        midImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.33).isActive = true
        midImageContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        midImageContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        midImageContainerView.addSubview(game1StartImage)
        game1StartImage.contentMode = .scaleAspectFit
        game1StartImage.translatesAutoresizingMaskIntoConstraints = false
        game1StartImage.centerXAnchor.constraint(equalTo: midImageContainerView.centerXAnchor).isActive = true
        game1StartImage.centerYAnchor.constraint(equalTo: midImageContainerView.centerYAnchor).isActive = true
        game1StartImage.heightAnchor.constraint(equalTo: midImageContainerView.heightAnchor).isActive = true
        game1StartImage.widthAnchor.constraint(equalTo: midImageContainerView.widthAnchor).isActive = true
    }
    
    func setupGame1StartButtonConstraints() {
        view.addSubview(bottomButtomContainerView)
        bottomButtomContainerView.translatesAutoresizingMaskIntoConstraints = false
        bottomButtomContainerView.topAnchor.constraint(equalTo: midImageContainerView.bottomAnchor).isActive = true
        bottomButtomContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.33).isActive = true
        bottomButtomContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bottomButtomContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bottomButtomContainerView.addSubview(game1StartButton)
        game1StartButton.translatesAutoresizingMaskIntoConstraints = false
        game1StartButton.titleLabel?.minimumScaleFactor = 10/UIFont.labelFontSize
        game1StartButton.titleLabel?.adjustsFontSizeToFitWidth = true
        game1StartButton.centerXAnchor.constraint(equalTo: bottomButtomContainerView.centerXAnchor).isActive = true
        game1StartButton.centerYAnchor.constraint(equalTo: bottomButtomContainerView.centerYAnchor).isActive = true
        game1StartButton.heightAnchor.constraint(equalTo: bottomButtomContainerView.heightAnchor, multiplier: 0.3).isActive = true
        game1StartButton.widthAnchor.constraint(equalTo: bottomButtomContainerView.widthAnchor, multiplier: 0.8).isActive = true
        
    }
    
    func addActionToStartButtons() {
        game1StartButton.addTarget(self, action: #selector(game1StartButtonTapped), for: .touchUpInside)
    }
    
    @objc func game1StartButtonTapped() {
        game1StartLabel.shake()
        game1StartImage.shake()
        
        // Safe Present
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Game1ViewController") as? ViewController
        {
            present(vc, animated: true, completion: nil)
        }
    }
}
