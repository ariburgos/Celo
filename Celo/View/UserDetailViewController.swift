//
//  UserDetailViewController.swift
//  Celo
//
//  Created by Viajeros Lado B on 18/06/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class UserDetailViewController: UIViewController {
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var cellphoneLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    private let presenter = UserDetailPresenter()
    
    static func initViewController(user: UserViewModel?) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController

        
        let presenter = viewController.presenter
        presenter.attachView(view: viewController)
        presenter.setUser(user: user)
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"
        presenter.loadUser()
        mapView.delegate = self
    }
}


extension UserDetailViewController: UserDetailViewDelegate {
    func showUser(name: String, imageURL: URL?, gender: String, birthday: String, email: String, phone: String, cellphone: String, nationality: String, address: String, lat: String?, long: String?) {
        
        if let imageURL = imageURL {
            mainImage.loadImage(withURL: imageURL, placeholderImage: nil)
        }
        nameLabel.text = name
        genderLabel.text = gender
        birthdayLabel.text = birthday
        
        emailLabel.text = email
        phoneLabel.text = phone
        cellphoneLabel.text = cellphone
        nationalityLabel.text = nationality
        addressLabel.text = address
        
        if let lat = lat,
            let long = long,
            let latInt = Double(lat),
            let longInt = Double(long) {
            
            let annotation = MKPointAnnotation()
            let centerCoordinate = CLLocationCoordinate2D(latitude: latInt, longitude: longInt)

            mapView.setCenter(centerCoordinate, animated: true)

            annotation.coordinate = centerCoordinate
            annotation.title = name
            self.mapView.addAnnotation(annotation)
            
        }
    }
}

extension UserDetailViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotationView")
        annotationView.canShowCallout = true
        annotationView.rightCalloutAccessoryView = UIButton.init(type: UIButton.ButtonType.detailDisclosure)

        return annotationView
    }
}
