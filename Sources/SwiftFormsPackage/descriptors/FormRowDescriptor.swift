//
//  FormRowDescriptor.swift
//  SwiftForms
//
//  Created by Miguel Ángel Ortuño Ortuño on 23/08/14.
//  Copyright (c) 2016 Miguel Angel Ortuño. All rights reserved.
//

import UIKit

public final class FormRowDescriptor {
    
    // MARK: Types
    
    public enum RowType {
        case unknown
        case label
        case text
        case url
        case number
        case numbersAndPunctuation
        case decimal
        case name
        case phone
        case namePhone
        case email
        case twitter
        case asciiCapable
        case password
        case button
        case booleanSwitch
        case booleanCheck
        case segmentedControl
        case picker
        case date
        case time
        case dateAndTime
        case stepper
        case slider
        case multipleSelector
        case multilineText
    }
    
    public struct CellConfiguration {
        public var cellClass:                AnyClass?
        public var appearance:               [String : AnyObject]
        public var placeholder:              String?
        public var showsInputToolbar:        Bool
        public var required:                 Bool
        public var willUpdateClosure:        ((FormRowDescriptor) -> Void)?
        public var didUpdateClosure:         ((FormRowDescriptor) -> Void)?
        public var visualConstraintsClosure: ((FormBaseCell) -> [String])?
        
        public init() {
            cellClass = nil
            appearance = [:]
            placeholder = nil
            showsInputToolbar = false
            required = true
            willUpdateClosure = nil
            didUpdateClosure = nil
            visualConstraintsClosure = nil
        }
    }
 
    public struct SelectionConfiguration {
        public var controllerClass:         AnyClass?
        public var options:                 [AnyObject]
        public var optionTitleClosure:      ((AnyObject) -> String)?
        public var allowsMultipleSelection: Bool
        
        public init() {
            controllerClass = nil
            options = []
            optionTitleClosure = nil
            allowsMultipleSelection = false
        }
    }
    
    public struct ButtonConfiguration {
        public var didSelectClosure: ((FormRowDescriptor) -> Void)?
        
        public init() {
            didSelectClosure = nil
        }
    }
    
    public struct StepperConfiguration {
        public var maximumValue: Double
        public var minimumValue: Double
        public var steps:        Double
        public var continuous:   Bool
        
        public init() {
            maximumValue = 0.0
            minimumValue = 0.0
            steps = 0.0
            continuous = false
        }
    }
    
    public struct DateConfiguration {
        public var dateFormatter: DateFormatter?
    }
    
    public struct RowConfiguration {
        public var cell:      CellConfiguration
        public var selection: SelectionConfiguration
        public var button:    ButtonConfiguration
        public var stepper:   StepperConfiguration
        public var date:      DateConfiguration
        public var userInfo:  [String : AnyObject]
        
        init() {
            cell = CellConfiguration()
            selection = SelectionConfiguration()
            button = ButtonConfiguration()
            stepper = StepperConfiguration()
            date = DateConfiguration()
            userInfo = [:]
        }
    }
    
    // MARK: Properties
    
    public let tag: String
    public let type: RowType
    
    public var title: String?
    
    public var value: AnyObject? {
        willSet {
            guard let willUpdateBlock = configuration.cell.willUpdateClosure else { return }
            willUpdateBlock(self)
        }
        didSet {
            guard let didUpdateBlock = configuration.cell.didUpdateClosure else { return }
            didUpdateBlock(self)
        }
    }
    
    public var configuration: RowConfiguration
    
    // MARK: Init
    
    public init(tag: String, type: RowType, title: String, configuration: RowConfiguration) {
        self.tag = tag
        self.type = type
        self.title = title
        self.configuration = configuration
    }
    
    public init(tag: String, type: RowType, title: String) {
        self.tag = tag
        self.type = type
        self.title = title
        self.configuration = RowConfiguration()
    }
}
