import UIKit
import SwipeCellKit

class RolGetAllController: UIViewController {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var rol : [Rol] = []
    
    var IdRol : Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "rolCell", bundle: .main), forCellReuseIdentifier:"rolCell")
        
        tableView.delegate = self
        tableView.dataSource = self
      
       // textField.delegate = self;
        
        updateUI()
    }
}


//MARK: TABLEVIEW
extension RolGetAllController :UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        self.rol.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rolCell", for: indexPath) as! rolCell
       
        cell.delegate = self
        
        cell.lblIdRol.text = rol[indexPath.row].IdRol?.description
        cell.lblNombre.text = rol[indexPath.row].Nombre
        
        
        return cell
    }
}

//MARK: SWIPECELLKIT
extension RolGetAllController : SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        
        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [self] action, indexPath in
                
                
                let result =  RolViewModel.Delete(IdRol: self.rol[indexPath.row].IdRol!)
                
                if result.Correct! {
                    print("Rol Elimnado")
                    self.updateUI()
                }else{
                    print("Ocurrio un error")
                }
                
            }
            return [deleteAction]
        }
        if orientation == .left {
            let updateAction = SwipeAction(style: .default, title: "Update") { action, indexPath in
                
                self.IdRol = self.rol[indexPath.row].IdRol!
                self.performSegue(withIdentifier: "RolFormController", sender: self)
                
            }
            updateAction.backgroundColor = .systemBlue
            return [updateAction]
           
        }
        return nil
        
        
    }
    
    func updateUI(){
        var result = RolViewModel.GetAll()
        rol.removeAll()
        if result.Correct!{
            for objRol in result.Objects!{
                let roles = objRol as! Rol //Unboxing
                rol.append(roles)
            }
            
            tableView.reloadData()
            
        }
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           //controlar que hacer antes de ir a la siguiente vista
           if segue.identifier == "RolFormController"{
               let formControl = segue.destination as! RolViewController
               formControl.IdRol = self.IdRol
               
           }
       }

    
}
