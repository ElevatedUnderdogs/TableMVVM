//
//  ColorView.swift
//  
//
//  Created by Scott Lydon on 9/20/21.
//

// If the package warns againts `UIKit`, make sure the simulator you are running is iOS. 
import UIKit

extension UIColor: HasInit {}
 public class ColorView: UIView, HasViewModel, HasInit {

     public typealias ViewModel = UIColor

    public var viewModel: ViewModel = .red {
        didSet {
            self.backgroundColor = viewModel
        }
    }
}
