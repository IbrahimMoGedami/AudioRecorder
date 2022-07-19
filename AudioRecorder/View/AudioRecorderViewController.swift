//
//  AudioRecorderViewController.swift
//  AudioRecorder
//
//  Created by Ibrahim Mo Gedami on 7/19/22.
//

import UIKit

class AudioRecorderViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var timeLabel: UILabel!
    
    var recorder = AKAudioRecorder.shared
    var displayLink = CADisplayLink()
    var duration : CGFloat = 0.0
    var timer : Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    func initialSetup(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset.top = 30
        setCircle()
        dismissKeyboard()
        tableView.register(UINib(nibName: "AudioRecorderTableViewCell", bundle: nibBundle), forCellReuseIdentifier: "AudioRecorderTableViewCell")
    }
    
    //MARK:- Play / Stop Recording
    @IBAction func playstopButton(_ sender: UIButton) {
        if recorder.isRecording{
            animate(isRecording: true)
            recorder.stopRecording()
            tableView.reloadData()
        } else{
            animate(isRecording: false)
            recorder.record()
            setTimer()
        }
    }
}


//MARK:- UITableView Delegate Methods
extension AudioRecorderViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recorder.getRecordings.count          //Number of Cells
    }
    
    //MARK:- Set Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AudioRecorderTableViewCell") as! AudioRecorderTableViewCell
        
        let recording = recorder.getRecordings[indexPath.row]      // FileName
        let name = "New Recording " + String(indexPath.row + 1)    // New Recording 1,2,3...
        cell.recordingName.text = name
        cell.fileName.text =  "FileName :- \(recording)"
        cell.slider.isHidden = true                                 // hide slider
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = recorder.getRecordings[indexPath.row]    // FileName
        recorder.play(name: name)                           //Play
        let cell = tableView.cellForRow(at: indexPath) as! AudioRecorderTableViewCell
        cell.slider.isHidden = false                        //Show slider
        cell.playSlider()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! AudioRecorderTableViewCell
        cell.slider.isHidden = true                         //hide slider
    }
    
    //MARK:- Delete Recording
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let name = recorder.getRecordings[indexPath.row]
            recorder.deleteRecording(name: name)
            tableView.deleteRows(at: [indexPath], with: .fade)
            debugLog("Deleted Recording")
            print(recorder.getRecordings)
        }
    }
    
    //MARK:- Row Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}

//MARK:- Extra Functions for UI Improvement
extension AudioRecorderViewController{
    func animate(isRecording : Bool){
        if isRecording{
            self.playButton.layer.cornerRadius = 4
            UIView.animate(withDuration: 0.1) {
                self.playButton.transform = CGAffineTransform(scaleX: 2, y: 2)
                self.playButton.layer.cornerRadius = 15
            }
        }
        else{
            UIView.animate(withDuration: 0.1) {
                self.playButton.transform = .identity
                self.playButton.layer.cornerRadius = 4
            }
        }
    }
    
    func setCircle(){
        self.playButton.transform = CGAffineTransform(scaleX: 2, y: 2)
        self.playButton.layer.cornerRadius = 15
    }
    
    func setTimer(){
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateDuration), userInfo: nil, repeats: true)
    }
    
    @objc func updateDuration() {
        if recorder.isRecording && !recorder.isPlaying{
            duration += 1
            self.timeLabel.alpha = 1
            self.timeLabel.text = duration.timeStringFormatter
        }else{
            timer.invalidate()
            duration = 0
            self.timeLabel.alpha = 0
            self.timeLabel.text = "0:00"
        }
    }
}
