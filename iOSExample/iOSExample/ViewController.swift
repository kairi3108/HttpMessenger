//
//  ViewController.swift
//  iOSExample
//
//  Created by Yuto on 2021/01/03.
//

import UIKit
import HttpMessenger

class ViewController: UIViewController {
    
    @IBOutlet weak var getButton: UIButton!
    
    
    @IBAction func getButtonTaped(_ sender: UIButton) {
        // get
        _ = HttpMessengerSession.request(URL(string: "https://httpbin.org/get")!,
                                         methodType: .get,
                                         success: { (session, request, response, data) in
                                            
                                         },
                                         failure: { (session, request, response, error) in
                                            
                                         })
    }
}

