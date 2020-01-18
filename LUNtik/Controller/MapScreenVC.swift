//
//  ViewController.swift
//  LUNtik
//
//  Created by Nikandr Marhal on 17.01.2020.
//  Copyright © 2020 Nikandr Marhal. All rights reserved.
//

import MapKit
import UIKit

class MapScreenVC: UIViewController {
    @IBOutlet var mapView: MKMapView!
    
    var selectedResidence: Residence?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        mapPrimaryLocation()
        addAnnotations()
        
        
    }
    
    // MARK: - Primary map setup
    
    private func mapPrimaryLocation() {
        let initialLocation = CLLocation(latitude: 50.4501, longitude: 30.5234)
        centerMapOnLocation(location: initialLocation, withRegionRadius: 1000)
    }
    
    private func centerMapOnLocation(location: CLLocation, withRegionRadius radius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    // MARK: - Add annotations to the map
    
    private func addAnnotations() {
        APIClient.getResidenceData { result in
            switch result {
            case .success(let residences):
                for residence in residences {
                    self.mapView.addAnnotation(ResidenceAnnotation(fromResidence: residence))
                }
            case .failure:
                let alert = UIAlertController(title: "Сталася помилка", message: "Не вийшло завантажити дані про ЖК. Перевірте підключення до Інтернету", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Добре", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.showCard.rawValue {
            let navigationController = segue.destination as! UINavigationController
            guard let cardVC = navigationController.viewControllers.first as? CardVC else {
                return
            }
            guard let residence = selectedResidence else {
                let alert = UIAlertController(title: "Сталася помилка", message: "Перезавантажте додаток", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Добре", style: .default, handler: nil))
                self.present(alert, animated: true)
                return
            }
            cardVC.residence = residence
        }
    }
}

// MARK: - MapKit delegate

extension MapScreenVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let residenceAnnotation = view.annotation as? ResidenceAnnotation else { return }
        let residence = residenceAnnotation.residence
        selectedResidence = residence
        performSegue(withIdentifier: SegueIdentifiers.showCard.rawValue, sender: self)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {}
}
