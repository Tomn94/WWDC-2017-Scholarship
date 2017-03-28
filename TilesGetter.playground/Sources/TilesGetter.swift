//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

public func launch() {
    
    /// Where tiles come from
    let tileAPIURL = "https://cdn1.apple-mapkit.com/tp/tile?type=tile&size=1&lang=en&imageFormat=jpg&vendorkey=38da783db1ef0c2d9f8e783a063ffcdc6a6330fe&z=%d&x=%d&y=%d"
    
    /// Where tiles will be saved
    let cacheFolder = playgroundSharedDataDirectory.appendingPathComponent("tiles", isDirectory: true)
    
    /// Tiles
    let values: [(z: Int, x: Int, y: Int)] = [(z: 7, x: 66, y: 47),(z: 7, x: 66, y: 44),(z: 7, x: 66, y: 48),(z: 7, x: 61, y: 46),(z: 7, x: 66, y: 45),(z: 7, x: 64, y: 44),(z: 7, x: 65, y: 44),(z: 7, x: 64, y: 45),(z: 7, x: 65, y: 45),(z: 7, x: 62, y: 44),(z: 7, x: 63, y: 44),(z: 7, x: 63, y: 45),(z: 7, x: 62, y: 45),(z: 7, x: 61, y: 44),(z: 7, x: 61, y: 45),(z: 7, x: 66, y: 42),(z: 7, x: 66, y: 43),(z: 7, x: 64, y: 42),(z: 7, x: 65, y: 42),(z: 7, x: 65, y: 43),(z: 7, x: 64, y: 43),(z: 7, x: 62, y: 42),(z: 7, x: 63, y: 42),(z: 7, x: 62, y: 43),(z: 7, x: 63, y: 43),(z: 7, x: 61, y: 42),(z: 7, x: 61, y: 43),(z: 7, x: 66, y: 41),(z: 7, x: 65, y: 41),(z: 7, x: 64, y: 41),(z: 7, x: 63, y: 41),(z: 7, x: 62, y: 41),(z: 7, x: 61, y: 41),(z: 7, x: 65, y: 46),(z: 7, x: 64, y: 46),(z: 7, x: 65, y: 47),(z: 7, x: 66, y: 46),(z: 7, x: 62, y: 46),(z: 7, x: 64, y: 47),(z: 7, x: 63, y: 46),(z: 7, x: 63, y: 47),(z: 7, x: 62, y: 47),(z: 7, x: 61, y: 47),(z: 7, x: 67, y: 47),(z: 7, x: 67, y: 44),(z: 7, x: 65, y: 48),(z: 7, x: 64, y: 48),(z: 7, x: 63, y: 48),(z: 7, x: 62, y: 48),(z: 7, x: 61, y: 48),(z: 7, x: 67, y: 48),(z: 7, x: 67, y: 45),(z: 7, x: 67, y: 42),(z: 7, x: 67, y: 43),(z: 7, x: 67, y: 41),(z: 7, x: 67, y: 46),(z: 6, x: 32, y: 24),(z: 6, x: 32, y: 25),(z: 6, x: 33, y: 24),(z: 6, x: 30, y: 24),(z: 6, x: 33, y: 25),(z: 6, x: 31, y: 24),(z: 6, x: 30, y: 25),(z: 6, x: 32, y: 22),(z: 6, x: 34, y: 24),(z: 6, x: 31, y: 25),(z: 6, x: 33, y: 22),(z: 6, x: 33, y: 23),(z: 6, x: 32, y: 23),(z: 6, x: 34, y: 25),(z: 6, x: 30, y: 22),(z: 6, x: 31, y: 22),(z: 6, x: 31, y: 23),(z: 6, x: 34, y: 22),(z: 6, x: 30, y: 23),(z: 6, x: 32, y: 20),(z: 6, x: 33, y: 20),(z: 6, x: 34, y: 23),(z: 6, x: 33, y: 21),(z: 6, x: 32, y: 21),(z: 6, x: 30, y: 20),(z: 6, x: 31, y: 20),(z: 6, x: 31, y: 21),(z: 6, x: 30, y: 21),(z: 6, x: 34, y: 20),(z: 6, x: 34, y: 21),(z: 6, x: 35, y: 24),(z: 6, x: 35, y: 25),(z: 6, x: 34, y: 26),(z: 6, x: 35, y: 26),(z: 6, x: 33, y: 26),(z: 6, x: 32, y: 26),(z: 6, x: 30, y: 26),(z: 6, x: 31, y: 26),(z: 6, x: 35, y: 22),(z: 6, x: 35, y: 23),(z: 6, x: 35, y: 20),(z: 5, x: 16, y: 12),(z: 5, x: 16, y: 13),(z: 5, x: 17, y: 12),(z: 5, x: 17, y: 13),(z: 5, x: 17, y: 14),(z: 5, x: 16, y: 14),(z: 5, x: 18, y: 12),(z: 5, x: 15, y: 13),(z: 5, x: 18, y: 13),(z: 5, x: 15, y: 12),(z: 5, x: 16, y: 10),(z: 5, x: 15, y: 14),(z: 5, x: 18, y: 14),(z: 5, x: 17, y: 10),(z: 5, x: 16, y: 11),(z: 5, x: 17, y: 11),(z: 5, x: 15, y: 10),(z: 5, x: 15, y: 11),(z: 5, x: 17, y: 9),(z: 5, x: 16, y: 9),(z: 5, x: 15, y: 9),(z: 5, x: 18, y: 10),(z: 5, x: 18, y: 11),(z: 5, x: 18, y: 9),(z: 5, x: 19, y: 10),(z: 5, x: 19, y: 11),(z: 5, x: 19, y: 12),(z: 5, x: 19, y: 9),(z: 5, x: 19, y: 13),(z: 5, x: 19, y: 14),(z: 6, x: 35, y: 21),(z: 5, x: 26, y: 14),(z: 5, x: 26, y: 15),(z: 5, x: 27, y: 14),(z: 5, x: 27, y: 15),(z: 5, x: 24, y: 14),(z: 5, x: 26, y: 16),(z: 5, x: 25, y: 14),(z: 5, x: 28, y: 14),(z: 5, x: 28, y: 15),(z: 5, x: 25, y: 15),(z: 5, x: 24, y: 15),(z: 5, x: 26, y: 12),(z: 5, x: 26, y: 13),(z: 5, x: 28, y: 16),(z: 5, x: 25, y: 16),(z: 5, x: 24, y: 16),(z: 5, x: 27, y: 16),(z: 5, x: 24, y: 12),(z: 5, x: 25, y: 12),(z: 5, x: 25, y: 13),(z: 5, x: 27, y: 12),(z: 5, x: 24, y: 13),(z: 5, x: 27, y: 13),(z: 5, x: 28, y: 13),(z: 5, x: 28, y: 12),(z: 6, x: 54, y: 30),(z: 6, x: 54, y: 31),(z: 6, x: 55, y: 30),(z: 6, x: 55, y: 31),(z: 6, x: 53, y: 30),(z: 6, x: 53, y: 31),(z: 6, x: 52, y: 30),(z: 6, x: 50, y: 30),(z: 6, x: 52, y: 31),(z: 6, x: 51, y: 30),(z: 6, x: 50, y: 31),(z: 6, x: 54, y: 28),(z: 6, x: 51, y: 31),(z: 6, x: 54, y: 29),(z: 6, x: 55, y: 28),(z: 6, x: 53, y: 28),(z: 6, x: 52, y: 28),(z: 6, x: 55, y: 29),(z: 6, x: 53, y: 29),(z: 6, x: 52, y: 29),(z: 6, x: 50, y: 28),(z: 6, x: 51, y: 28),(z: 6, x: 50, y: 29),(z: 6, x: 51, y: 29),(z: 6, x: 54, y: 26),(z: 6, x: 54, y: 27),(z: 6, x: 52, y: 26),(z: 6, x: 53, y: 26),(z: 6, x: 53, y: 27),(z: 6, x: 52, y: 27),(z: 6, x: 50, y: 26),(z: 6, x: 55, y: 26),(z: 6, x: 55, y: 27),(z: 6, x: 51, y: 26),(z: 6, x: 51, y: 27),(z: 6, x: 50, y: 27),(z: 6, x: 54, y: 25),(z: 6, x: 53, y: 25),(z: 6, x: 52, y: 25),(z: 6, x: 50, y: 25),(z: 6, x: 51, y: 25),(z: 6, x: 55, y: 25),(z: 7, x: 106, y: 56),(z: 7, x: 106, y: 57),(z: 7, x: 107, y: 56),(z: 7, x: 107, y: 57),(z: 7, x: 104, y: 56),(z: 7, x: 106, y: 58),(z: 7, x: 104, y: 57),(z: 7, x: 105, y: 56),(z: 7, x: 105, y: 57),(z: 7, x: 105, y: 58),(z: 7, x: 103, y: 56),(z: 7, x: 107, y: 58),(z: 7, x: 104, y: 58),(z: 7, x: 103, y: 57),(z: 7, x: 106, y: 54),(z: 7, x: 106, y: 55),(z: 7, x: 104, y: 54),(z: 7, x: 103, y: 58),(z: 7, x: 105, y: 54),(z: 7, x: 105, y: 55),(z: 7, x: 103, y: 54),(z: 7, x: 104, y: 55),(z: 7, x: 103, y: 55),(z: 7, x: 106, y: 53),(z: 7, x: 105, y: 53),(z: 7, x: 104, y: 53),(z: 7, x: 103, y: 53),(z: 7, x: 107, y: 54),(z: 7, x: 107, y: 55),(z: 7, x: 107, y: 53),(z: 12, x: 3348, y: 1788),(z: 12, x: 3348, y: 1789),(z: 12, x: 3349, y: 1788),(z: 12, x: 3346, y: 1788),(z: 12, x: 3348, y: 1790),(z: 12, x: 3349, y: 1789),(z: 12, x: 3346, y: 1789),(z: 12, x: 3347, y: 1789),(z: 12, x: 3347, y: 1788),(z: 12, x: 3347, y: 1790),(z: 12, x: 3349, y: 1790),(z: 12, x: 3345, y: 1788),(z: 12, x: 3345, y: 1789),(z: 12, x: 3346, y: 1790),(z: 12, x: 3348, y: 1786),(z: 12, x: 3348, y: 1787),(z: 12, x: 3346, y: 1786),(z: 12, x: 3347, y: 1786),(z: 12, x: 3347, y: 1787),(z: 12, x: 3345, y: 1790),(z: 12, x: 3346, y: 1787),(z: 12, x: 3345, y: 1786),(z: 12, x: 3345, y: 1787),(z: 12, x: 3348, y: 1784),(z: 12, x: 3348, y: 1785),(z: 12, x: 3346, y: 1784),(z: 12, x: 3347, y: 1784),(z: 12, x: 3349, y: 1786),(z: 12, x: 3347, y: 1785),(z: 12, x: 3346, y: 1785),(z: 12, x: 3349, y: 1787),(z: 12, x: 3345, y: 1784),(z: 12, x: 3345, y: 1785),(z: 12, x: 3349, y: 1784),(z: 12, x: 3349, y: 1785),(z: 3, x: 6, y: 4),(z: 3, x: 7, y: 4),(z: 3, x: 6, y: 5),(z: 3, x: 7, y: 5),(z: 3, x: 7, y: 6),(z: 3, x: 5, y: 4),(z: 3, x: 4, y: 4),(z: 3, x: 5, y: 5),(z: 3, x: 4, y: 5),(z: 3, x: 6, y: 6),(z: 3, x: 3, y: 4),(z: 3, x: 3, y: 5),(z: 3, x: 6, y: 2),(z: 3, x: 5, y: 6),(z: 3, x: 7, y: 2),(z: 3, x: 4, y: 6),(z: 3, x: 7, y: 3),(z: 3, x: 3, y: 6),(z: 3, x: 6, y: 3),(z: 3, x: 4, y: 2),(z: 3, x: 5, y: 2),(z: 3, x: 5, y: 3),(z: 3, x: 4, y: 3),(z: 3, x: 3, y: 2),(z: 3, x: 3, y: 3),(z: 3, x: 6, y: 0),(z: 3, x: 7, y: 0),(z: 3, x: 7, y: 1),(z: 3, x: 6, y: 1),(z: 3, x: 4, y: 0),(z: 3, x: 5, y: 0),(z: 3, x: 5, y: 1),(z: 3, x: 4, y: 1),(z: 3, x: 3, y: 0),(z: 3, x: 3, y: 1),(z: 3, x: 2, y: 2),(z: 3, x: 2, y: 3),(z: 3, x: 2, y: 4),(z: 3, x: 2, y: 1),(z: 3, x: 2, y: 5)]
    
    /// Counts new files
    var count = 0
    
    PlaygroundPage.current.needsIndefiniteExecution = true
    
    /* For each tile */
    for value in values {
        
        /* Tile file destination */
        let filePath = cacheFolder.appendingPathComponent(String(format: "tile-%d-%d-%d.jpg", value.z, value.x, value.y))
        
        /* If not already present */
        if !FileManager.default.fileExists(atPath: filePath.path) {
            
            let request = URLRequest(url: URL(string: String(format: tileAPIURL, value.z, value.x, value.y))!)
            
            /* Launch data request */
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
            let dataTask = session.dataTask(with: request, completionHandler: { data, resp, error in
                
                /* If we got data, save it */
                if let data = data {
                    do {
                        try data.write(to: filePath)
                        count += 1
                        print(count)
                    } catch {
                        print("Error while writing tile to disk:" + filePath.path)
                    }
                } else {
                    print("Nothing for: \(value.z)-\(value.x)-\(value.y)")
                }
            })
            dataTask.resume()
        }
    }
    
    /* Print number of tiles downloaded to file */
    let filePath = cacheFolder.appendingPathComponent("tiles.txt")
    do {
        try String(format: "%d", count).write(toFile: filePath.path, atomically: true, encoding: .utf8)
    } catch {
        print("Error while writing output")
    }

}
