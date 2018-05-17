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

class ViewController: UIViewController {

    var nasaImageURL = [String]()
    var nasaDate = [String]()
    var nasaTitle = [String]()
    //let params = ["date": "2018-05-16"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        Alamofire.request(Configure.API_KEY).responseJSON { (responseData) in
            
            if responseData.result.isSuccess {
                
                if let json = responseData.result.value {
                    if let jsonDict = json as? [[String: Any]] {
                        
                        for nasaData in jsonDict {
                            if let url = nasaData["url"] as? String, let date = nasaData["date"] as? String, let title = nasaData["title"] as? String {
                                self.nasaImageURL.append(url)
                                self.nasaDate.append(date)
                                self.nasaTitle.append(title)
                            }
                        }
                        
                    }
                }
            } else {
                print("Failed to get JSON Data",responseData.result.error!)
            }
            self.collectionView.reloadData()
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
        return nasaImageURL.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifer, for: indexPath) as! CustomCollectionViewCell
        
        if nasaImageURL.count > 0 {
            print("Images URL : \(self.nasaImageURL[indexPath.row])")
            let url = URL(string: self.nasaImageURL[indexPath.row])
            cell.nasaImageView.af_setImage(withURL: url!)
        }

        cell.nameOfTheImage.text = "\(nasaTitle[indexPath.row])"
        cell.dateLabel.text = "\(nasaDate[indexPath.row])"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let moveToDetailedVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailedVC") as! DetailedVC
        self.navigationController?.pushViewController(moveToDetailedVC, animated: true)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
}

