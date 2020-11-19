//
//  FenceModalViewController.swift
//  MockLocation
//
//  Created by Kyrylo Roman on 2/11/19.
//  Copyright © 2019 Kyrylo Roman. All rights reserved.
//

import UIKit
import Alamofire.Swift

class FenceModalViewController: UIViewController {
    
    @IBAction func CloseEvent(_ sender: Any) {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var GeofencesList: UITableView!
    
    open var geofences = [Geofence]()
    var dataSource: GeofenceTableDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
