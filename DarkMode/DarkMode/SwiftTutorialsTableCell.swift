//
//  SwiftTutorialsTableCell.swift
//  DarkModeDemo
//
//  Created by Waseem Wani on 10/02/20.
//  Copyright © 2020 Waseem Wani. All rights reserved.
//
import Foundation
import UIKit

class SwiftTutorialsTableCell: UITableViewCell {
    
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
    
    func configureCell(with content: TableDataSource) {
        titleLabel.text = content.title
        descriptionLabel.text = content.description
    }
}

extension SwiftTutorialsTableCell: Themeable {
    
    func apply(theme: Theme) {
        backgroundColor = theme.backgroundColor
        titleLabel.textColor = theme.textColor
        descriptionLabel.textColor = theme.descriptionTextColor
    }
}
