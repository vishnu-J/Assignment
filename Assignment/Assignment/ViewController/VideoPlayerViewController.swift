//
//  VideoPlayerViewController.swift
//  Assignment
//
//  Created by Vishnu on 10/02/20.
//  Copyright © 2020 Vishnu. All rights reserved.
//

import UIKit
import AVFoundation


class VideoPlayerViewController: UIViewController {

    @IBOutlet weak var closebtn: UIButton!
    var url : String?
    var player : AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //player = AVPlayer(url: URL(String:Constant.VideoUrl))
        
    }
    

    @IBAction func closebtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
