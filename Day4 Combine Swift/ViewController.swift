//
//  ViewController.swift
//  Day4 Combine Swift
//
//  Created by Kerolos on 20/05/2025.
//

import UIKit
import Combine

struct News:Decodable {
    let title : String
    let author:String
}


class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://raw.githubusercontent.com/DevTides/NewsApi/master/news.json")!
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [News].self, decoder: JSONDecoder())
           // .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Done")
                case .failure(let error):
                    print("Error: \(error)")
                }
                
            }, receiveValue: { newsList in
                guard let first = newsList.first else { return }
                self.titleLabel.text = first.title
                self.authorLabel.text = first.author
            })
            .store(in: &cancellables)
    }
}
