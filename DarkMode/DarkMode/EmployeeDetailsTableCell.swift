//
//  EmployeeDetailsTableCell.swift
//  DarkModeDemo
//
//  Created by Waseem Wani on 10/02/20.
//  Copyright © 2020 Waseem Wani. All rights reserved.
//
import Foundation
import UIKit

class EmployeeDetailsTableCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        themeProvider.register(observer: self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        apply(theme: themeProvider.theme)
    }
    
    
    /// This function configures table cell
    /// - Parameter content: the content to be displayed in cell. It is of TableDataSource struct
    func configureCell(with content: EmployeesData?) {
        titleLabel.text = content?.employeeName
        descriptionLabel.text = content?.salary
    }
    
    func configCell(with data: EmployeeData) {
        titleLabel.text = data.employeeName
        descriptionLabel.text = data.salary
    }
}

extension EmployeeDetailsTableCell: Themeable {
    
    func apply(theme: Theme) {
        backgroundColor = theme.backgroundColor
        titleLabel.textColor = theme.textColor
        descriptionLabel.textColor = theme.descriptionTextColor
    }
}
