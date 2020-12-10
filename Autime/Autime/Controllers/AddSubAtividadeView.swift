//
//  AddSubAtividadeView.swift
//  Autime
//
//  Created by Victor Vieira on 09/12/20.
//

import UIKit

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
        
        var subAtividade = SubAtividade()
        subAtividade.nome = "xib"//textfield.text
        subAtividade.image = buttonImage.imageView?.image!.pngData()
        subAtividade.completa = false
        
        if let topMostViewController = UIApplication.shared.topMostViewController() as? AtividadesCadastradas{
            subAtividade.ordem = Int16(topMostViewController.subAtividades.count)
            topMostViewController.subAtividades.append(subAtividade)
            
            
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
        if let topMostViewController = UIApplication.shared.topMostViewController() as? AtividadesCadastradas{
            topMostViewController.subAtividadeView.isHidden = true
            
        }
        
    }
}

