//
//  AudioRecorderTableViewCell.swift
//  AudioRecorder
//
//  Created by Ibrahim Mo Gedami on 7/19/22.
//

import UIKit

class AudioRecorderTableViewCell: UITableViewCell {

    @IBOutlet var recordingName: UITextField!
    @IBOutlet var fileName: UILabel!
    @IBOutlet var slider : UISlider!
    
    var displayLink = CADisplayLink()
    var recorder = AKAudioRecorder.shared
   
    override func awakeFromNib() {
        super.awakeFromNib()
        slider.setThumbImage(#imageLiteral(resourceName: "slider"), for: .normal)
    }

    
    //MARK:- SET CELL HIGHLIGHT COLOR
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            contentView.backgroundColor = UIColor(named: "tableView-highlight")
        } else {
            contentView.backgroundColor = .systemBackground
        }

    }
    
    //MARK:- UPDATE SLIDER
    @objc func updateSliderProgress(){
        
         var progress = recorder.getCurrentTime() / Double(recorder.duration) /// progress 0 -> 1
        
         if recorder.isPlaying == false || progress == .infinity {
             displayLink.invalidate()
             progress = 0.0
         }
        slider.value = Float(progress)  /// Slider value is equal to progress
     }
     
    //MARK:- Run Time Loop for slider
     func playSlider(){
        if recorder.isPlaying{
            displayLink = CADisplayLink(target: self, selector: #selector(self.updateSliderProgress))
            self.displayLink.add(to: RunLoop.current, forMode: RunLoop.Mode.default)
         }
     }
    
}
