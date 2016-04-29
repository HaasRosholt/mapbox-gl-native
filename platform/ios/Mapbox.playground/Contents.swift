//: # Mapbox Maps

import UIKit
import XCPlayground
import Mapbox

let width = 400
let height = 400

MGLAccountManager.setAccessToken("<Mapbox Access Token>")

let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
view.backgroundColor = UIColor.whiteColor()
XCPlaygroundPage.currentPage.liveView = view
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//: Make a map!

let mapView = MGLMapView(frame: view.bounds)
view.addSubview(mapView)

//: ### Annotations

//: Create an annotation

let pointAnnotation = MGLPointAnnotation()
pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
pointAnnotation.title = "Null Island!"

//: Add the annotation to the map

mapView.addAnnotation(pointAnnotation)

