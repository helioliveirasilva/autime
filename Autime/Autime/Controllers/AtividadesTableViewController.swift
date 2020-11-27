//
//  TableViewController.swift
//  TableView
//
//  Created by Peter Kamb on 1/16/19.
//  Copyright © 2019 Peter Kamb. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    // swiftlint:disable force_cast
    // swiftlint:disable line_length
    // swiftlint:disable trailing_whitespace
    // swiftlint:disable vertical_whitespace
    
    var context: NSManagedObjectContext!
    var atividades: [Atividade] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.recuperarAtividades()
    }
    
    func recuperarAtividades() {
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Atividade")
        do {
            let atividadesRecuperadas = try context.fetch(requisicao)
            self.atividades = atividadesRecuperadas as! [Atividade]
            self.tableView.reloadData()
        } catch let erro {
            print("Não foi possível recuperar as atividades: \(erro.localizedDescription)")
            
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return atividades.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let atividade = self.atividades[indexPath.row]
        
        // Gera Estrela
        if atividade.value(forKey: "gerarEstrela") as? Bool == true {
            cell.labelCellEstrela.text = "Gera estrela"
        } else {
            cell.labelCellEstrela.text = "Não gera estrela"
        }
        //Hora
        let textoHora = atividade.value(forKey: "horario")
        // Date Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        let novaData = dateFormatter.string(from: textoHora as! Date)
        cell.labelCellHora.text = novaData
        // Nome
        let texto = atividade.value(forKey: "nome")
        cell.labelCellNome.text = texto as? String
        
        // Image
        var photo: UIImage!
              
        if let data = atividade.image {
            photo = UIImage(data: data)
        } else {
            photo = UIImage()
        }
        
        cell.imageViewCell.image = photo
                
        // Dias da semana
        if atividade.value(forKey: "segunda") as? Bool == true {
            cell.labelCellSeg.backgroundColor = .green
        }
        if atividade.value(forKey: "terca") as? Bool == true {
            cell.labelCellTer.backgroundColor = .green
        }
        if atividade.value(forKey: "quarta") as? Bool == true {
            cell.labelCellQuar.backgroundColor = .green
        }
        if atividade.value(forKey: "quinta") as? Bool == true {
            cell.labelCellQui.backgroundColor = .green
        }
        if atividade.value(forKey: "sexta") as? Bool == true {
            cell.labelCellSex.backgroundColor = .green
        }
        if atividade.value(forKey: "sabado") as? Bool == true {
            cell.labelCellSab.backgroundColor = .green
        }
        if atividade.value(forKey: "domingo") as? Bool == true {
            cell.labelCellDom.backgroundColor = .green
        }
        
        
        return cell
    }
}
