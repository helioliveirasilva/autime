//
//  DayViewController.swift
//  Autime
//
//  Created by Victor Vieira on 19/11/20.
//

import UIKit

class DayViewController: UIViewController {
    
    @IBOutlet var tarefasCollection: UICollectionView!
    var imagens: [UIImage] = [UIImage(named: "test")!,UIImage(named: "test")!,UIImage(named: "test")!,UIImage(named: "test")!,UIImage(named: "test")!,UIImage(named: "test")!]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tarefasCollection.delegate = self
        tarefasCollection.dataSource = self
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

extension DayViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagens.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "my cell", for: indexPath as IndexPath) as? FilhoCollectionViewCell else{
            print("ERROOOU!")
            fatalError()}
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "my cell", for: indexPath as IndexPath) as! FilhoCollectionViewCell
        cell.imageView.image = imagens[indexPath.item]
        cell.hora.text = "03:00"
        cell.atividade.text = "Cagar"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var subtarefaView = SubTarefasViewController()
        subtarefaView.view.backgroundColor = .white
//        subtarefaView.navigationController?.navigationBar.isHidden = false
        self.navigationController?.present(subtarefaView, animated: true, completion: nil)
    }
    
    
}
