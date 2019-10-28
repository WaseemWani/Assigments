//
//  LABaseTableViewCell.swift
//  LumiApp
//
//  Created by Disha on 20/08/19.
//  Copyright © 2019 TTN. All rights reserved.
//

import UIKit

class LABaseTableViewCell: UITableViewCell {
    var formItemModel: LADataFormModel!
    var indexPath: IndexPath!
    var keyBoardAccessoryView: LAKeyboardAccessoryView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bindData(itemModel: LADataFormModel, delegate: Any?, indexPath: IndexPath) {
        // override this function in sub class
        self.formItemModel = itemModel
        self.indexPath = indexPath
    }
}
