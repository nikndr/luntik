//
//  CardVC.swift
//  LUNtik
//
//  Created by Nikandr Marhal on 17.01.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import UIKit

class CardVC: UIViewController {
    // MARK: - Model reference
    
    var residence: Residence?
    
    // MARK: - Outlets
    
    @IBOutlet var residenceImageView: UIImageView!
    @IBOutlet var residenceNameLabel: UILabel!
    @IBOutlet var streetNameLabel: UILabel!
    
    private func setUpOutlets() {
        guard let residence = residence else {
            fatalError("residence is nil after view controller presentation")
        }
        
        guard let url = URL(string: residence.imageURL) else {
            fatalError("invalid image url") // TODO: add default image
        }
        streetNameLabel.text = residence.address
        residenceNameLabel.text = residence.title ?? "Todo default text" //TODO: default text
        DispatchQueue.main.async {
            ImageLoader.downloadImage(from: url) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.residenceImageView.image = UIImage(data: data) //?? //TODO: set default image
                case .failure(let error):
                    print(error) //TODO: set default image
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpOutlets()
    }
    
    // MARK: - IBActions
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil) // TODO: add annotation unfocus on completion
    }
}
