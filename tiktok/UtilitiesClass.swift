//
//  UtilitiesClass.swift
//  tiktok
//
//  Created by Bharat shankar on 28/02/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD



//singleton class
final class SingleTon {
    
    private init() { }
    
    static let shared = SingleTon()
    
    var myselectedSongUrl = ""
}


// this method is to set gradinet color of background
func gradeientPatern(yourView:UIView, firstColor:CGColor , secondColor:CGColor)  {
    let gl: CAGradientLayer
    let colorTop = firstColor
    let colorBottom =  secondColor
    
    gl = CAGradientLayer()
    gl.colors = [colorTop, colorBottom]
    gl.locations = [0.0, 1.0]
    yourView.backgroundColor = UIColor.clear
    let backgroundLayer = gl
    backgroundLayer.frame = yourView.frame
    
    yourView.layer.insertSublayer(backgroundLayer, at: 0)
}

//shadow view
func shadowView(view: UIView)  {
    view.layer.masksToBounds = false
    view.layer.shadowColor = UIColor.gray.cgColor
    view.layer.shadowOpacity = 0.4
    view.layer.shadowOffset = CGSize.zero
    view.layer.shadowRadius = 3
    view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
    view.layer.shouldRasterize = true
    
}

func purpuleShadowView(view: UIView)  {
    view.layer.masksToBounds = false
    view.layer.cornerRadius = 15
    view.layer.shadowColor = #colorLiteral(red: 0.8549019608, green: 0.662745098, blue: 1, alpha: 1)
    view.layer.shadowOpacity = 0.6
    view.layer.shadowOffset = CGSize.zero
    view.layer.shadowRadius = 3
    view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
    view.layer.shouldRasterize = true
    
}


func showLoading(view : UIView){
    let spinnerActivity = MBProgressHUD.showAdded(to: view, animated: true)
    spinnerActivity.label.text = "Loading";
    //    spinnerActivity.detailsLabel.text = "Please Wait!!";
}



func hideLoading(view : UIView){
    MBProgressHUD.hide(for: view, animated: true)
}




func lineText(textBox: UITextField)  {
    
    let border = CALayer()
    let width = CGFloat(1.0)
    border.borderColor = UIColor.gray.cgColor
    border.frame = CGRect(x: 0, y: textBox.frame.size.height - width, width: textBox.frame.size.width, height: textBox.frame.size.height)
    
    border.borderWidth = width
    textBox.layer.addSublayer(border)
    textBox.layer.masksToBounds = true
    
}


extension UIColor {
    
    /// Converts this `UIColor` instance to a 1x1 `UIImage` instance and returns it.
    ///
    /// - Returns: `self` as a 1x1 `UIImage`.
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}


// email validation
func isValidEmail(testStr:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}

// mobile no. validation
func isValidPhoneNumber(_ phoneNumberString: String) -> Bool {
    
    var returnValue = true
    //        let mobileRegEx = "^[789][0-9]{9,11}$"
    let mobileRegEx = "^[0-9]{10}$"
    
    do {
        let regex = try NSRegularExpression(pattern: mobileRegEx)
        let nsString = phoneNumberString as NSString
        let results = regex.matches(in: phoneNumberString, range: NSRange(location: 0, length: nsString.length))
        
        if results.count == 0
        {
            returnValue = false
        }
        
    } catch let error as NSError {
        print("invalid regex: \(error.localizedDescription)")
        returnValue = false
    }
    
    return  returnValue
}



//hexa code for color
func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}


// this is to convert our nsstring response to json resonse
func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}

