//
//  TasksTVCell.swift
//  Vero-TaskApp
//
//  Created by MacBook on 27/03/2023.
//

import UIKit

class TasksTVCell: UITableViewCell {

    @IBOutlet weak var lblTask   :UILabel!
    @IBOutlet weak var lblTitle  :UILabel!
    @IBOutlet weak var lblDesc   :UILabel!
    @IBOutlet weak var viewColor :UIView!
    @IBOutlet weak var viewBack  :UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        viewBack.dropShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config_cell(object:Task){
        self.lblTask.text = object.task
        self.lblTitle.text = object.title
        self.lblDesc.text = object.desc
        self.viewColor.backgroundColor = object.colorCode?.getUIColor()
        self.lblTask.textColor = object.colorCode?.getUIColor()
        
    }
    
}
