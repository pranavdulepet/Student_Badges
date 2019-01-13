//
//  ViewController.swift
//  tomtom
//
//  Created by Pranav on 1/12/19.
//  Copyright © 2019 Pranav. All rights reserved.
//

import UIKit
//import MapsSDKExamplesCommon
//import MapsSDKExamplesVC
import TomTomOnlineSDKMaps
import TomTomOnlineSDKSearch
import TomTomOnlineSDKMapsUIExtensions



class ViewController: UIViewController, UISearchBarDelegate, TTSearchDelegate, TTAnnotationDelegate {
    
    var position = CLLocationCoordinate2D(latitude: 37.769278, longitude: -121.902325)
    @IBOutlet weak var textview: UITextField!
    
    var locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: TTMapView!
    
    //@IBOutlet weak var searchBar: UISearchBar!
    
    let tomtomSearchAPI = TTSearch()
    
    var searchResults: [TTSearchResult] = []
    
    
    
    @IBAction func editingchanged(_ sender: UITextField) {
    
        let enteredText = "\"high school\" " + textview.text!

        if enteredText.count ?? 0 >= 50 {
            
            let searchQuery: TTSearchQuery = TTSearchQueryBuilder.create(withTerm: enteredText ?? "").withTypeAhead(false).build()

            self.tomtomSearchAPI.search(with: searchQuery)
            

        }
        
    }
    
    
    func search(_ search: TTSearch, completedWith response: TTSearchResponse) {
    
        /*print("response results")
        print(response.results)
        print("----")*/
        
        var (r, resultTuple) = ("", CLLocationCoordinate2D(latitude: 0, longitude: 0))
        
        for result in response.results {
            (r, resultTuple) = (result.address.freeformAddress!, result.position)
        }
        
        /*print("result")
        print(resultTuple)
        print(resultTuple.latitude)
        print(resultTuple.longitude)
        print("-----")*/
        let position = CLLocationCoordinate2D(latitude: resultTuple.latitude, longitude: resultTuple.longitude)
        self.mapView.center(on: position, withZoom: 15)
    }
    
    func search(_ search: TTSearch, failedWithError error: TTResponseError) {
        /*print("error response")
        print(error.userInfo["description"] as! String)
        print("----")*/
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tomtomSearchAPI.delegate = self
        //mapView.isShowsUserLocation = true
        
        position = CLLocationCoordinate2DMake(37.381473, -121.958198)
        
        self.mapView.center(on: position, withZoom: 15)
  
        self.mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.mapView.setTilesType(.vector)
        
        self.mapView.annotationManager.delegate = self
        
        //displayDecalMarkers()
    
        
    }
    

}

