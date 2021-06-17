import UIKit
import Flutter
import VisaNetSDK

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
  var navigationController: UINavigationController!
//  var resultNiubiz : FlutterResult!
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    linkNativeCode(controller: controller)
    
    GeneratedPluginRegistrant.register(with: self)
    
    self.navigationController = UINavigationController(rootViewController: controller)
    self.window.rootViewController = self.navigationController
    self.navigationController.setNavigationBarHidden(true, animated: false)
    self.window.makeKeyAndVisible()
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
}

extension AppDelegate {
    
    func linkNativeCode(controller: FlutterViewController) {
        setupMethodChannelForNiubiz(controller: controller)
    }
    
    private func setupMethodChannelForNiubiz(controller: FlutterViewController) {
        
        let niubizChannel = FlutterMethodChannel(name: "com.ksandon.niubiz/flutterNiubizSdk",
                                                      binaryMessenger: controller.binaryMessenger)
        
        niubizChannel.setMethodCallHandler({
              (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            if call.method == "niubizBridgeSDK" {
                let vc = UIStoryboard.init(name: "Main", bundle: .main)
                                        .instantiateViewController(withIdentifier: "NiubizViewController") as! NiubizViewController
                if let args = call.arguments as? Dictionary<String, Any>,
                    let mdd = args["mdd"] as? [String:Any],
                    let config = args["config"] as? [String:String] {
                        vc.niubizResult = result
                        vc.mdd = mdd
                        vc.config = config
                        self.navigationController.pushViewController(vc, animated: true)
                  } else {
                    result(FlutterError.init(code: "bad args", message: nil, details: nil))
                  }
            }
        })
    }
}
