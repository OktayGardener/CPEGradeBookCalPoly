//
//  UserScoreCell.swift
//  CPEGradeBookCalPoly
//
//  Created by Oktay Gardener on 06/03/16.
//  Copyright © 2016 Oktay Gardener. All rights reserved.
//

import UIKit

class UserScoreCell: UITableViewCell {
    
    @IBOutlet var id: UILabel! = UILabel()
    @IBOutlet var age: UILabel! = UILabel()
    @IBOutlet var major: UILabel! = UILabel()
    @IBOutlet var emplID: UILabel! = UILabel()
    @IBOutlet var firstName: UILabel! = UILabel()
    @IBOutlet var middleName: UILabel! = UILabel()
    @IBOutlet var lastName: UILabel! = UILabel()
    @IBOutlet var userName: UILabel! = UILabel()
    @IBOutlet var picture: UIImage! = UIImage()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
