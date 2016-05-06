import UIKit
import XCPlayground
import Mapbox

//: # Mapbox Maps

/*:
### Setting the Access Token
 
Add a PlaygroundInfo.plist file to the Resources folder in this playground. Then add an 
access token key value pair:
 
```
 <dict>
<key>MGLMapboxAccessToken</key>
 <string>access.token</string>
 </dict>
```
*/

var accessToken = ""
if let infoPath = NSBundle.mainBundle().pathForResource("PlaygroundInfo", ofType: "plist"),
    info = NSDictionary(contentsOfFile: infoPath) {
    accessToken = info["MGLMapboxAccessToken"] as! String
}
MGLAccountManager.setAccessToken(accessToken)


//: Define a map delegate

class MapDelegate: NSObject, MGLMapViewDelegate {
    
    var annotationViewByAnnotation = [MGLPointAnnotation: MGLAnnotationView]()
    
    func mapView(mapView: MGLMapView, viewForAnnotation annotation: MGLAnnotation) -> MGLAnnotationView? {
        let annotationView = MGLAnnotationView()
        annotationView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let centerView = UIView(frame: CGRectInset(annotationView.bounds, 3, 3))
        centerView.backgroundColor = UIColor.whiteColor()
        annotationView.addSubview(centerView)
        annotationView.backgroundColor = UIColor.purpleColor()
        
        let pointAnnotation = annotation as! MGLPointAnnotation
        annotationViewByAnnotation[pointAnnotation] = annotationView
        
        return annotationView
    }
    
    func mapView(mapView: MGLMapView, didSelectAnnotation annotation: MGLAnnotation) {
        let pointAnnotation = annotation as! MGLPointAnnotation
        let annotationView = annotationViewByAnnotation[pointAnnotation]
        
        for view in annotationViewByAnnotation.values {
            view.layer.zPosition = -1
        }
        
        annotationView?.layer.zPosition = 1
        
        UIView.animateWithDuration(1.25, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.6, options: .CurveEaseOut, animations: {
            annotationView!.transform = CGAffineTransformMakeScale(1.8, 1.8)
        }) { _ in
            annotationView!.transform = CGAffineTransformMakeScale(1, 1)
        }
    }
    
    func handleTap(press: UILongPressGestureRecognizer) {
        let mapView: MGLMapView = press.view as! MGLMapView
        
        print(mapView)
        
        if (press.state == .Recognized) {
            let coordiante: CLLocationCoordinate2D = mapView.convertPoint(press.locationInView(mapView), toCoordinateFromView: mapView)
            let annotation = MGLPointAnnotation()
            annotation.title = "Dropped Marker"
            annotation.coordinate = coordiante
            mapView.addAnnotation(annotation)
            mapView.showAnnotations([annotation], animated: true)
        }
    }
    
}

//: Create a map and its delegate

let width = 700
let height = 800
let lat: CLLocationDegrees = 37.174057
let lng: CLLocationDegrees = -104.490984
let centerCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)

let mapView = MGLMapView(frame: CGRect(x: 0, y: 0, width: width, height: height))
mapView.frame = CGRect(x: 0, y: 0, width: width, height: height)

XCPlaygroundPage.currentPage.liveView = mapView
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

let mapDelegate = MapDelegate()
mapView.delegate = mapDelegate

let tapGesture = UILongPressGestureRecognizer(target: mapDelegate, action: #selector(mapDelegate.handleTap))
mapView.addGestureRecognizer(tapGesture)

//: Zoom in to a location

mapView.setCenterCoordinate(centerCoordinate, zoomLevel: 12, animated: false)

//: ## Annotations

//: Create and add annotations

let pointAnnotation1 = MGLPointAnnotation()
pointAnnotation1.coordinate = centerCoordinate

let pointAnnotation2 = MGLPointAnnotation()
var offsetCoordinate = centerCoordinate
offsetCoordinate.longitude += 0.003
pointAnnotation2.coordinate = offsetCoordinate

//: Add the annotation to the map

mapView.addAnnotations([pointAnnotation1, pointAnnotation2])


