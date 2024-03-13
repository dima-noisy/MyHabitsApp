import UIKit

public class HabitsViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()

    enum CellReuseID: String {
        case habitsID = "HabitsTableViewCell_ReuseID"
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstraints()
        tuneTableView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Сегодня"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }
    
    private func tuneTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50.0
        
        tableView.register(HabitsTableViewCell.self, forCellReuseIdentifier: CellReuseID.habitsID.rawValue)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return HabitsHeaderView()
    }

    @objc func addTapped() {
        let newHabitViewController = HabitViewController()
        newHabitViewController.modalTransitionStyle = .coverVertical
        newHabitViewController.modalPresentationStyle = .fullScreen
        present(newHabitViewController, animated: true)
    }
}

extension HabitsViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        HabitsStore().habits.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseID.habitsID.rawValue,
            for: indexPath
        ) as? HabitsTableViewCell else {
            return UITableViewCell()
        }
        
        let habit = HabitsStore().habits[indexPath.row]
        cell.configure(with: habit)
        
        return cell
    } 
}

extension HabitsViewController: UITableViewDelegate {}
