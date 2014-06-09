//
//  DetailsViewControler.swift
//  SwiftForm
//
//  Created by Jordan Rose on 6/9/14.
//  Copyright (c) 2014 Jordan Rose. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    //@IBOutlet var albumCover : UIImageView
    @IBOutlet var titleLabel : UILabel
    @IBOutlet var albumCover : UIImageView
    
    var album:Album?

    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = self.album?.title
        albumCover.image = UIImage(data: NSData(contentsOfURL: NSURL(string: self.album?.largeImageURL)))
    }

}
