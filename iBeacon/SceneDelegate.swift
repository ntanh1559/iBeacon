//
//  SceneDelegate.swift
//  iBeacon
//
//  Created by bosua on 6/8/22.
//

import UIKit
import SwiftUI
import CoreLocation
class SceneDelegate: UIResponder, UIWindowSceneDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var locationManager: CLLocationManager!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
//        LocationManager = CLLocationManager()
//        locationManager.delegate = self
           locationManager = CLLocationManager()
           locationManager.delegate = self
           locationManager.desiredAccuracy = kCLLocationAccuracyBest
           locationManager.requestAlwaysAuthorization()
           locationManager.requestWhenInUseAuthorization()
           locationManager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    let uuid = UUID(uuidString: "fda50693-a4e2-4fb1-afcf-c6eb07647825")!
                    //let uuid = UUID(uuidString: "08f579de-c754-39df-7242-678d10ac1005")!
                    let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 100, minor: 1000, identifier: "RDL52810")
                    self.locationManager.startMonitoring(for: beaconRegion)
                    self.locationManager.startRangingBeacons(in: beaconRegion)
                }
            }
        }else{
            print("Status is \(status == .authorizedAlways)")
        }
    }
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if beacons.count > 0 {
//            updateDistance(beacons[0].proximity)
            print("\(beacons.count) beacons found.")
            print("\(beacons[0].proximity) dist.")
            for beacon in beacons{
                //if(beacon.minor==1000){
//                    print("---------------------")
//                    print("Name \(beacon.description)")
//                    print("UUID \(beacon.uuid)")
//                    print("major \(beacon.major)")
//                    print("minor \(beacon.minor)")
                    print("rssi \(beacon.rssi)")
//                    print("debugDescription \(beacon.debugDescription)")
                    print("proximity \(beacon.proximity.rawValue)")
                //}
            }
        } else {
            print("No beacons found.")
        }
    }
    
    // MARK: Location Manager Delegate methods
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
   {
       let locationsObj = locations.last! as CLLocation
       print("Current location lat-long is = \(locationsObj.coordinate.latitude) \(locationsObj.coordinate.longitude)")
   }
   func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       print("Get Location failed")
   }
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

