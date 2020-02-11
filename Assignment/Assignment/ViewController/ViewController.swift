//
//  ViewController.swift
//  Assignment
//
//  Created by Vishnu on 08/02/20.
//  Copyright © 2020 Vishnu. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController:UIViewController {
    
    final let TAG = "MainVC"
    
    let sessions = ["Morning", "Afternoon", "Evening", "Night"]
        
    @IBOutlet weak var sessionCollectionView: UICollectionView!
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var monthlbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var druglbl: UILabel!
    @IBOutlet weak var unitlbl: UILabel!
    @IBOutlet weak var donelmg: UIImageView!
    
    @IBOutlet weak var watchbtn: UIButton!
    @IBOutlet weak var Refreshbtn: UIButton!
    @IBOutlet weak var drugbrandNamelbl: UILabel!
    @IBOutlet weak var unit2lbl: UILabel!
    @IBOutlet weak var contextlbl: UILabel!
    @IBOutlet weak var takebtn: UIButton!
    
    @IBOutlet weak var videotitlelbl: UILabel!
    @IBOutlet weak var durationlbl: UILabel!
    @IBOutlet weak var videoImage: UIImageView!

    @IBOutlet weak var videotitlelbl2: UILabel!
    @IBOutlet weak var videoWorkPlacelbl: UILabel!
    
    
    let sessionHelper = TimerHelper()
    let viewModel = MainViewModel()
    var task : [Tasks]?
    var taskList = [Tasks]()
    var context : String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        RegisterCell()
        hideAlertView()
        videoImage.roundCorners(corners: [.topLeft,.bottomLeft], radius: 5)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        donelmg.alpha = 0
        datelbl.text = Date().toDateString()
        monthlbl.text = Date().toMonthString()
        makeRequest()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Button Action
    @IBAction func takebtnAction(_ sender: UIButton) {
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseInOut, animations: {
            self.donelmg.alpha = 1
        }) { (finished) in
            UIView.animate(withDuration: 1, delay: 0, options: .autoreverse, animations: {
                self.donelmg.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion:  nil)
        }
    }
    
    @IBAction func refreshBtnAction(_ sender: UIButton) {
        makeRequest()
    }
    
    @IBAction func watchbtnaction(_ sender: UIButton) {
        guard let  videoURL = URL(string: Constant.VideoUrl) else {
            Logger.i(tag: self.TAG, message: "Invalid Video url")
            return
        }
        
        let player = AVPlayer(url: videoURL)
        let vc = AVPlayerViewController()
        vc.player = player

        present(vc, animated: true) {
            vc.player?.play()
        }
    }
    
    // MARK: Helper methods
    
    /// updateDataTask will validate the model data withe the current session and if it is matched then we will updat the data
    /// - Parameter tasks: array of task
    private func updateDataTask(tasks:[Tasks]){
        self.task = tasks
        for task in tasks{
            for schedule in task.scheduleList!{
                if sessionHelper.getSession() == schedule.session{
                    if !taskList.isEmpty{
                        context = ""
                        taskList.removeAll()
                    }
                    
                    if context.isEmpty{
                        context = schedule.foodContext ?? ""
                    }
                    taskList.append(task)
                }
            }
        }
        
        DispatchQueue.main.async {
            if !self.taskList.isEmpty{
                self.updateTask(task: self.taskList.first!, context: self.context)
            }
        }
    }
    
    
    ///  updateTask is a helper method to update the model data to the corresponding UI
    /// - Parameters:
    ///   - task: task matched for current session
    ///   - context: food context
    private func updateTask(task:Tasks, context:String?){
            druglbl.text = task.drug?.genericNm ?? "-"
            unitlbl.text = "\(task.drug?.dosage?.dose ?? 0) \(task.drug?.dosage?.unit ?? "")"
            if let brand = task.drug?.brandNm{
                drugbrandNamelbl.text  = brand
                takebtn.isUserInteractionEnabled = true
                takebtn.backgroundColor = .systemBlue
            }else{
                drugbrandNamelbl.text = "-"
                takebtn.isUserInteractionEnabled = false
                takebtn.backgroundColor = .lightGray
            }
            unit2lbl.text = "\(task.drug?.dosage?.dose ?? 0) \(task.drug?.dosage?.unit ?? "")"
            contextlbl.text = context
            if let _ = task.video{
                videotitlelbl.text = task.video?.title
                videotitlelbl2.text = task.video?.title
                videoWorkPlacelbl.text = "Any Where"

                if let url = task.video?.thumbnail{
                    ImagePlacer.sharedInstance().render(for: url, mountOver: videoImage)
                }
                durationlbl.text = "\(task.duration ?? 0) mins"
                Constant.VideoUrl = task.video?.url ?? ""
                watchbtn.isUserInteractionEnabled = true
                watchbtn.backgroundColor = .systemBlue
            }else{
                videotitlelbl.text = "-"
                videotitlelbl2.text = "-"

                videoImage.image = UIImage(named: "exercise")
                durationlbl.text = "-"
                Constant.VideoUrl = ""
                videoWorkPlacelbl.text = "_"
                watchbtn.isUserInteractionEnabled = false
                watchbtn.backgroundColor = .lightGray
            }
            
    }
    
    
    /// MakeRequest will invoke the api request
    private func makeRequest(){
        if Constant.isInternetAvailable(){
            hideAlertView()
            viewModel.getData { (meditask, error) in
                if error == nil{
                    if let tasks = meditask?.tasks{
                        self.updateDataTask(tasks: tasks)
                        
                    }else{
                        Logger.i(tag: self.TAG, message: "[Error] :Received an Empty task")
                    }
                }else{
                    Logger.i(tag: self.TAG, message: "[Error] : \(String(describing: error))")
                }
            }
        }else{
            Logger.i(tag: TAG, message: "ERROR : Internet UnAvailable")
            showAlertView()
        }
    }
    
    
    /// RegisterCell will register the session custom cell when vc is loaded
    private func RegisterCell(){
        sessionCollectionView.delegate = self
        sessionCollectionView.dataSource = self
        let nib = UINib(nibName: "SessionCell", bundle: nil)
        sessionCollectionView.register(nib, forCellWithReuseIdentifier: "session")
    }
    
    
    // MARK - Custom Alert View methods
        private func showAlertView(){
           UIView.animate(withDuration: 2, delay: 0.5, options: .curveEaseInOut, animations: {
               self.alertView.alpha = 1
               self.alertView.transform = CGAffineTransform(scaleX: 1, y: 1)
           }, completion: nil)
        }

        private func hideAlertView(){
             UIView.animate(withDuration: 2, delay: 0.5, options: .curveEaseInOut, animations: {
               self.alertView.alpha = 0
               self.alertView.transform = CGAffineTransform(scaleX: 0, y:0 )
             }, completion: nil)
        }

        private func Alert(title:String, message:String){
            DispatchQueue.main.async {
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true)
            }
        }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sessions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "session", for: indexPath) as! SessionCell
        cell.sessionlbl.text = sessions[indexPath.item]
        switch sessionHelper.getSession() {
        case .MORNING where indexPath.item == 0:
            cell.highlight.isHidden = false
        case .AFTERNOON where indexPath.item == 1:
            cell.highlight.isHidden = false
        case .EVENING where indexPath.item == 2:
            cell.highlight.isHidden = false
        case .NIGHT where indexPath.item == 3:
            cell.highlight.isHidden = false
        default:break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width:  collectionView.frame.width * 0.4, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            updateSelectedSessionTask(session: .MORNING)
        case 1:
            updateSelectedSessionTask(session: .AFTERNOON)
        case 2:
            updateSelectedSessionTask(session: .EVENING)
        case 3:
            updateSelectedSessionTask(session: .NIGHT)
        default: break
        }
    }
    
    
    /// Helper method to update the data from model according to the session selected
    /// - Parameter session: session type
    private func updateSelectedSessionTask(session:SESSION){
        if let task = self.task{
            for task in task{
                for schedule in task.scheduleList!{
                    if schedule.session == session{
                        taskList.append(task)
                        if context.isEmpty{
                            context = schedule.foodContext ?? ""
                        }
                    }
                }
            }
            
            if !taskList.isEmpty{
                updateTask(task: taskList.first!, context:context)
            }
        }
    }
}
