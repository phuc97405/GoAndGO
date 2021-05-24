import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    GMSServices.provideAPIKey("AIzaSyCpIBMc9L8hDjy8Vzn9Dh2KIMQrI_5ME2s")
//    GMSPlacesClient.provideAPIKey("AIzaSyCpIBMc9L8hDjy8Vzn9Dh2KIMQrI_5ME2s")

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
