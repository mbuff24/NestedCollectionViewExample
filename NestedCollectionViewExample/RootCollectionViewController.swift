//
//  RootCollectionViewController.swift
//  NestedCollectionViewExample
//
//  Created by Martino Buffolino on 4/30/15.
//  Copyright (c) 2015 Mcfly. All rights reserved.
//

import UIKit

class RootCollectionViewController: UICollectionViewController {
    
    var nestedController: NestedCollectionViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "HeaderCollectionViewCell")
        self.collectionView!.registerNib(UINib(nibName: "HeaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HeaderCollectionViewCell")
        self.collectionView!.registerNib(UINib(nibName: "RootCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RootCollectionViewCell")
        nestedController = NestedCollectionViewController()
        nestedController!.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return 2
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HeaderCollectionViewCell", forIndexPath: indexPath) as! UICollectionViewCell
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RootCollectionViewCell", forIndexPath: indexPath) as! RootCollectionViewCell
            cell.setCollectionViewDataSourceDelegate(dataSourceDelegate: nestedController!, index: indexPath.row)
            cell.collectionView!.scrollEnabled = false            
            return cell
        }
        
    }

}

extension RootCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let height = self.collectionView!.bounds.height
        let width = self.collectionView!.bounds.width
        if indexPath.row == 0 {
            return CGSize(width: width, height: 250)
        } else {
            return CGSize(width: width, height: height)
        }
    }
    
}

// MARK: PagedCollectionViewItemDelegate

extension RootCollectionViewController: NestedCollectionViewScrollDelegate {
    
    func didReachTop(scrollView: UIScrollView) {
        println("home: didReachTop")
        
        // enable parent vertical scrolling
        self.collectionView!.scrollEnabled = true
        
        // disable child vertical scrolling
        scrollView.scrollEnabled = false
    }
    
    func didReachBottom(scrollView: UIScrollView) {
        println("home: didReachBottom")
    }
    
}


// MARK: UIScrollViewDelegate

extension RootCollectionViewController: UIScrollViewDelegate {
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let visibleCells = self.collectionView!.visibleCells() as! [UICollectionViewCell]
        let filteredCells = visibleCells.filter { $0.isKindOfClass(RootCollectionViewCell) }
        
        
        if filteredCells.count == 1 {
            // convert cell to relative frame
            let relativeFrame = self.collectionView!.convertRect(filteredCells[0].frame, toView: self.view)
            
            if relativeFrame.origin.y <= 0 {
                // enable child scrolling
                (filteredCells[0] as! RootCollectionViewCell).collectionView!.scrollEnabled = true
                    
                // disable parent scrolling
                self.collectionView!.scrollEnabled = false
            }
        }
    }
    
}

