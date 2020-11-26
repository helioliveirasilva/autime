//
//  SubTarefasViewController.swift
//  Autime
//
//  Created by Victor Vieira on 19/11/20.
//

import UIKit

class SubTarefasViewController: UIViewController {
    
    
    @IBOutlet var subtarefasCollection: UICollectionView!
    var imagens: [UIImage] = [UIImage(named: "test")!,UIImage(named: "test")!,UIImage(named: "test")!,UIImage(named: "test")!,UIImage(named: "test")!,UIImage(named: "test")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subtarefasCollection.delegate = self
        subtarefasCollection.dataSource = self
        
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

extension SubTarefasViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subcell", for: indexPath as IndexPath) as? SubtarefasCollectionCell else{
            print("ERROOOU!")
            fatalError()}
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "my cell", for: indexPath as IndexPath) as! FilhoCollectionViewCell
        cell.image.image = imagens[indexPath.item]
        cell.label.text = "Cagar"
        return cell
    }
    
    
}
