/*:
 - callout(Travel): I like to **discover** the world, here is where I had the chance to live or visit
 */
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

/// Displayed countries
let countries:    [MKAnnotation] = [/*#-editable-code Edit pins*/france, hongkong, macao, uk, ireland, germany, china, morocco, czech, belgium, italy, luxembourg, greece, spain, vietnam, myanmar, thailand, cambodia, japan/*#-end-editable-code*/]

//#-hidden-code

/// Enable caching to disk. Activate to create offline cache
let createCache = false

//: ## Create the map (main view)
let map = MKMapView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
/// Strong reference to the map view delegate
let delegate = MapDelegate()
delegate.cacheTiles = createCache
delegate.map = map
delegate.pinSize = pinSize
delegate.reloadTiles()
map.delegate = delegate
map.region = MKCoordinateRegionMake(france.coordinate,
                                    MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))

map.addAnnotations(countries)
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
    map.showAnnotations(countries, animated: true)
}

/* Lets me know which tiles I need to set offline for an iPad Air 2 9,7” viewport
Timer.scheduledTimer(withTimeInterval: 30, repeats: false) { _ in
    var tilesNeeded = ""
    for tile in tilesNumbersNeededForiPad97Inches {
        tilesNeeded += "\(tile.z)-\(tile.x)-\(tile.y),"
    }
    print(tilesNeeded)
    UIPasteboard.general.string = tilesNeeded
}
 */

//#-end-hidden-code