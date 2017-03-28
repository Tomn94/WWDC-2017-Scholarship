import UIKit
import MapKit
#if !os(iOS)
import PlaygroundSupport
#endif

/*public var tilesNumbersNeededForiPad97Inches = [(x: Int, y: Int, z: Int)]()*/

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

/// Tile overlay supporting offline mode.
/// Loads tiles from disk, if not cached uses Apple Maps API and writes the result to disk if `caching` is activated.
class OfflineTileOverlay: MKTileOverlay {
    
    /// API to get the files from.
    /// Should containt `%d` respectively for z, x, y
    static let tileAPIURL = "https://cdn1.apple-mapkit.com/tp/tile?type=tile&size=1&lang=en&imageFormat=jpg&vendorkey=38da783db1ef0c2d9f8e783a063ffcdc6a6330fe&z=%d&x=%d&y=%d"
    
    /// Cache path
#if os(iOS)
    static let cacheFolder = Bundle.main.url(forResource: "avatar", withExtension: "jpg")?.deletingLastPathComponent()
                              ?? URL(fileURLWithPath: "")
#else
    static let cacheFolder = Bundle.main.url(forResource: "avatar", withExtension: "jpg")!.deletingLastPathComponent()
                              ?? playgroundSharedDataDirectory.appendingPathComponent("tiles", isDirectory: true)
#endif
    
    /// Allow writing tiles to disk for caching (reading is always on)
    var cacheTiles = false
    
    /// Destination for writing cache to disk.
    /// In ~/Documents/Shared Playground Data/ on macOS
#if os(iOS)
    static let cacheWriteDestination = Bundle.main.url(forResource: "avatar", withExtension: "jpg")?.deletingLastPathComponent()
                                        ?? URL(fileURLWithPath: "")
#else
    static let cacheWriteDestination = playgroundSharedDataDirectory.appendingPathComponent("tiles", isDirectory: true)
#endif
    
    /// URL to get the tile from
    ///
    /// - Parameter path: Tile position and zoom level
    /// - Returns: URL to get the tile data
    override func url(forTilePath path: MKTileOverlayPath) -> URL {
        return URL(string: String(format: OfflineTileOverlay.tileAPIURL, path.z, path.x, path.y))!
    }
    
    /// Load tile from cache, or API and eventually cache it
    ///
    /// - Parameters:
    ///   - path: Tile position and zoom level
    ///   - result: tile raw data and eventual error
    override func loadTile(at path: MKTileOverlayPath,
                           result: @escaping (Data?, Error?) -> Void) {
        
        /* Get cached tile path */
        let filePath = OfflineTileOverlay.cacheFolder.appendingPathComponent(String(format: "tile-%d-%d-%d.jpg", path.z, path.x, path.y))
        /*tilesNumbersNeededForiPad97Inches.append((x: path.x, y: path.y, z: path.z))*/
        
        if FileManager.default.fileExists(atPath: filePath.path) {
            
            /* If cached, read from disk */
            do {
                let data = try Data(contentsOf: filePath)
                result(data, nil)
            } catch {
                result(nil, nil)
                print("Error while loading tile at path:" + filePath.path)
            }
            
        } else {
            
            /* If not cached, get tile URL back */
            let request = URLRequest(url: url(forTilePath: path))
            
            /* Launch data request */
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
            let dataTask = session.dataTask(with: request, completionHandler: { [weak self] data, resp, error in
                
                /* If we got data, cache it */
                if let strongSelf = self,
                   strongSelf.cacheTiles,
                   let data = data {
                    do {
                        let filePath = OfflineTileOverlay.cacheWriteDestination.appendingPathComponent(String(format: "tile-%d-%d-%d.jpg", path.z, path.x, path.y))
                        try data.write(to: filePath)
                    } catch {
                        print("Error while writing tile to disk:" + filePath.path)
                    }
                    /*DispatchQueue.global(qos: .background).async {
                    }*/
                }
                
                /* Give data back to the handler */
                result(data, error)
            })
            dataTask.resume()
        }
    }
    
}

/// Helps setting up the map view
public class MapDelegate: NSObject, MKMapViewDelegate {
    
    
    /// Size of all the annotations on the map
    public var pinSize: CGFloat = 42
    
    
    /// Offline map tile overlay
    var tileOverlay: OfflineTileOverlay?
    
    /// Map view associated to this delegate
    public var map: MKMapView?
    
    /// Allow writing tiles to disk for caching (reading is always on)
    public var cacheTiles = false
    
    
    // MARK: Annotations
    
    /// Configures the pins on the map with their icon
    ///
    /// - Parameters:
    ///   - mapView: Map view to populate
    ///   - annotation: Associated pin annotation
    /// - Returns: The view for the associated annotation
    public func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        /* Custom annotation from emoji */
        let view = MKAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        view.image = image(from: (annotation as! Annotation).pin,
                           size: pinSize)
        view.canShowCallout = true
        
        return view
    }
    
    
    // MARK: Overlay
    
    /// Basic rendering configuration for the overlay
    ///
    /// - Parameters:
    ///   - mapView: Map view to draw the overlay on
    ///   - overlay: Overlay to be displayed
    /// - Returns: The overlay renderer for a given tile overlay type
    public func mapView(_ mapView: MKMapView,
                        rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        guard let tileOverlay = overlay as? MKTileOverlay else {
            return MKOverlayRenderer()
        }
        
        /* Offline tyle overlay renderer */
        return MKTileOverlayRenderer(tileOverlay: tileOverlay)
    }
    
    /// Setup offline map overlay
    public func reloadTiles() {
        
        guard let map = map else { return }
        
        /* Erase any previous tile */
        if self.tileOverlay != nil {
            map.remove(self.tileOverlay!)
        }
        
        /* Create cache directory if doesn't exist */
        let fileManager = FileManager.default
        var isDir: ObjCBool = true
        if !fileManager.fileExists(atPath: OfflineTileOverlay.cacheFolder.path, isDirectory: &isDir) {
            
            do {
                try fileManager.createDirectory(at: OfflineTileOverlay.cacheFolder, withIntermediateDirectories: true)
            } catch {
                print("Error while creating cache folder")
            }
        }
        
        /* Create the map overlay, replacing MapKit original one */
        self.tileOverlay = OfflineTileOverlay()
        self.tileOverlay?.cacheTiles = self.cacheTiles
        self.tileOverlay?.canReplaceMapContent = true
        map.insert(self.tileOverlay!, at: MKOverlayLevel.aboveLabels.rawValue)
    }
    
}

/* Create pins */
public let france = Annotation(at: CLLocationCoordinate2D(latitude: 47.493404, longitude: -0.550958),
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
                       title: "China", subtitle: "Shanghai Summer School",
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
                       title: "Italy", subtitle: nil,
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

/// This pin is me
public let plane = Annotation(at: CLLocationCoordinate2D(latitude: france.coordinate.latitude - 0.4,
                                                  longitude: france.coordinate.longitude + 0.8),
                       title: "Me 👨🏼‍💻", subtitle: nil,
                       pin: "🛩")

/// Intermediate middle point
public let center = CLLocationCoordinate2D(latitude: 37.758818, longitude: 64.346717)
