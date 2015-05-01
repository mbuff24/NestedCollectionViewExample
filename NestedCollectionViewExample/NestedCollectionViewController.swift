//
//  NestedCollectionViewController.swift
//  NestedCollectionViewExample
//
//  Created by Martino Buffolino on 4/30/15.
//  Copyright (c) 2015 Mcfly. All rights reserved.
//

import UIKit

protocol NestedCollectionViewScrollDelegate {
    func didReachBottom(scrollView: UIScrollView)
    func didReachTop(scrollView: UIScrollView)
}

// MARK: UIViewController

class NestedCollectionViewController: NSObject {
    var delegate: NestedCollectionViewScrollDelegate?
}

// MARK: UICollectionViewDataSource

extension NestedCollectionViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BasicItem", forIndexPath: indexPath) as! BasicItemCollectionViewCell
        
        let mod = indexPath.row % 4
        if mod == 0 {
            cell.backgroundColor = UIColor.greenColor()
        } else if mod == 1 {
            cell.backgroundColor = UIColor.purpleColor()
        } else if mod == 2 {
            cell.backgroundColor = UIColor.orangeColor()
        } else {
            cell.backgroundColor = UIColor.lightGrayColor()
        }
        
        cell.title.text = "\(indexPath.row)"
        
        return cell
    }
    
}

// MARK: UICollectionViewDelegate

extension NestedCollectionViewController: UICollectionViewDelegate {
    
}

// MARK: UICollectionViewDelegateFlowLayout

extension NestedCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/2, height: collectionView.bounds.width/2)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let scrollViewHeight = scrollView.frame.size.height
        let contentSizeHeight = scrollView.contentSize.height
        let contentOffset = scrollView.contentOffset.y
        
        if let delegate = self.delegate {
            if contentOffset <= 0 {
                delegate.didReachTop(scrollView)
            } else if contentOffset + scrollViewHeight >= contentSizeHeight {
                delegate.didReachBottom(scrollView)
            }
        }
    }
    
}

