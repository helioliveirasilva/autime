//
//  AddSubAtividadeView.swift
//  Autime
//
//  Created by Victor Vieira on 09/12/20.
//

// swiftlint:disable force_cast
// swiftlint:disable line_length
// swiftlint:disable trailing_whitespace
// swiftlint:disable vertical_whitespace

import UIKit
import CoreData

class AddSubAtividadeView: UIView, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var buttonImage: UIButton!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var subview: UIView!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func commomInit(){
        Bundle.main.loadNibNamed("AddSubAtividade", owner: self, options: nil)
        self.addSubview(subview)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commomInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commomInit()
    }
    
    @IBAction func save(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        var subAtividade = SubAtividade(context: context)
        subAtividade.nome = textfield.text//(textfield.text, forKey: "nome")
        subAtividade.image = buttonImage.imageView?.image!.pngData()
        subAtividade.completa = false
        
//        if let topMostViewController = UIApplication.shared.topMostViewController() as? AtividadesCadastradas{
//            print("oxe2")
//            subAtividade.ordem = Int16(topMostViewController.subAtividades.count)
//            topMostViewController.subAtividades.append(subAtividade)
//
//
//        }
        
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            guard let topMostViewController = topController as? AtividadesCadastradas else { print("fudeu")
                return }
            print("oxe2")
            subAtividade.ordem = Int16(topMostViewController.subAtividades.count)
            topMostViewController.subAtividades.append(subAtividade)
            // topController should now be your topmost view controller
        }
        
        print("zaga")
        dismissCard()
    }
    @IBAction func escolherImagem(_ sender: Any) {
        print("teile")
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        if let topMostViewController = UIApplication.shared.topMostViewController() as? AtividadesCadastradas{
            topMostViewController.present(imagePicker, animated: true, completion: nil)
            
        }
        //present(imagePicker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            buttonImage.setImage(image, for: .normal)
            picker.dismiss(animated: true, completion: nil)
            
        }
    }
    
    
    //PickerControllerCancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func dismissCard() {
        print("Oxente")
        if let topMostViewController = UIApplication.shared.topMostViewController() as? AtividadesCadastradas{
            print("Oxe")
            topMostViewController.subAtividadeView.isHidden = true
            
        }
        
    }
}

