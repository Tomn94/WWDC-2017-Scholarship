//: [Previous](@previous)

import MapKit
import PlaygroundSupport

func image(from emoji: String) -> UIImage? {
    
    let size = CGSize(width: 30, height: 30)
    UIGraphicsBeginImageContextWithOptions(size, false, 0);
    let rect = CGRect(origin: CGPoint.zero, size: size)
    (emoji as NSString).draw(in: rect, withAttributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 30)])
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
}

class Annotation: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var pin: String
    
    init(at coordinate: CLLocationCoordinate2D, title: String, subtitle: String?, pin: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.pin = pin
    }
}

class MapDelegate: NSObject, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = image(from: (annotation as! Annotation).pin)
        
        let view = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        view.image = pin
        view.canShowCallout = true
        
        return view
    }
}

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

let center = CLLocationCoordinate2D(latitude: 37.758818, longitude: 64.346717)

let plane = Annotation(at: angers.coordinate,
                       title: "Me", subtitle: nil,
                       pin: "✈️")

let delegate = MapDelegate()
let map = MKMapView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
map.delegate = delegate
map.mapType = .satellite
map.region = MKCoordinateRegionMake(angers.coordinate, MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))

map.addAnnotations(cities)
map.addAnnotation(plane)

PlaygroundPage.current.liveView = map

Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
    map.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2D(latitude: 43, longitude: 7.5),
                                         MKCoordinateSpan(latitudeDelta: 32, longitudeDelta: 32)), animated: true)
}
Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
    UIView.animate(withDuration: 9) {
        plane.coordinate = hongkong.coordinate
    }
}
Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { _ in
    map.setRegion(MKCoordinateRegionMake(hongkong.coordinate,
                                         MKCoordinateSpan(latitudeDelta: 30, longitudeDelta: 30)), animated: true)
}
Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
    map.setRegion(MKCoordinateRegionMake(hongkong.coordinate,
                                         MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)), animated: true)
}
Timer.scheduledTimer(withTimeInterval: 9, repeats: false) { _ in
    map.setRegion(MKCoordinateRegionMake(center,
                                         MKCoordinateSpan(latitudeDelta: 120, longitudeDelta: 120)), animated: true)
}

//: [Next](@next)
