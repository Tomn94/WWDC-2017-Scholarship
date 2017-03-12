//: [Previous](@previous)

//#-hidden-code
import MapKit
import PlaygroundSupport
//#-end-hidden-code

/// Define the size of the flags
let pinSize:             CGFloat = /*#-editable-code Define the size of the flags*/42/*#-end-editable-code*/

/// Enter a number of seconds after which the map animation starts
let animationDelay: TimeInterval = /*#-editable-code Enter a number of seconds after which the map animation starts*/2/*#-end-editable-code*/

/// Enter a plane speed multiplier
let planeSpeed:     TimeInterval = /*#-editable-code Enter a plane speed multiplier*/1/*#-end-editable-code*/

//#-hidden-code

//: ## Resources

/// Converts an emoji character to an image,
/// in order to use it as a map pin
///
/// - Parameter emoji: Emoji string
/// - Returns: Image containing the string on a clear background
func image(from emoji: String) -> UIImage? {
    
    let size = CGSize(width: pinSize, height: pinSize)
    UIGraphicsBeginImageContextWithOptions(size, false, 0);
    let rect = CGRect(origin: CGPoint.zero, size: size)
    (emoji as NSString).draw(in: rect, withAttributes: [NSFontAttributeName: UIFont.systemFont(ofSize: pinSize)])
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
}

/// Model for a pin on the map
class Annotation: NSObject, MKAnnotation {
    
    /// Coordinate of the pin, allowing it to be changed in real-time
    dynamic var coordinate: CLLocationCoordinate2D
    
    /// Eventual title for the callout view
    var title: String?
    
    /// Eventual subtitle for the callout view
    var subtitle: String?
    
    /// String (emoji) to display as a pin
    var pin: String
    
    
    init(at coordinate: CLLocationCoordinate2D, title: String, subtitle: String?, pin: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.pin = pin
    }
}

/// Helps setting up the map view
class MapDelegate: NSObject, MKMapViewDelegate {
    
    /// Configures the pins on the map with their icon
    ///
    /// - Parameters:
    ///   - mapView: Map view to populate
    ///   - annotation: Associated pin annotation
    /// - Returns: The view for the associated annotation
    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let view = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        view.image = image(from: (annotation as! Annotation).pin)
        view.canShowCallout = true
        
        return view
    }
}

//: ## Create pins
let angers = Annotation(at: CLLocationCoordinate2D(latitude: 47.493404, longitude: -0.550958),
                        title: "Angers, France", subtitle: "My Engineering School 🎓",
                        pin: "🇫🇷")

let hongkong = Annotation(at: CLLocationCoordinate2D(latitude: 22.336066, longitude: 114.173678),
                          title: "Hong Kong", subtitle: "My Current Semester Abroad 🎓",
                          pin: "🇭🇰")

let uk = Annotation(at: CLLocationCoordinate2D(latitude: 51.5073509, longitude: -0.1277583),
                    title: "United Kingdom", subtitle: "Computing Summer School",
                    pin: "🇬🇧")

let ireland = Annotation(at: CLLocationCoordinate2D(latitude: 53.273864, longitude: -9.049504),
                         title: "Ireland", subtitle: nil,
                         pin: "🇮🇪")

let germany = Annotation(at: CLLocationCoordinate2D(latitude: 48.370, longitude: 10.8978),
                         title: "Germany", subtitle: "Summer Schools",
                         pin: "🇩🇪")

let china = Annotation(at: CLLocationCoordinate2D(latitude: 31.2304, longitude: 121.4737),
                       title: "Shanghai Summer School", subtitle: nil,
                       pin: "🇨🇳")

let morocco = Annotation(at: CLLocationCoordinate2D(latitude: 30.399351, longitude: -9.601969),
                         title: "Morocco", subtitle: nil,
                         pin: "🇲🇦")

let czech = Annotation(at: CLLocationCoordinate2D(latitude: 50.0755, longitude: 14.4378),
                       title: "Czech Republic", subtitle: nil,
                       pin: "🇨🇿")

let belgium = Annotation(at: CLLocationCoordinate2D(latitude: 50.8503, longitude: 4.3517),
                         title: "Belgium", subtitle: nil,
                         pin: "🇧🇪")

let italy = Annotation(at: CLLocationCoordinate2D(latitude: 43.771521, longitude: 11.254774),
                       title: "Ireland", subtitle: nil,
                       pin: "🇮🇹")

let luxembourg = Annotation(at: CLLocationCoordinate2D(latitude: 49.6116, longitude: 6.1319),
                           title: "Luxembourg", subtitle: nil,
                           pin: "🇱🇺")

