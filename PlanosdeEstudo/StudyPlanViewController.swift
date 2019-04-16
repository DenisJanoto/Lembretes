//
//  StudyPlanViewController.swift
//  PlanosdeEstudo
//
//  Created by Denis Janoto on 02/04/2019.
//  Copyright © 2019 Denis Janoto. All rights reserved.
//

import UIKit
import UserNotifications

class StudyPlanViewController: UIViewController {
    
    @IBOutlet weak var tfMateria: UITextField!
    @IBOutlet weak var tfAssunto: UITextField!
    @IBOutlet weak var dpData: UIDatePicker!
    
    
    let sm = StudyManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dpData.minimumDate = Date()
    }
    
    
    //BOTÃO CADASTAR
    @IBAction func btCadastrar(_ sender: UIButton) {
        //Pega qualquer data desde 1970
        let id = String(Date().timeIntervalSince1970)
        let studyPlan = StudyPlan(course: tfMateria.text!, section: tfAssunto.text!, date: dpData.date, done: false, id: id)
        
        
        //Configuração da Notificação
        let content = UNMutableNotificationContent()
        content.title = "Lembrete"
        content.subtitle = "Matéria:\(studyPlan.course)"
        content.body = "Estudar\(studyPlan.course)"
        content.categoryIdentifier = "Lembrete"//Tipo de categoria que a notificação faz parte
        
        //Sons na natificação
        //content.sound = UNNotificationSound(named: "arquivodesom.caf")
        
        
        /*Trigguers - Dispara uma notificação após determinado tempo
         Tipo 1 - Dispara após horas ou minutos
         Tipo 2 - Dispara em uma data específica no calendário
         Tipo 3 - Dispara de acordo com a localização do usuário no mapa.
         */
        
        
        //tipo1 - Hora
        //let triggrer = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        //tipo2 - Data do calendário (datepicker)
        let dateComponentes = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: dpData.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponentes, repeats: false)
        
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
   
        sm.addPlan(studyPlan)
        navigationController?.popViewController(animated: true)
    }
    
    
}
