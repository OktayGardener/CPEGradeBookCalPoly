//
//  GradeCell.swift
//  CPEGradeBookCalPoly
//
//  Created by Oktay Gardener on 28/02/16.
//  Copyright © 2016 Oktay Gardener. All rights reserved.
//

import UIKit

class GradeCell: UITableViewCell {

    @IBOutlet var courseName: UILabel! = UILabel()
    @IBOutlet var courseNumber: UILabel! = UILabel()
    @IBOutlet var dept: UILabel! = UILabel()
    @IBOutlet var termName: UILabel! = UILabel()
    @IBOutlet var startDate: UILabel! = UILabel()
    @IBOutlet var endDate: UILabel! = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
