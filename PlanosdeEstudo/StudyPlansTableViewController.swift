//
//  StudyPlansTableViewController.swift
//  PlanosdeEstudo
//
//  Created by Denis Janoto on 02/04/2019.
//  Copyright © 2019 Denis Janoto. All rights reserved.
//

import UIKit

class StudyPlansTableViewController: UITableViewController {

    var sm = StudyManager.shared
    
    //Criando data manual
    let dateFormater:DateFormatter={
        let df = DateFormatter()
        df.dateFormat = "dd/HH/yy HH:mm"
        return df
    }()
    
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //LISTENER DO BROADCAST DA NOTIFICAÇÃO (DISPARADO NO FINAL DO APPDELEGADE)
        NotificationCenter.default.addObserver(self, selector: #selector(onRecieve(notification:)), name: NSNotification.Name(rawValue: "Confirmed"), object: nil)

    }
    @objc func onRecieve(notification:Notification){
        if let userInfo = notification.userInfo,let id = userInfo["id"] as? String{
            sm.setPlanDone(id: id)
            tableView.reloadData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sm.studyPlans.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let studyPlan = sm.studyPlans[indexPath.row]
        cell.textLabel?.text = studyPlan.section
        cell.detailTextLabel?.text = dateFormater.string(from: studyPlan.date)
     
        cell.backgroundColor = studyPlan.done ? .green : .white

        return cell
    }
    
    //DELETAR DA TABLEVIEW
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
          sm.removePlan(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
            
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


}
