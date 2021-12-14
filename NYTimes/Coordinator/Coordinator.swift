//
//  Coordinator.swift
//  NYTimes
//
//  Created by Kevin Varghese on 12/12/21.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let sb = UIStoryboard(name: "Main", bundle:nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "TopStoriesViewController") as? TopStoriesViewController else { return }
        
        vc.topStoriesViewModel = TopStoriesViewModel()
        self.navigationController.pushViewController(vc, animated: false)
    }

}
