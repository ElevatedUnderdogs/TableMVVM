//
//  ColorView.swift
//  
//
//  Created by Scott Lydon on 9/20/21.
//

// If the package warns againts `UIKit`, make sure the simulator you are running is iOS. 
import UIKit

extension UIColor: HasInit {}
 class ColorView: UIView, HasViewModel, HasInit {

     typealias ViewModel = UIColor

     var viewModel: ViewModel = .red {
        didSet {
            self.backgroundColor = viewModel
        }
    }
}
