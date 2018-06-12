import GoogleAPIClientForREST
import GoogleSignIn
import UIKit

class ViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    private let scopes = [kGTLRAuthScopeSheetsSpreadsheetsReadonly]
    private let service = GTLRSheetsService()
    //    let output = UITextView()
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var todayView: UIView!
    @IBOutlet weak var saladLabel: UILabel!
    @IBOutlet weak var soupLabel: UILabel!
    @IBOutlet weak var entreeLabel: UILabel!
    @IBOutlet weak var garnishLabel: UILabel!
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var seachView: UIView!
    @IBAction func doneButton(_ sender: Any) {
        userName = nameField.text!
        self.listMajors()
    }
    
    var userName: String = ""
    var dinner = Dinner()
    let weekdaySheet = [1: "Понедельник !A3:M34", 2: "Вторник!A3:M34", 3: "Среда !A3:M34", 4: "Четверг !A3:M34", 5: "Пятница !A3:M34"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure Google Sign-in.
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes = scopes
        GIDSignIn.sharedInstance().signInSilently()
        todayView.isHidden = true
        view.addSubview(todayView);
        
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            showAlert(title: "Authentication Error", message: error.localizedDescription)
            self.service.authorizer = nil
        } else {
            
            self.signInButton.isHidden = true
            self.service.authorizer = user.authentication.fetcherAuthorizer()
        }
    }
    
    
    func listMajors() {
        let spreadsheetId = "1NrPDjp80_7venKB0OsIqZLrq47jbx9c-lrWILYJPS88"
        print(Date().dayNumberOfWeek())
        let range = weekdaySheet[Date().dayNumberOfWeek()!]
        print(range)
        let query = GTLRSheetsQuery_SpreadsheetsValuesGet
            .query(withSpreadsheetId: spreadsheetId, range:range!)
        service.executeQuery(query,
                             delegate: self,
                             didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:))
        )
    }
    
    // Process the response and display output
    @objc func displayResultWithTicket(ticket: GTLRServiceTicket,
                                       finishedWithObject result : GTLRSheets_ValueRange,
                                       error : NSError?) {
        
        if let error = error {
            showAlert(title: "Error", message: error.localizedDescription)
            return
        }
        
        let rows = result.values!
        
        if rows.isEmpty {
            //            output.text = "No data found."
            return
        }
        var i = 0
        dinner.weekdayDish()
        for row in rows {
            let name = row[0]
            if (name as! String).lowercased() == userName.lowercased() {
                saladLabel.text = dinner.getDinner(row: row as! [String], type: "salad")
                soupLabel.text = dinner.getDinner(row: row as! [String], type: "soup")
                entreeLabel.text = dinner.getDinner(row: row as! [String], type: "entree")
                garnishLabel.text = dinner.getDinner(row: row as! [String], type: "garnish")
                self.todayView.isHidden = false
                self.seachView.isHidden = true
                i = 1;
            }
        }
        if (i == 0) {
            showAlert(title: "Ошибка", message: "Нет данного имени")
        }
        
    }
    
    
    // убирается клавиатура при нажатии в любой точке экрана
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    // Helper for showing an alert
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.default,
            handler: nil
        )
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
