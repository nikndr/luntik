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
        
        let artwork = Residence(title: "Ліпкі", address: "вул. Крєщатік", coordinate: CLLocationCoordinate2D(latitude: 50.4501, longitude: 30.5234), imageURL: "https://img.lun.ua/building-1600x1200/2708.jpg")
        mapView.addAnnotation(artwork)
    }
    
    private func mapPrimaryLocation() {
        let initialLocation = CLLocation(latitude: 50.4501, longitude: 30.5234)
        centerMapOnLocation(location: initialLocation, withRegionRadius: 1000)
    }
    
    private func centerMapOnLocation(location: CLLocation, withRegionRadius radius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.showCard.rawValue {
            let navigationController = segue.destination as! UINavigationController //TODO: find first controller in navigation controller
            guard let cardVC = navigationController.viewControllers.first as? CardVC else {
                fatalError("card vc is not found")
            }
            guard let residence = selectedResidence else {
                fatalError("cannot pass residence to card view controller")
            }
            cardVC.residence = residence
        }
    }
}

// MARK: - MapKit delegate

extension MapScreenVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard
            let residence = view.annotation as? Residence,
            let title = residence.title
        else { return }
        print(title)
        // TODO: - implement presentation of modal VC
        performSegue(withIdentifier: SegueIdentifiers.showCard.rawValue, sender: self)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {}
}
