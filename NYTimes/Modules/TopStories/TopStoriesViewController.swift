//
//  ViewController.swift
//  NYTimes
//
//  Created by Kevin Varghese on 12/12/21.
//

import UIKit
import Combine

class TopStoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var topStoriesViewModel: TopStoriesViewModelType?
    
    var subscriptions: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Top Stories"
        self.setupBinding()
        self.topStoriesViewModel?.getTopStories()
    }
    
    private func setupBinding() {
        self.topStoriesViewModel?.topStoriesBinding
            .dropFirst()
            .receive(on: DispatchQueue.main).sink { [weak self] _ in
                self?.tableView.reloadData()
            }.store(in: &subscriptions)
    }

}

extension TopStoriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topStoriesViewModel?.numberofItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
           return UITableViewCell()
        }
        
        cell.textLabel?.text = ""
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = ""
        
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        if let topStoryDetails = topStoriesViewModel?.getTopStoryDetails(for: indexPath.row) {
            cell.textLabel?.text = topStoryDetails.title
            cell.detailTextLabel?.text = "\(topStoryDetails.byline) \(topStoryDetails.updatedDate)"
        }
        
        return cell
    }
    
    
}
