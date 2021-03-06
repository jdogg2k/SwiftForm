//
//  DetailsViewControler.swift
//  SwiftForm
//
//  Created by Jordan Rose on 6/9/14.
//  Copyright (c) 2014 Jordan Rose. All rights reserved.
//

import UIKit
import MediaPlayer
import QuartzCore

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, APIControllerProtocol {
    @lazy var api: APIController = APIController(delegate: self)
    var mediaPlayer: MPMoviePlayerController = MPMoviePlayerController()

    @IBOutlet var titleLabel : UILabel
    @IBOutlet var albumCover : UIImageView
    @IBOutlet var tracksTableView : UITableView
    
    
    var album:Album?
    
    var tracks: Track[] = []

    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = self.album?.title
        albumCover.image = UIImage(data: NSData(contentsOfURL: NSURL(string: self.album?.largeImageURL)))
        // Load in tracks
        if self.album?.collectionId? {
            api.lookupAlbum(self.album!.collectionId!)
        }
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell = tableView.dequeueReusableCellWithIdentifier("TrackCell") as TrackCell
        
        var track = tracks[indexPath.row]
        cell.titleLabel.text = track.title
        //cell.iconView.isPlaying = true
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        var track = tracks[indexPath.row]
        mediaPlayer.stop()
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) as? TrackCell {
            if cell.iconView.isPlaying {
                cell.iconView.isPlaying = false
            } else {
                mediaPlayer.contentURL = NSURL(string: track.previewUrl)
                mediaPlayer.play()
                cell.iconView.isPlaying = true
            }
        }
    }
    
    func tableView(tableView: UITableView!, willDisplayCell cell: UITableViewCell!, forRowAtIndexPath indexPath: NSIndexPath!) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animateWithDuration(0.25, animations: {
            cell.layer.transform = CATransform3DMakeScale(1,1,1)
            })
    }
    
    func didReceiveAPIResults(results: NSDictionary) {
        if let allResults = results["results"] as? NSDictionary[] {
            for trackInfo in allResults {
                // Create the track
                if let kind = trackInfo["kind"] as? String {
                    if kind=="song" {
                        var track = Track(dict: trackInfo)
                        tracks.append(track)
                    }
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), {
            self.tracksTableView.reloadData()
            })
    }

}
