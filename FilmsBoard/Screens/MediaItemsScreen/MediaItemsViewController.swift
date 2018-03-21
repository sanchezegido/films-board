//
//  ViewController.swift
//  FilmsBoard
//
//  Created by Pablo on 07/03/2018.
//  Copyright © 2018 Pablo. All rights reserved.
//

import UIKit
import SCLAlertView
import MBProgressHUD

class MediaItemsViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    private var progressIndicator: MBProgressHUD!

    private let CELL_ID = "media-items-row"

    private let viewModel: MediaItemsViewModel

    init(viewModel: MediaItemsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initSegmentedControl()
        self.navigationItem.titleView = segmentedControl
        self.initTableView()

        viewModel.delegate = self

        self.requestData()
    }

    @IBAction func segmentedControlDidChange(_ sender: UISegmentedControl) {
        self.requestData()
    }
}

extension MediaItemsViewController {

    private func initSegmentedControl() {
        self.segmentedControl.setTitle("Películas", forSegmentAt: 0)
        self.segmentedControl.setTitle("Series", forSegmentAt: 1)
    }

    private func initTableView() {
        let rowNib = UINib(nibName: "MediaItemsRow", bundle: nil)
        self.tableView.register(rowNib, forCellReuseIdentifier: CELL_ID)

        self.tableView.dataSource = self
        self.tableView.rowHeight = 240
        self.tableView.separatorStyle = .none
    }
}

extension MediaItemsViewController {

    // Map selected segment of segmented control to MediaItemTypes
    private func getType(forIndex index: Int) -> MediaItemTypes? {
        return MediaItemTypes(rawValue: index)
    }

    private func requestData() {
        self.progressIndicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        self.progressIndicator.label.text = "Cargando..."
        self.progressIndicator.mode = .indeterminate

        let index = self.segmentedControl.selectedSegmentIndex
        if let type = self.getType(forIndex: index) {
            viewModel.getMediaItemsByCategories(type: type)
        }
    }
}

extension MediaItemsViewController: MediaItemsViewModelDelegate {

    func mediaItemsViewModelDidUpdateData(_ viewModel: MediaItemsViewModel) {
        self.progressIndicator.hide(animated: true)
        self.tableView.reloadData()
    }

    func mediaItemsViewModel(_ viewModel: MediaItemsViewModel, didGetError errorMessage: String) {
        self.progressIndicator.hide(animated: true)
        SCLAlertView().showWarning("Aviso", subTitle: errorMessage, closeButtonTitle: "Ok", circleIconImage: UIImage(named: "ic-no-network"), animationStyle: .topToBottom)
    }
}

extension MediaItemsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! MediaItemsRow
        cell.viewModel = viewModel.tableCellViewModels[indexPath.row]

        return cell
    }
}
