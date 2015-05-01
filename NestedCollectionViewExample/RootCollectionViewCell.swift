//
//  RootCollectionViewCell.swift
//  NestedCollectionViewExample
//
//  Created by Martino Buffolino on 4/30/15.
//  Copyright (c) 2015 Mcfly. All rights reserved.
//

import UIKit

class RootCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView!.registerNib(UINib(nibName: "BasicItemCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BasicItem")
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate delegate: protocol<UICollectionViewDelegate,UICollectionViewDataSource>, index: NSInteger) {
        self.collectionView.dataSource = delegate
        self.collectionView.delegate = delegate
        self.collectionView.tag = index
        self.collectionView.reloadData()
    }
    
}
