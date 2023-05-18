//
//  BaseViewController.swift
//  RickAndMortyApp
//
//  Created by Ahmer Akhter on 18/05/2023.
//

import UIKit

class BaseViewController: UIViewController {

    var containerView : UIView!

    func showLoadingView() {
          containerView = UIView(frame: view.bounds)
          view.addSubview(containerView)
          
          containerView.backgroundColor = .systemBackground
          containerView.alpha = 0
          
          UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.8
          }
          let activityIndicator = UIActivityIndicatorView(style: .large)
          
          containerView.addSubview(activityIndicator)
      activityIndicator.translatesAutoresizingMaskIntoConstraints = false
          
          NSLayoutConstraint.activate([            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
          ])
          activityIndicator.startAnimating()
      }
      
      func dismissLoadingView(){
          DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
          }
      }

}
