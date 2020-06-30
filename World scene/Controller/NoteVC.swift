//
// NoteVC.swift
//  World scene
//
//  Created by mahmoud diab on 6/27/20.
//  Copyright © 2020 Diab. All rights reserved.
//

import UIKit
import Firebase
class NoteVC: UIViewController  {
    
    @IBOutlet weak var interestesTableView: UITableView!
    @IBOutlet weak var addInterestBtn: UIButton!
    @IBOutlet weak var userInterestTxtField: UITextField!
    
    var interestData=[String]()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScene()
    }
    func setupScene() {
        addInterestBtn.bindToKeyboard()
        userInterestTxtField.delegate=self
        interestesTableView.dataSource = self
        interestesTableView.delegate = self
        fetchNotes()
        
    }
    @IBAction func addInterestPressed(_ sender: Any) {
        guard let currentUid = Firebase.Auth.auth().currentUser?.uid else { return }
        let interest = [userInterestTxtField.text:"1"]
        let ref = Database.database().reference().child("users").child(currentUid)
        ref.child("InterestsKeywords").updateChildValues(interest)
        ref.child("InterestsKeywords").observe(.value) { (snapshot) in
            guard let data = snapshot.value as? [String:Any] else { return }
            self.interestData = data.map{$0.key}
            self.interestesTableView.reloadData()
            
        }
        
    }
    func fetchNotes(){
        guard let currentUid = Firebase.Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child("users").child(currentUid)
        ref.child("InterestsKeywords").observe(.value) { (snapshot) in
            guard let data = snapshot.value as? [String:Any] else { return }
            self.interestData = data.map{$0.key}
            self.interestesTableView.reloadData()
            
        }
    }
    
    func deleteNote(at indexPath:IndexPath){
        let deletedItem =  interestData.remove(at: indexPath.row)
        guard let currentUid = Firebase.Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child("users").child(currentUid).child("InterestsKeywords").child(deletedItem)
        ref.removeValue()
    }
    @IBAction func signOut(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isSignedIn")
            dismiss(animated: true, completion:nil)
    }
    
    
}
extension  NoteVC:UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return interestData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "interestsCell", for: indexPath)
        cell.textLabel?.text = interestData[indexPath.row]
        cell.textLabel?.font = .systemFont(ofSize: 12)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.clipsToBounds = true
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
        let note = interestData[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "MyNoteVC") as? MyNoteVC
        vc!.note = note
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        let style = UITableViewCell.EditingStyle.none
        return style
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "DELETE") { (action, view, handler) in
            self.deleteNote(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.fetchNotes()
            tableView.reloadData()
            
        } 
        deleteAction.backgroundColor = .black
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}

extension NoteVC:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
