//
//  ViewController.swift
//  Coordinates of map
//
//  Created by Cheuk Yin Chung on 21/3/2024.
//

import UIKit
import MapKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var cordLabel: UILabel!
    var latitude = Float()
    var longitude = Float()
    var hasAnnotation = false
    let pin = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        mapView = MKMapView(frame: view.bounds)
        view.addSubview(mapView)
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:))) // when view loads, check if gesture is made, then if gesture made run function "HandleLongPress'
        mapView.addGestureRecognizer(longPressGesture) // connects the gesture recogniser to the map
        self.view.bringSubviewToFront(cordLabel)
    }
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer)
    {
        if gestureRecognizer.state == .began
        {
            if hasAnnotation == true // if there is alr a pin on the map
            {
                mapView.removeAnnotation(pin)
            }
            let touchPoint = gestureRecognizer.location(in: mapView)
            let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
            // adds a pin to show where the location is
            pin.coordinate = coordinate // putting the pin location to coordinate
            mapView.addAnnotation(pin)
            // to get the latitude and longtitude from the map
            latitude = Float(coordinate.latitude)
            longitude = Float(coordinate.longitude)
            cordLabel.text = "Lat: \(latitude), Long: \(longitude)"
            hasAnnotation = true
        }
    }


}

