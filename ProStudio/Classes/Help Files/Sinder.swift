//
//  Sinder.swift
//  FamilyApp
//
//  Created by Add Creative Inc. on 09.06.16.
//  Copyright © 2016 Add Creative Inc. All rights reserved.
//

import UIKit    
import MapKit

public let defaults = UserDefaults.standard

public extension CLLocationCoordinate2D {
    func toLocation() -> CLLocation {
        return CLLocation(latitude: self.latitude, longitude: self.longitude)
    }
}

public extension UINavigationController {
    func hide() {
        navigationBar.isHidden = true
    }

    func show() {
        navigationBar.isHidden = false
    }
}



public extension UIView {

    public var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }

//    public var cornerRadius: CGFloat {
//        get {
//            return self.layer.cornerRadius
//        }
//        set {
//            self.layer.cornerRadius = newValue
//
//            // Don"t touch the masksToBound property if a shadow is needed in addition to the cornerRadius
//            if shadow == false {
//                self.layer.masksToBounds = true
//            }
//        }
//    }


    public func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                          shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                          shadowOpacity: Float = 0.4,
                          shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}


public enum transferMethod {
    case push
    case pop
    case present
    case show
}

public extension UITableView {
    func indexPathForView(view: AnyObject) -> IndexPath? {
        let originInTableView = self.convert(CGPoint.zero, from: (view as! UIView))
        return self.indexPathForRow(at: originInTableView)
    }
}

public extension Date {

    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }

    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }

    func convertFormateToNormDateString(format: String) -> String {
        let dateFormatter = DateFormatter()
				dateFormatter.locale = Locale.init(identifier: "ru")
        dateFormatter.dateFormat = format
        let timeStamp = dateFormatter.string(from: self)

        return timeStamp
    }

    var startOfDay: NSDate {
        return NSCalendar.current.startOfDay(for: self) as NSDate
    }

    var endOfDay: NSDate? {
        let components = NSDateComponents()
        components.day = 1
        components.second = -1
        return NSCalendar.current.date(byAdding: components as DateComponents, to: startOfDay as Date)! as NSDate
    }
}

