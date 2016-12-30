//
//  ConversionHistoryViewController.swift
//  Currency Converter
//
//  Created by Mayank Kumar on 7/29/15.
//  Copyright (c) 2015 Mayank Kumar. All rights reserved.
//

import UIKit
import CoreData

class ConversionHistoryViewController: UITableViewController {
    
    @IBOutlet var tempView: UIView!
    var appDel: AppDelegate  {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var sharedContext: NSManagedObjectContext {
        return appDel.managedObjectContext!
    }
    
    var fetchedConversions: [Conversion]!
    
    override func viewWillAppear(_ animated: Bool) {
        fetchedConversions = fetchAllConversions()
        if fetchedConversions.count == 0 {
            self.tableView.tableFooterView = tempView
        }
        else {
            self.tableView.tableFooterView = UIView()
        }
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! ConversionCell
        let controller = segue.destination as! ConversionDetailViewController
        controller.usdVal = cell.usdValue.text!
        controller.initialText = cell.associations.text!
        controller.context = sharedContext
        controller.managedObject = fetchedConversions[(tableView.indexPath(for: cell)?.row)!]
    }
    
    func fetchAllConversions() -> [Conversion]! {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Conversion")
        var results: [Conversion]!
        do {
            results = try sharedContext.fetch(request) as! [Conversion]
        } catch {
            results = nil
        }
        return results
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ConversionCell
        configureCell(cell, indexPath: indexPath)
        return cell
    }
    
    func configureCell(_ cell: ConversionCell, indexPath: IndexPath) {
        cell.usdValue.text = "\(fetchedConversions[indexPath.row].baseValue)"
        cell.euroLabel.text = "\(fetchedConversions[indexPath.row].eurValue)"
        cell.poundLabel.text = "\(fetchedConversions[indexPath.row].gbpValue)"
        cell.rupeeLabel.text = "\(fetchedConversions[indexPath.row].inrValue)"
        var association = fetchedConversions[indexPath.row].association
        if association == "0" {
            association = "None"
        }
        cell.associations.text = association
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fetchedConversions == nil {
            return 0
        }
        return fetchedConversions.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
