import UIKit
import MapKit

/// Converts an emoji character to an image,
/// in order to use it as a map pin
///
/// - Parameter emoji: Emoji string
/// - Returns: Image containing the string on a clear background
public func image(from emoji: String, size pinSize: CGFloat) -> UIImage? {
    
    let size = CGSize(width: pinSize, height: pinSize)
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    let rect = CGRect(origin: CGPoint.zero, size: size)
    (emoji as NSString).draw(in: rect, withAttributes: [NSFontAttributeName: UIFont.systemFont(ofSize: pinSize)])
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
}

/// Model for a pin on the map
public class Annotation: NSObject, MKAnnotation {
    
    /// Coordinate of the pin, allowing it to be changed in real-time
    dynamic public var coordinate: CLLocationCoordinate2D
    
    /// Eventual title for the callout view
    public var title: String?
    
    /// Eventual subtitle for the callout view
    public var subtitle: String?
    
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
public class MapDelegate: NSObject, MKMapViewDelegate {
    
    /// Size of all the annotations on the map
    public var pinSize: CGFloat = 42
    
    /// Configures the pins on the map with their icon
    ///
    /// - Parameters:
    ///   - mapView: Map view to populate
    ///   - annotation: Associated pin annotation
    /// - Returns: The view for the associated annotation
    public func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let view = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        view.image = image(from: (annotation as! Annotation).pin,
                           size: pinSize)
        view.canShowCallout = true
        
        return view
    }
    
}

//: ## Create pins
public let angers = Annotation(at: CLLocationCoordinate2D(latitude: 47.493404, longitude: -0.550958),
                        title: "Angers, France", subtitle: "My Engineering School 🎓",
                        pin: "🇫🇷")

public let hongkong = Annotation(at: CLLocationCoordinate2D(latitude: 22.336066, longitude: 114.173678),
                          title: "Hong Kong", subtitle: "My Current Semester Abroad 🎓",
                          pin: "🇭🇰")

public let uk = Annotation(at: CLLocationCoordinate2D(latitude: 51.5073509, longitude: -0.1277583),
                    title: "United Kingdom", subtitle: "Computing Summer School",
                    pin: "🇬🇧")

public let ireland = Annotation(at: CLLocationCoordinate2D(latitude: 53.273864, longitude: -9.049504),
                         title: "Ireland", subtitle: nil,
                         pin: "🇮🇪")

public let germany = Annotation(at: CLLocationCoordinate2D(latitude: 48.370, longitude: 10.8978),
                         title: "Germany", subtitle: "Summer Schools",
                         pin: "🇩🇪")

public let china = Annotation(at: CLLocationCoordinate2D(latitude: 31.2304, longitude: 121.4737),
                       title: "Shanghai Summer School", subtitle: nil,
                       pin: "🇨🇳")

public let morocco = Annotation(at: CLLocationCoordinate2D(latitude: 30.399351, longitude: -9.601969),
                         title: "Morocco", subtitle: nil,
                         pin: "🇲🇦")

public let czech = Annotation(at: CLLocationCoordinate2D(latitude: 50.0755, longitude: 14.4378),
                       title: "Czech Republic", subtitle: nil,
                       pin: "🇨🇿")

public let belgium = Annotation(at: CLLocationCoordinate2D(latitude: 50.8503, longitude: 4.3517),
                         title: "Belgium", subtitle: nil,
                         pin: "🇧🇪")

public let italy = Annotation(at: CLLocationCoordinate2D(latitude: 43.771521, longitude: 11.254774),
                       title: "Ireland", subtitle: nil,
                       pin: "🇮🇹")

public let luxembourg = Annotation(at: CLLocationCoordinate2D(latitude: 49.6116, longitude: 6.1319),
                            title: "Luxembourg", subtitle: nil,
                            pin: "🇱🇺")

public let greece = Annotation(at: CLLocationCoordinate2D(latitude: 35.3387, longitude: 25.1442),
                        title: "Greece", subtitle: nil,
                        pin: "🇬🇷")

public let spain = Annotation(at: CLLocationCoordinate2D(latitude: 41.400692, longitude: 2.175545),
                       title: "Spain", subtitle: nil,
                       pin: "🇪🇸")

public let vietnam = Annotation(at: CLLocationCoordinate2D(latitude: 20.8, longitude: 106.9997),
                         title: "Vietnam", subtitle: nil,
                         pin: "🇻🇳")

public let myanmar = Annotation(at: CLLocationCoordinate2D(latitude: 21.1717, longitude: 94.8585),
                         title: "Myanmar", subtitle: nil,
                         pin: "🇲🇲")

public let thailand = Annotation(at: CLLocationCoordinate2D(latitude: 13.773250, longitude: 100.545897),
                          title: "Thailand", subtitle: nil,
                          pin: "🇹🇭")

public let cambodia = Annotation(at: CLLocationCoordinate2D(latitude: 11.5449, longitude: 104.8922),
                          title: "Cambodia", subtitle: nil,
                          pin: "🇰🇭")

public let macao = Annotation(at: CLLocationCoordinate2D(latitude: 22.1987, longitude: 113.5439),
                       title: "Macao", subtitle: nil,
                       pin: "🇲🇴")

public let japan = Annotation(at: CLLocationCoordinate2D(latitude: 35.6895, longitude: 139.6917),
                       title: "Japan", subtitle: nil,
                       pin: "🇯🇵")

public let cities = [angers, hongkong, macao, uk, ireland, germany, china, morocco, czech, belgium, italy, luxembourg, greece, spain, vietnam, myanmar, thailand, cambodia, japan]

/// This pin is me
public let plane = Annotation(at: CLLocationCoordinate2D(latitude: angers.coordinate.latitude - 0.4,
                                                  longitude: angers.coordinate.longitude + 0.8),
                       title: "Me 👨🏼‍💻", subtitle: nil,
                       pin: "🛩")

/// Intermediate middle point
public let center = CLLocationCoordinate2D(latitude: 37.758818, longitude: 64.346717)
