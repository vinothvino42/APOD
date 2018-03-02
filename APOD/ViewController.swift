//
//  ViewController.swift
//  APOD
//
//  Created by Vinoth Vino on 11/01/18.
//  Copyright © 2018 Coder Earth. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

extension UIImageView{
    
    func setImageFromURl(stringImageUrl url: String){
        
        if let url = NSURL(string: url) {
            if let data = NSData(contentsOf: url as URL) {
                self.image = UIImage(data: data as Data)
            }
        }
    }
}

class ViewController: UIViewController {

   // var names = ["Bright Planetary Nebula", "Clouds of Andromeda", "Dragons Heart", "Merging Galaxies", "Planets on the Wing", "Teather in Space"]
  //  var images = ["bright planetary nebula.jpg", "clouds of andromeda.jpg", "dragons heart.jpg", "merging galaxies", "planets on the wing.jpg", "tether in space.jpg"]

    var imageURLs = [String]()
    let params = ["date": "2018-03-02"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        customizingNavigationController()
        requestingUrlWithAF()
    }
    
    func customizingNavigationController() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func requestingUrlWithAF() {
        
        Alamofire.request(Configure.API_KEY, parameters: params).responseJSON { (responseData) in
            
            if responseData.result.value != nil {
                let swiftyJSONValues = JSON(responseData.result.value!)
                print("JSON Response datas ",swiftyJSONValues)
                guard let data = swiftyJSONValues["url"].string else { return }
                self.imageURLs.append(data)
                print("Nasa array of images \(self.imageURLs[0])")
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        requestingUrlWithAF()
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifer, for: indexPath) as! CustomCollectionViewCell
        
        if imageURLs.count > 0 {
            print("Images URL : \(self.imageURLs[0])")
            let url = URL(string: self.imageURLs[0])
            cell.nasaImageView.af_setImage(withURL: url!)
        }
        
        
        //        cell.nameOfTheImage.text = names[indexPath.row]
        cell.nameOfTheImage.text = "New Image"
        cell.dateLabel.text = "Date : 12/01/2018"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let moveToDetailedVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailedVC") as! DetailedVC
        self.navigationController?.pushViewController(moveToDetailedVC, animated: true)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
}

