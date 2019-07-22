//
//  ImageVC.swift
//  Employees World
//
//  Created by Waseem Wani on 25/06/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import Foundation
import UIKit

class ImageVC : UIViewController {
    var imageURL : String?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.startAnimating()
        loadImage(from: imageURL ?? "")
    }
    
    func loadImage(from imageLink: String) {
        if let imageUrl = URL(string: imageLink) {
            UIImage.loadFrom(url: imageUrl, completion: {image in
                self.imageView.image = image
                self.loader.stopAnimating()
                self.loader.isHidden = true
            })
        }
    }
}


extension UIImage {
    
    public static func loadFrom(url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            } else {
                DispatchQueue.main.async {
                    let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
                    let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
                    let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true).first
                    let path: String = paths!
                    let dirPath = path.replacingOccurrences(of: "Documents", with: "tmp")
                    let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("\(url)")
                    let image = UIImage(contentsOfFile: imageURL.path)
                    completion(image)
                }
            }
        }
    }
}
