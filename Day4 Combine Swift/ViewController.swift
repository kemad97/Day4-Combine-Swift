//
//  ViewController.swift
//  Day4 Combine Swift
//
//  Created by Kerolos on 20/05/2025.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var publishLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        publishLabel.text = "..."
        counterLabel.text = "..."
        
        Just ("Hello MAD 45")
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink{
                [weak self] value in
                self?.publishLabel.text = value
            }
            .store(in: &cancellables)
        
        
        var count = 0
        
        Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                count += 1
                if count <= 5 {
                    self?.counterLabel.text = "\(count)"
                }
                
            }.store(in: &cancellables)
        
    }
    
    
}

