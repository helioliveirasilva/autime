//
//  TableViewCell.swift
//  Autime
//
//  Created by Hélio Silva on 23/11/20.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelCellNome: UILabel!
    
    @IBOutlet weak var labelCellHora: UILabel!
    
    @IBOutlet weak var labelCellEstrela: UILabel!
    
    @IBOutlet weak var labelCellSeg: UILabel!
    @IBOutlet weak var labelCellTer: UILabel!
    @IBOutlet weak var labelCellQuar: UILabel!
    @IBOutlet weak var labelCellQui: UILabel!
    @IBOutlet weak var labelCellSex: UILabel!
    @IBOutlet weak var labelCellSab: UILabel!
    @IBOutlet weak var labelCellDom: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
