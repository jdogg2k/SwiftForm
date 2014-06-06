//
//  SearchResultsViewController.swift
//  SwiftForm
//
//  Created by Jordan Rose on 6/4/14.
//  Copyright (c) 2014 Jordan Rose. All rights reserved.
//USED EXAMPLE FROM HERE http://jamesonquave.com/blog/developing-ios-apps-using-swift-tutorial-part-2/
//

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIControllerProtocol {
    
    var api: APIController = APIController()
    
    @IBOutlet var appsTableView : UITableView
    var data: NSMutableData = NSMutableData()
    var tableData: NSArray = NSArray()
    var imageCache = NSMutableDictionary()
    
    
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let kCellIdentifier: String = "SearchResultCell"
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as UITableViewCell
        
        var rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
        
        // Add a check to make sure this exists
        let cellText: String? = rowData["trackName"] as? String
        cell.text = cellText
        cell.image = UIImage(named: "Blank52")
        
        // Get the formatted price string for display in the subtitle
        var formattedPrice: NSString = rowData["formattedPrice"] as NSString
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            // Jump in to a background thread to get the image for this item
            
            // Grab the artworkUrl60 key to get an image URL for the app's thumbnail
            var urlString: NSString = rowData["artworkUrl60"] as NSString
            
            // Check our image cache for the existing key. This is just a dictionary of UIImages
            var image: UIImage? = self.imageCache.valueForKey(urlString) as? UIImage
            
            if( !image? ) {
                // If the image does not exist, we need to download it
                var imgURL: NSURL = NSURL(string: urlString)
                
                // Download an NSData representation of the image at the URL
                var request: NSURLRequest = NSURLRequest(URL: imgURL)
                var urlConnection: NSURLConnection = NSURLConnection(request: request, delegate: self)
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                    if !error? {
                        //var imgData: NSData = NSData(contentsOfURL: imgURL)
                        image = UIImage(data: data)
                        
                        // Store the image in to our cache
                        self.imageCache.setValue(image, forKey: urlString)
                        cell.image = image
                    }
                    else {
                        println("Error: \(error.localizedDescription)")
                    }
                    })
                
            }
            else {
                cell.image = image
            }
            
            
        })
        
        cell.detailTextLabel.text = formattedPrice
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        // Get the row data for the selected row
        var rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
        
        var name: String = rowData["trackName"] as String
        var formattedPrice: String = rowData["formattedPrice"] as String
        
        var alert: UIAlertView = UIAlertView()
        alert.title = name
        alert.message = formattedPrice
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
    
    func didRecieveAPIResults(results: NSDictionary) {
        // Store the results in our table data array
        if results.count>0 {
            self.tableData = results["results"] as NSArray
            self.appsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        api.searchItunesFor("Noodlecake")
        self.api.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

