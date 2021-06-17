//
//  NiubizViewController.swift
//  Runner
//
//  Created by VISANET PERÙ on 14/03/21.
//

import Foundation
import UIKit
import VisaNetSDK

class NiubizViewController: UIViewController {
    
    var niubizResult: FlutterResult!
    var mdd: [String:Any]!
    var config: [String:String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Config.securityToken = config["token"]!
        Config.CE.endPointDevURL = config["endpoint"]!
        Config.CE.dataChannel = .mobile
        Config.merchantID = config["merchantID"]!
        Config.CE.purchaseNumber = config["purchase"]!
        Config.amount = (config["amount"]! as NSString).doubleValue
        // Configurar logo
        // Config.CE.Header.type = .logo
        // Config.CE.Header.logoImage = UIImage(named: "icon_logo_apple")
        // Configurar texto
        Config.CE.Header.type = .text
        Config.CE.Header.titleText = "Integraciones VisaNet"
        Config.CE.type = .dev
        Config.CE.showAmount = true
        // Hexadecimal a UIColor => https://www.uicolor.io/
        Config.CE.buttonColor = UIColor(red: 0.16, green: 0.88, blue: 0.54, alpha: 1)
        Config.CE.FirstNameField.defaultText = config["name"]!
        Config.CE.LastNameField.defaultText = config["lastname"]!
        Config.CE.EmailField.defaultText = config["email"]!
        Config.PINSHA256DEV = config["pin"]!
        //Config.PINSHA256DEV = "++MBgDH5WGvL9Bcn5Be30cRcL0f5O+NyoXuWtQdX1aI="
        //Config.PINSHA256DEV = "lmxiL6uol7hb4UwDxtk2qbF2lBnJc7zqZRT6sFfYWEE="
        
        // CONFIGURACIÓN DE MDD'S
        Config.CE.Antifraud.merchantDefineData = mdd
        
        _ = VisaNet.shared.presentVisaPaymentForm(viewController: self)
        VisaNet.shared.delegate = self
        
    }

}

extension NiubizViewController: VisaNetDelegate {
  func registrationDidEnd(serverError: Any?, responseData:Any?) {
      var message = ""
      var data = "";
      if serverError == nil {
          message = "DATA: \(String(describing: responseData))"
          data = "\(String(describing: responseData))"
      } else {
          message = "ERROR: \(String(describing: serverError))"
          print(responseData)
            data = "\(String(describing: responseData))"
      }
      print(message)
      niubizResult(data)
    
    self.navigationController?.popViewController(animated: true)
  }
}
