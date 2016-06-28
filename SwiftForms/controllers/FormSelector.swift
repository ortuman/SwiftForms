//
//  FormSelector.swift
//  SwiftForms
//
//  Created by Miguel Ángel Ortuño Ortuño on 23/08/14.
//  Copyright (c) 2016 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

@objc public protocol FormSelector: NSObjectProtocol {
    var formCell: FormBaseCell? { get set }
}
