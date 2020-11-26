//
//  SemanaViewController.swift
//  Autime
//
//  Created by Victor Vieira on 26/11/20.
//

// swiftlint:disable force_cast
// swiftlint:disable line_lenght

import UIKit

class SemanaViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var imagens: [PhotoDays] = [PhotoDays(photoDay: "12/11", title: "12/11", images: ["test1","test2","test3","test4","test5","test2","test3","test4","test5"]),
                                PhotoDays(photoDay: "13/11", title: "13/11", images: ["test3","test2","test5"]),
                                PhotoDays(photoDay: "14/11", title: "14/11", images: ["test2","test1","test4","test5",]),
                                PhotoDays(photoDay: "15/11", title: "15/11", images: ["test1","test3","test4","test2","test5","test1","test2"]),
                                PhotoDays(photoDay: "15/11", title: "15/11", images: ["test1","test3","test4","test2","test5","test1","test2"]),
                                PhotoDays(photoDay: "15/11", title: "15/11", images: ["test1","test3","test4","test2","test5","test1","test2"]),
                                PhotoDays(photoDay: "15/11", title: "15/11", images: ["test1","test3","test4","test2","test5","test1","test2"]),
                                PhotoDays(photoDay: "15/11", title: "15/11", images: ["test1","test3","test4","test2","test5","test1","test2"]),
                                PhotoDays(photoDay: "15/11", title: "15/11", images: ["test1","test3","test4","test2","test5","test1","test2"]),
                                PhotoDays(photoDay: "15/11", title: "15/11", images: ["test1","test3","test4","test2","test5","test1","test2"])]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}




extension SemanaViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        imagens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagens[section].images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "datatag", for: indexPath) as! SectionHeaderView
        let day = imagens[indexPath.section]
        sectionHeaderView.dataText = day.title
        
        return sectionHeaderView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "semanacell", for: indexPath) as! SemanaCollectionViewCell
        let dia = imagens[indexPath.section]
        let imageNames = dia.images
        let imageName = imageNames[indexPath.item]
        
        cell.imageName = imageName
        
        return cell
    }
    
    
}




struct PhotoDays {
    var photoDay: String
    var title: String
    var images: [String]
    
}