let greece = Annotation(at: CLLocationCoordinate2D(latitude: 35.3387, longitude: 25.1442),
                        title: "Greece", subtitle: nil,
                        pin: "🇬🇷")

let spain = Annotation(at: CLLocationCoordinate2D(latitude: 41.400692, longitude: 2.175545),
                        title: "Spain", subtitle: nil,
                        pin: "🇪🇸")

let vietnam = Annotation(at: CLLocationCoordinate2D(latitude: 20.8, longitude: 106.9997),
                         title: "Vietnam", subtitle: nil,
                         pin: "🇻🇳")

let myanmar = Annotation(at: CLLocationCoordinate2D(latitude: 21.1717, longitude: 94.8585),
                         title: "Myanmar", subtitle: nil,
                         pin: "🇲🇲")

let thailand = Annotation(at: CLLocationCoordinate2D(latitude: 13.773250, longitude: 100.545897),
                          title: "Thailand", subtitle: nil,
                          pin: "🇹🇭")

let cambodia = Annotation(at: CLLocationCoordinate2D(latitude: 11.5449, longitude: 104.8922),
                          title: "Cambodia", subtitle: nil,
                          pin: "🇰🇭")

let macao = Annotation(at: CLLocationCoordinate2D(latitude: 22.1987, longitude: 113.5439),
                       title: "Macao", subtitle: nil,
                       pin: "🇲🇴")

let japan = Annotation(at: CLLocationCoordinate2D(latitude: 35.6895, longitude: 139.6917),
                       title: "Japan", subtitle: nil,
                       pin: "🇯🇵")

let cities = [angers, hongkong, macao, uk, ireland, germany, china, morocco, czech, belgium, italy, luxembourg, greece, spain, vietnam, myanmar, thailand, cambodia, japan]

/// This pin is me
let plane = Annotation(at: CLLocationCoordinate2D(latitude: angers.coordinate.latitude - 0.4,
                                                  longitude: angers.coordinate.longitude + 0.8),
                       title: "Me 👨🏼‍💻", subtitle: nil,
                       pin: "🛩")

/// Intermediate middle point
let center = CLLocationCoordinate2D(latitude: 37.758818, longitude: 64.346717)

//: ## Create the map (main view)
/// Strong reference to the map view delegate
let delegate = MapDelegate()
let map = MKMapView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
map.delegate = delegate
//#-end-hidden-code
map.mapType = /*#-editable-code Change map*/.satellite/*#-end-editable-code*/
//#-hidden-code
map.region = MKCoordinateRegionMake(angers.coordinate,
                                    MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))

map.addAnnotations(cities)
map.addAnnotation(plane)

//: ## Configure playground
PlaygroundPage.current.liveView = map


//: ## Setting up animations
//: ### Unzoom on Europe
Timer.scheduledTimer(withTimeInterval: animationDelay, repeats: false) { _ in
    map.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2D(latitude: 43, longitude: 7.5),
                                         MKCoordinateSpan(latitudeDelta: 32, longitudeDelta: 32)), animated: true)
}
//: ### Begin to move plane in Middle Asia, avoids it to take a route on the other side of the globe
Timer.scheduledTimer(withTimeInterval: animationDelay + 1.2, repeats: false) { _ in
    UIView.animate(withDuration: 4 / planeSpeed) {
        plane.coordinate = center
    }
}
//: ### Zoom on Asia
Timer.scheduledTimer(withTimeInterval: animationDelay + 3, repeats: false) { _ in
    map.setRegion(MKCoordinateRegionMake(hongkong.coordinate,
                                         MKCoordinateSpan(latitudeDelta: 30, longitudeDelta: 30)), animated: true)
}
//: ### Move the plane to its final destination, Hong Kong
Timer.scheduledTimer(withTimeInterval: animationDelay + 3, repeats: false) { _ in
    UIView.animate(withDuration: 3 / planeSpeed) {
        plane.coordinate = CLLocationCoordinate2D(latitude: hongkong.coordinate.latitude + 0.01,
                                                  longitude: hongkong.coordinate.longitude - 0.03)
    }
}

//: ### Zoom further on Hong Kong
Timer.scheduledTimer(withTimeInterval: animationDelay + 4.8, repeats: false) { _ in
    map.setRegion(MKCoordinateRegionMake(hongkong.coordinate,
                                         MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)), animated: true)
}

//: ### Unzoom to global scale
Timer.scheduledTimer(withTimeInterval: animationDelay + 9, repeats: false) { _ in
    map.showAnnotations(cities, animated: true)
}
//#-end-hidden-code

//: [Next](@next)