extension NSLayoutConstraint {
	static func quadroAspect(on view: UIView) -> NSLayoutConstraint {
		return NSLayoutConstraint.init(item: view, attribute: .height, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
	}
	static func contraints(withNewVisualFormat vf: String, dict: [String: Any]) -> [NSLayoutConstraint] {
		let separatedArray = vf.split(separator: ",")
		switch separatedArray.count {
		case 1: return NSLayoutConstraint.constraints(withVisualFormat: "\(separatedArray[0])", options: [], metrics: nil, views: dict)
		case 2: return NSLayoutConstraint.constraints(withVisualFormat: "\(separatedArray[0])", options: [], metrics: nil, views: dict) + NSLayoutConstraint.constraints(withVisualFormat: "\(separatedArray[1])", options: [], metrics: nil, views: dict)
		default: return NSLayoutConstraint.constraints(withVisualFormat: "\(separatedArray[0])", options: [], metrics: nil, views: dict)
		}
	}
}

extension NSLayoutConstraint {
	static func centerY(for sview: UIView, to view: UIView) -> NSLayoutConstraint {
		return NSLayoutConstraint.init(item: sview, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
	}
	
	static func centerX(for sview: UIView, to view: UIView) -> NSLayoutConstraint {
		return NSLayoutConstraint.init(item: sview, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
	}
	
	static func set(size: CGSize, for view: UIView) -> [NSLayoutConstraint] {
		return [NSLayoutConstraint.init(item: view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: size.height)] + [NSLayoutConstraint.init(item: view, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: size.width)]
	}
}

extension String {
    func remove(text: String) -> String {
        return replacingOccurrences(of: text, with: "")
    }
}


func locationWithBearing(bearing:Double, distanceMeters:Double, origin:CLLocationCoordinate2D) -> CLLocationCoordinate2D {
    let distRadians = distanceMeters / (6372797.6) // earth radius in meters
    
    let lat1 = origin.latitude * Double.pi / 180
    let lon1 = origin.longitude * Double.pi / 180
    
    let lat2 = asin(sin(lat1) * cos(distRadians) + cos(lat1) * sin(distRadians) * cos(bearing))
    let lon2 = lon1 + atan2(sin(bearing) * sin(distRadians) * cos(lat1), cos(distRadians) - sin(lat1) * sin(lat2))
    
    return CLLocationCoordinate2D(latitude: lat2 * 180 / Double.pi, longitude: lon2 * 180 / Double.pi)
}

public extension UIViewController {

    func nc() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }

    
    func prevVC(with offset: Int = 2) -> UIViewController {
        return navigationController!.children[navigationController!.children.count - offset]
    }
    
    func resignAllTextFields() {
        view.endEditing(true)
    }
    
    func showAlertWithOneAction(title: String, message: String, handle: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            handle()
        }
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func setImage(image: UIImage, toView: UIView) {
        let replaceView = UIImageView(image: image)
        replaceView.translatesAutoresizingMaskIntoConstraints = false
        replaceView.contentMode = .scaleToFill
        self.view.addSubview(replaceView)
        self.view.sendSubviewToBack(replaceView)
        
        let top = NSLayoutConstraint(item: replaceView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: replaceView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: replaceView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: replaceView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        
        view.addConstraints([top, leading, trailing, bottom])
    }
    
    func isModal() -> Bool {
        
        if let navigationController = self.navigationController{
            if navigationController.viewControllers.first != self{
                return false
            }
        }
        
        if self.presentingViewController != nil {
            return true
        }
        
        if self.presentingViewController?.presentedViewController == self {
            return true
        }
        
        if self.navigationController?.presentingViewController?.presentedViewController == self.navigationController  {
            return true
        }
        
        if self.tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        
        return false
    }
    
    // open new VC
    func transferVCwith(identifier: String, method: transferMethod) {
        if method == .pop {
            _ = navigationController?.popViewController(animated: true)
        } else if method == .present {
            let vc = self.storyboard!.instantiateViewController(withIdentifier: identifier)
            self.present(vc, animated: true, completion: nil)
        } else if method == .push {
            self.navigationController?.pushViewController(self.storyboard!.instantiateViewController(withIdentifier: identifier), animated: true)
        } else if method == .show {
            self.show(self.storyboard!.instantiateViewController(withIdentifier: identifier), sender: self)
        }
    }
    
    func presentWithNC(withIdentifier identifier: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    //easy way to show alert
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "ОK", style: UIAlertAction.Style.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWithActions(title: String, message: String, withCancelButton: Bool, buttons: [(title: String, action: () -> Void)]) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for button in buttons {
            let okAction = UIAlertAction(title: button.title, style: UIAlertAction.Style.default) {
                UIAlertAction in
                button.action()
            }
            alertController.addAction(okAction)
        }
        
        let cancelAction = UIAlertAction(title: "Отменить", style: .default, handler: nil)
        if withCancelButton {
            alertController.addAction(cancelAction)
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func smartBack() {
        if isModal() {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }

}


//checking email string is valid
func isValid(email : String) -> Bool {
    
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    
    if emailTest.evaluate(with: email) {
        return true

    }
    return false
}

public extension Array {
    func contains(index: Int) -> Bool {
        return index >= 0 && count - 1 >= index
    }
}


func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
    URLSession.shared.dataTask(with: url) {
        (data, response, error) in
        completion(data, response, error)
        }.resume()
}

func ID() -> String {
    let time = String(Int(NSDate().timeIntervalSince1970), radix: 16, uppercase: false)
    let machine = String(arc4random_uniform(900000) + 100000)
    let pid = String(arc4random_uniform(9000) + 1000)
    let counter = String(arc4random_uniform(900000) + 100000)
    return time + machine + pid + counter
}

//delay in seconds with closure
func delay(delay:Double, closure:@escaping ()->()) {
    
    let when = DispatchTime.now() + delay // change 2 to desired number of seconds
    DispatchQueue.main.asyncAfter(deadline: when) {
        closure()

    }
}

extension NotificationCenter {
    func post(notification name: String) {
        post(name: NSNotification.Name.init(name), object: nil)
    }
}

//set image to imageView from string
extension UIImageView {
    convenience init(string: String) {
        self.init(image: UIImage(named: string))
    }
}
extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ quality: JPEGQuality) -> Data? {
        return self.jpegData(compressionQuality: quality.rawValue)
    }
}
extension UIColor {
    //UIColor from HEX
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
extension Date {
    func dayOfTheWeek() -> String? {
        let weekdays = [
            L.s("sun"),
            L.s("mon"),
            L.s("tue"),
            L.s("wed"),
            L.s("thu"),
            L.s("fri"),
            L.s("sat")
        ]
        
        let components = Calendar.current.component(.weekday, from: self)
        return weekdays[components - 1]
    }
}

class L {
    class func s(_ text: String) -> String {
        return NSLocalizedString(text, comment: "")
    }
}

extension UIImage {
	
	func alpha(_ value:CGFloat) -> UIImage {
		UIGraphicsBeginImageContextWithOptions(size, false, scale)
		draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return newImage!
	}
}
