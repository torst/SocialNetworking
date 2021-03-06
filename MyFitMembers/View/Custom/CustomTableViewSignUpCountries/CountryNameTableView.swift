//
//  CountryNameTableView.swift
//  GoHobo
//
//  Created by Boris Esanu on 4/23/16.
//  Copyright © 2016 GCode. All rights reserved.
//

import UIKit

protocol DelegateSelectedState {
    func delegateSelectedState(_ state: String)
}

class CountryNameTableView: UIView {
    
    //Mark::- outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSelectCountry: UIButton!
    
    //Mark::- variables
    var delegate : DelegateSelectedState?
    var tableViewDataSource: DataSourceTableView?
    var countryName: String?
    var countryId: String?
    var country: [AnyObject]? = [
        "Alabama" as AnyObject,
        "Alaska" as AnyObject,
        "American Samoa" as AnyObject,
        "Arizona" as AnyObject,
        "Arkansas" as AnyObject,
        "California" as AnyObject,
        "Colorado" as AnyObject,
        "Connecticut",
        "Delaware",
        "District Of Columbia",
        "Federated States Of Micronesia",
        "Florida",
        "Georgia",
        "Guam",
        "Hawaii",
        "Idaho",
        "Illinois",
        "Indiana",
        "Iowa",
        "Kansas",
        "Kentucky",
        "Louisiana",
        "Maine",
        "Marshall Islands",
        "Maryland",
        "Massachusetts",
        "Michigan",
        "Minnesota",
        "Mississippi",
        "Missouri",
        "Montana",
        "Nebraska",
        "Nevada",
        "New Hampshire",
        "New Jersey",
        "New Mexico",
        "New York",
        "North Carolina",
        "North Dakota",
        "Northern Mariana Islands",
        "Ohio",
        "Oklahoma",
        "Oregon",
        "Palau",
        "Pennsylvania",
        "Puerto Rico",
        "Rhode Island",
        "South Carolina",
        "South Dakota",
        "Tennessee",
        "Texas",
        "Utah",
        "Vermont",
        "Virgin Islands",
        "Virginia",
        "Washington",
        "West Virginia",
        "Wisconsin",
        "Wyoming"
    ]
    var selectedRow = 100
    
    
    //Mark::- initializer
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CountryNames", bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {return UIView()}
        return view
    }
    
    func xibSetup() {
        let view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        tableView.register(UINib(nibName: "CountryNameTableViewCell", bundle: nil), forCellReuseIdentifier: "CountryNameTableViewCell")
        configuringTableView()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        xibSetup()
        tableView.register(UINib(nibName: "CountryNameTableViewCell", bundle: nil), forCellReuseIdentifier: "CountryNameTableViewCell")
        configuringTableView()
    }
    
    func configuringTableView(){
        tableViewDataSource = DataSourceTableView(tableView: tableView, cell: "CountryNameTableViewCell", item: country, configureCellBlock: { [weak self] (cell, item, indexPath) in
            guard let cell = cell as? CountryNameTableViewCell else {return}
            cell.labelCountryName.text = self?.country?[indexPath.row] as? String ?? ""
            }, configureDidSelect: { [weak self] (indexPath) in
                guard let cell = self?.tableView?.cellForRow(at: indexPath as IndexPath) as? CountryNameTableViewCell else {return}
                self?.selectedRow = indexPath.row
                guard let state = self?.country?[indexPath.row] as? String else {return}
                self?.delegate?.delegateSelectedState(state)
        })
        self.tableView.dataSource = tableViewDataSource
        self.tableView.delegate = tableViewDataSource
        tableViewDataSource?.item = country ?? []
        tableView.reloadData()
    }
    
    
//MARK::- ACTIONS
   
    
    
    
    
    
}
