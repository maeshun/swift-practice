//
//  itemTableViewCell.swift
//  MySearchApp
//
//  Created by 前俊輔 on 2018/04/21.
//  Copyright © 2018年 Shunsuke Mae. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!

    var itemUrl: String?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        // セル再利用時に実施する処理
        self.itemImageView.image = nil
    }
}
