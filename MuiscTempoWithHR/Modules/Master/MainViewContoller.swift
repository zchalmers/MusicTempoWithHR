//
//  MainViewContoller.swift
//  MuiscTempoWithHR
//
//  Created by Zach on 5/20/24.
//

import Foundation
import UIKit

protocol MainView: AnyObject {
    func updateView()
}

class MainViewController: UIViewController, MainView {
    var delegate: MainDelegate!
    var dataSource: MainDataSource!
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var tempo: UILabel!
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    class func instantiateViewController() -> MainViewController {
        let bundle = Bundle(for: MainViewController.self)
        let storyboard = UIStoryboard(name: "MainViewController", bundle: bundle)
        guard let mainVC = storyboard.instantiateInitialViewController() as?
                MainViewController else {
            fatalError("Unable to instantiate View Controller")
        }
        return mainVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for:.valueChanged)
        dataSource.playSong()
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        // Update views or perform any other actions based on slider value
        dataSource.setTempo(tempo: sender.value)
    }
    
    func updateView(){
        
    }
    
    
}

//extension MainViewController: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return CGFloat.leastNormalMagnitude
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return CGFloat.leastNormalMagnitude
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return nil
//    }
//
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        return nil
//    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//}
