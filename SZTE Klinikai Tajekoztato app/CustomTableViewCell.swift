//
//  CustomTableViewCell.swift
//  SZTE Klinikai Tajekoztato app
//
//  Created by Bálint on 2022. 01. 18..
//

import UIKit

protocol CustomViewDelegate: AnyObject {
    func goToNextScene(title: String)
}

class CustomTableViewCell: UITableViewCell {
    
    weak var delegate: CustomViewDelegate?
    
    @IBOutlet weak var imageView1: UIImageView!
    
    @IBOutlet weak var labelView1: UILabel!
    
    @IBOutlet weak var labelView2: UILabel!
    
    @IBAction func buttonAction1(_ sender: UIButton) {
        delegate?.goToNextScene(title: labelView1.text!)
    }
    
    @IBAction func buttonAction2(_ sender: UIButton) {
        guard let number = URL(string: "tel://" + labelView2.text! ) else { return }
        UIApplication.shared.open(number)
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
