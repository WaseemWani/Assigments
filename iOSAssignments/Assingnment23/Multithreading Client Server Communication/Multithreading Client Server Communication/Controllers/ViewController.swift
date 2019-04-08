//
//  ViewController.swift
//  Multithreading Client Server Communication
//
//  Created by Waseem Wani on 08/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var photosArray = [DataModel]() // array of type Struct DataModel, this will be used to fill the collection view cells
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Picsum Photos"
        
        getData()
        
        let nib = UINib.init(nibName: "PhotosCollectionViewCell", bundle: nil)
        photosCollectionView.register(nib, forCellWithReuseIdentifier: "PhotosCollectionViewCell")
    
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // function to fetch data from the api
    func getData() {
        
        let url = URL(string: "https://picsum.photos/list")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                if error == nil {
                    self.photosArray = try JSONDecoder().decode([DataModel].self, from: data!)
                    DispatchQueue.main.async {
                        self.photosCollectionView.reloadData()
                    
                    }
                   //print(self.photosArray)
                }
            }
                
            catch {
                print("error while fetching data!!Please try again. ")
               }
            
        }.resume()
}

}

// extension on of the above class, to implement delegate and data source methods
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as? PhotosCollectionViewCell
        
        let imageUrl = "https://picsum.photos/120/120?image=\(indexPath.row)"
        guard let url = URL(string: imageUrl) else {
            return cell!
        }
        
        UIImage.loadFrom(url: url) {
            image in cell?.recieveImage(image: image!)
        }
        
        cell?.showAuthorName(authorName: photosArray[indexPath.row].author)
        return cell!
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let imageDetails : ImageVC =  storyBoard.instantiateViewController(withIdentifier: "ImageVC") as! ImageVC
        imageDetails.openingUrl = photosArray[indexPath.row].author_url
        
        let imageurl = "https://picsum.photos/240/320?image=\(photosArray[indexPath.row].id+1)"
        guard let url = URL(string: imageurl) else
        {
            return
        }
        
        UIImage.loadFrom(url: url) { image in
            imageDetails.imageView.image = image
        }
        self.navigationController?.pushViewController(imageDetails, animated: true)

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
                    completion(nil)
                }
            }
        }
    }
}
