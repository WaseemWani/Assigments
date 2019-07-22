//
//  GalleryVC.swift
//  Employees World
//
//  Created by Waseem Wani on 24/04/19.
//  Copyright © 2019 TTN. All rights reserved.
//


//
import UIKit

class GalleryVC: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadMoreBtn: UIButton!
    
    var isSubGalleryVC = false
    var isMainGalleryVc = true
    var empId: Int32 = 0
    var imagetitle = [String]() // this will store titles of images recieved from api
    var imageLink = [String]() // this will store image links
    var thumbNailLink = [String]()  // this will store thumbnail links
    var startIndex = 1
    var itemCount = 10
    var query = "Mango"
    var galleryImages = [String]()
    var selectedThumbnailLinks = [String]()
    
    var isSelectionBtnPressed = false
    //var willSaveImages = false
    //var savedImages = [String]()
    var fetchingMore = false
    
    @IBOutlet weak var selectionBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeView(view: loadMoreBtn, crnrRadius: 10, bdrWidth: 0, brdrClr: .white, alphaValue: 0.7)
        //DBManager.sharedInstance.deleteData(modelType: CoreDataModelType<Gallery>.selectedImages)
        print(UserDefaults.standard.bool(forKey: "isloggedIn"))
        let nib = UINib.init(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CollectionViewCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        if isMainGalleryVc == false && isSubGalleryVC == false {
            addSearchBar()
        } else if isMainGalleryVc {
            selectionBtn.isHidden = true
            collectionView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectImagesBtnTapped(_ sender: Any) {
        print("btn pressedd")
        
        if isSelectionBtnPressed == false {
            print("selected btn tapped")
            selectionBtn.setTitle("Done", for: .normal)
            isSelectionBtnPressed = true
            collectionView.reloadData()
            // perform selection of images
        } else {
            print("done btn pressed")
            selectionBtn.setTitle("Select", for: .normal)
            isSelectionBtnPressed = false
            collectionView.reloadData()
            //            willSaveImages = true
            saveImageLinks()
        }
        //handle selection of images recieved from google here
    }
    
    func addSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
        searchController.searchBar.tintColor = UIColor.black
        searchController.searchBar.sizeToFit()
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        searchController.searchBar.placeholder = "Search for images on Google"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func callgoogleAPI() {
        
        let cx = "018004629090563794309:4-knw3rlcoo"
        let key = "AIzaSyDIUO4kqd6rHZEbNg5-phC6z6-jmHD0jLI"
        NetwokManager.fetchData(urlRequest: RequestType<GoogleImages>.googleImages(query, key, cx, startIndex, itemCount)) {
            (result) in
            
            switch result {
            case .sucess(let response) :
                  let googleImages = [response]
                for images in googleImages {
                    for item in images.items!{
                        self.imagetitle.append(item.title!)
                        self.imageLink.append(item.link!)
                        self.thumbNailLink.append((item.image?.thumbnailLink)!)
                    }
                }
                self.collectionView.reloadData()
                self.hideErrorView()
                break

            case .error(let error):
                self.showErrorView(onView: self.view, error.localizedDescription, #imageLiteral(resourceName: "error"), retryBtnText: "Retry")
                break
            }
        }
    }
}

extension GalleryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CustomizedView {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isMainGalleryVc {
            let imageCount = DBManager.sharedInstance.getRecordsCount(modelType: CoreDataModelType<Gallery>.selectedImages)
            print("cell count", imageCount)
            return imageCount
        } else if isSubGalleryVC {
            let imageCount = DBManager.sharedInstance.getRecordsCount(modelType: CoreDataModelType<Gallery>.selectedImagesById(empId))
            return imageCount   // return count of images for currently selected employee
        } else {
            return imageLink.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.loader.isHidden = false
        cell.loader.startAnimating()
        customizeView(view: cell)
    
        if isMainGalleryVc {
            cell.loader.isHidden = false
            cell.loader.startAnimating()
            let fetchedResultController = DBManager.sharedInstance.retrieveData(modelType: CoreDataModelType<Gallery>.selectedImages)
            try? fetchedResultController?.performFetch()
            let fetchedThumbNails = fetchedResultController?.fetchedObjects
            //print(fetchedThumbNails?[indexPath.row].thumbnailURL)
            if let url = URL(string: fetchedThumbNails?[indexPath.row].thumbnailURL ?? "") {
                print("url", url)
                UIImage.loadFrom(url: url, completion: { image in
                    cell.imageView.image = image
                    cell.loader.stopAnimating()
                    cell.loader.isHidden = true
                })
            }
            return cell
        } else if isSubGalleryVC {
            
            let fetchedResultController = DBManager.sharedInstance.retrieveData(modelType: CoreDataModelType<Gallery>.selectedImagesById(empId))
            try? fetchedResultController?.performFetch()
            let fetchedImages = fetchedResultController?.fetchedObjects
            
            let url = URL(string: fetchedImages?[indexPath.row].imageURL ?? "")
            UIImage.loadFrom(url: url!, completion: { image in
                cell.imageView.image = image
                cell.loader.stopAnimating()
                cell.loader.isHidden = true
                //cell.imageTitle.text = self.imagetitle[indexPath.row]
            })
            return cell
        } else {

            if isSelectionBtnPressed {
                cell.selectionLabel.isHidden = false
                cell.selectionLabel.text = ""
                roundView(cell.selectionLabel, 0.5, .darkGray)
            } else if !isSelectionBtnPressed {
                cell.selectionLabel.isHidden = true
            }
            
            let url = URL(string: thumbNailLink[indexPath.row])
            UIImage.loadFrom(url: url!, completion: { image in
                cell.imageView.image = image
                cell.imageTitle.text = self.imagetitle[indexPath.row]
                cell.loader.stopAnimating()
                cell.loader.isHidden = true

            })
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ImageVC") as! ImageVC
        let currentCell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        
        if isMainGalleryVc {
            let fetchedResultsController = DBManager.sharedInstance.retrieveData(modelType: CoreDataModelType<Gallery>.selectedImages)
            try? fetchedResultsController?.performFetch()
            let fetchedImages = fetchedResultsController?.fetchedObjects
            vc.imageURL =  fetchedImages?[indexPath.row].imageURL
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else if isSubGalleryVC {
            let fetchedResultsController = DBManager.sharedInstance.retrieveData(modelType: CoreDataModelType<Gallery>.selectedImagesById(empId))
            try? fetchedResultsController?.performFetch()
            let fetchedImages = fetchedResultsController?.fetchedObjects
            // print(fetchedImages?[indexPath.row].imageURL)
            vc.imageURL = fetchedImages?[indexPath.row].imageURL
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else {
            if isSelectionBtnPressed {
                currentCell.selectionLabel.isHidden = false
                currentCell.selectionLabel.text = "✅"
                // var imagesArray = [String]()
                galleryImages.append(imageLink[indexPath.row])
                selectedThumbnailLinks.append(thumbNailLink[indexPath.row])
                //            if willSaveImages {
                //                saveImageLinks(selectedFrom: imagesArray)
                //            }
            }
            else if !isSelectionBtnPressed {
                vc.imageURL = imageLink[indexPath.row]
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width/3)-13.5
        //    let cellHeight = (collectionView.frame.height-30)
        return CGSize.init(width: cellWidth, height: cellWidth)
    }
    
    //    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    //    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    //
    //        print("dragging ended")
    //        if !(isMainGalleryVc || isSubGalleryVC) {
    //            self.startIndex +=  self.itemCount
    //            callgoogleAPI()
    //            print(self.startIndex)
    //        }
    //    }
    
    //
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print("scrolling...")
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        //print(offsetY, contentHeight)
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchingMore {
                fetchNewBatch()
            }
        }
    }
    
    func fetchNewBatch() {
        fetchingMore = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            print("scrolling...")
            //            self.startIndex +=  self.itemCount
            self.fetchingMore = false
            //            self.callgoogleAPI()
            //            self.collectionView.reloadData()
            //print(, contentHeight)
        })
    }
    
    // function to load a batch of images on tapping load more button 
        @IBAction func loadMoreBtnTapped(_ sender: Any) {
//            self.startIndex +=  self.itemCount
//            callgoogleAPI()
//            print(self.startIndex)
            print("load more button tapped")
        }
    
    func saveImageLinks() {
        print("google Images",galleryImages.count)
        print("iamge Links", galleryImages)
        for (image, thumbnail) in zip(galleryImages, selectedThumbnailLinks) {
            DBManager.sharedInstance.saveData(modelType: CoreDataModelType<Gallery>.selectedImages) {
                (result) in
                result.empId = Int32(self.empId)
                result.imageURL = image
                result.thumbnailURL = thumbnail
            }
        }
    }
}

extension GalleryVC : ErrorViewProtocol {
    func refreshScreen() {
        callgoogleAPI()
        print("screen refreshed")
    }
}

extension GalleryVC: UISearchControllerDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.query =  searchBar.text?.replacingOccurrences(of: " ", with: "%20") ?? ""
        
        if query != "" {
            imageLink = []
            thumbNailLink = []
            imagetitle = []
            callgoogleAPI()
        }
        print(self.query)
    }
}

//extension UIImageView {
//    func load(url: URL) {
//        DispatchQueue.global().async {
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.image = image
//                    }
//                }
//            }
//        }
//    }
//}
