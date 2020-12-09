//
//  ThisWeeksPaisViewController.swift
//  Autime
//
//  Created by Luis Eduardo Ramos on 23/11/20.
//

// swiftlint:disable force_cast
// swiftlint:disable line_length
// swiftlint:disable trailing_whitespace
// swiftlint:disable vertical_whitespace
// swiftlint:disable opening_brace

import UIKit

class ThisWeeksPaisViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewFakeBar: UIView!
    
    //Variables
    var diasDaSemana: [String] = []
    var week: [String] = ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"]

    //ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .secondarySystemBackground
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        self.setWeek()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //NavBar
        navigationController?.isNavigationBarHidden = false
        
        //FakeNavBar
        self.viewFakeBar.layer.cornerRadius = 21
        viewFakeBar.backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.4588235294, blue: 1, alpha: 1)
        viewFakeBar.layer.shadowColor = UIColor.black.cgColor
        viewFakeBar.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        viewFakeBar.layer.shadowOpacity = 0.5
        viewFakeBar.layer.shadowRadius = 4.0
    }
    
    // MARK: - Table view data source
    //Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    //Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return diasDaSemana.count
    }
    //Cell Config
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let date = addNumberOfDaysToDate(date: Date(), count: indexPath.row)
        let format = DateFormatter()
        format.dateFormat = "dd/MM"
        let formattedDate = format.string(from: date)
        
        cell.textLabel?.text = String(diasDaSemana[indexPath.row])
        cell.detailTextLabel?.text = formattedDate
        cell.textLabel?.font = .rounded(ofSize: 17, weight: .regular)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dayActList = storyboard?.instantiateViewController(identifier: "ThisWeekDayViewController") as? ThisWeekDayViewController else {
            return
        }
        dayActList.weekDayName = diasDaSemana[indexPath.row]
        navigationController?.pushViewController(dayActList, animated: true)
    }
    
    func setWeek() {
        let calendar = Calendar.current
        let weekDay = calendar.component(.weekday, from: Date()) - 1

        for ind in 0...self.week.count-1 {
            diasDaSemana.append(week[(weekDay + ind)%7])
        }
    }
    
    func addNumberOfDaysToDate(date: Date, count: Int) -> Date{
        let newComponent = DateComponents(day: count)
        guard let newDate = Calendar.current.date(byAdding: newComponent, to: date) else {
            return date
        }
        return newDate
    }
}
