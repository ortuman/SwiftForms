//
//  FormBaseCell.swift
//  SwiftForms
//
//  Created by Miguel Angel Ortuno on 20/08/14.
//  Copyright (c) 2014 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

class FormBaseCell: UITableViewCell {

    /// MARK: Properties
    
    var rowDescriptor: FormRowDescriptor! {
        didSet {
            self.update()
        }
    }
    
    /// MARK: Init
    
    required override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// MARK: Public interface
    
    func configure() {
        /// override
    }
    
    func update() {
        /// override
    }
    
    class func formRowCellHeight() -> CGFloat {
        return 44.0
    }
    
    class func formViewController(formViewController: FormViewController, didSelectRow: FormBaseCell) {
    }
}
