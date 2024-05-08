import UIKit

class HabitDetailsViewController: UIViewController {
    
    private enum CellReuseID: String {
        case data = "DatesTableViewCell_ReuseID"
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(named: "Color(242,242,247)")
        
        return tableView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        //navigationItem.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func editTapped() {
        //let newHabitViewController = HabitViewController()
        //newHabitViewController.delegate = self
        //newHabitViewController.modalTransitionStyle = .coverVertical
        //newHabitViewController.modalPresentationStyle = .fullScreen
        //navigationController?.present(UINavigationController(rootViewController: newHabitViewController), animated: true)
        //present(newHabitViewController, animated: true)
    }
}
