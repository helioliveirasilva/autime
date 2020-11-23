//
//  File.swift
//  Autime
//
//  Created by Hélio Silva on 23/11/20.
//

import UIKit
import CoreData

class AtividadesCadastradas: UIViewController {
    
    // swiftlint:disable force_cast

    @IBOutlet weak var labelNome: UITextField!
    @IBOutlet weak var pickerHora: UIDatePicker!
    @IBOutlet weak var switchEstrela: UISwitch!
    @IBOutlet weak var switchSegunda: UISwitch!
    @IBOutlet weak var switchTerca: UISwitch!
    @IBOutlet weak var switchQuarta: UISwitch!
    @IBOutlet weak var switchQuinta: UISwitch!
    @IBOutlet weak var switchSexta: UISwitch!
    @IBOutlet weak var switchSabado: UISwitch!
    @IBOutlet weak var switchDomingo: UISwitch!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        self.context = appDelegate.persistentContainer.viewContext
    }
    
    @IBAction func salvar(_ sender: Any) {
        
        let atividade = NSEntityDescription.insertNewObject(forEntityName: "Atividade", into: self.context)
        
        atividade.setValue(self.labelNome.text, forKey: "nome")
        atividade.setValue(self.pickerHora.date, forKey: "horario")
        atividade.setValue(self.switchEstrela.isOn, forKey: "gerarEstrela")
        atividade.setValue(self.switchSegunda.isOn, forKey: "segunda")
        atividade.setValue(self.switchTerca.isOn, forKey: "terca")
        atividade.setValue(self.switchQuarta.isOn, forKey: "quarta")
        atividade.setValue(self.switchQuinta.isOn, forKey: "quinta")
        atividade.setValue(self.switchSexta.isOn, forKey: "sexta")
        atividade.setValue(self.switchSabado.isOn, forKey: "sabado")
        atividade.setValue(self.switchDomingo.isOn, forKey: "domingo")
        
        do {
            try self.context.save()
            print("Seus dados foram salvos corretamente")
        } catch {
            print("Erro ao salvar os dados")
        }
    }
    
    @IBAction func imprimir(_ sender: Any) {

        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Atividade")
        
        do {
            let atividades = try self.context.fetch(requisicao)
            if atividades.count > 0 {
                for atividade in atividades as! [NSManagedObject] {
                    if  let nomeAtividade = atividade.value(forKey: "nome") {
                        print(nomeAtividade)
                    }
                }
            } else {
                print("Nenhuma atividade encontrada")
            }
        } catch let erro {
            print(erro.localizedDescription)
            print("Erro ao recuperar a atividade!")
        }
    }
}
