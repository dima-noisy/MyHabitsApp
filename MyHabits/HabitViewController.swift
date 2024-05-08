import UIKit

class HabitViewController: UIViewController {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "НАЗВАНИЕ"
        
        return label
    }()
    
    private lazy var nameField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        
        field.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        
        return field
    }()
    
    private lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "ЦВЕТ"
        
        return label
    }()
    
    private lazy var colorButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.cornerRadius = 20.0
        button.backgroundColor = UIColor(named: "Color(255,159,79)")
        
        button.addTarget(self, action: #selector(didTapSelectColor), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "ВРЕМЯ"
        
        return label
    }()
    
    private lazy var everyDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "Каждый день в "
        
        return label
    }()
    
    private lazy var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        
        picker.datePickerMode = .time
        picker.tintColor = UIColor(named: "Color(161,22,204)")
        picker.backgroundColor = .systemBackground
        
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Создать"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(savePressed))
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func addSubviews() {
        view.addSubview(nameLabel)
        view.addSubview(nameField)
        view.addSubview(colorLabel)
        view.addSubview(colorButton)
        view.addSubview(timeLabel)
        view.addSubview(everyDayLabel)
        view.addSubview(timePicker)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16.0),
            nameLabel.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 16.0),
            
            nameField.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16.0),
            nameField.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16.0),
            nameField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8.0),
            
            colorLabel.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16.0),
            colorLabel.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 16.0),
            
            colorButton.widthAnchor.constraint(equalToConstant: 40.0),
            colorButton.heightAnchor.constraint(equalToConstant: 40.0),
            colorButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16.0),
            colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 8.0),
            
            timeLabel.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16.0),
            timeLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 16.0),
            
            everyDayLabel.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16.0),
            everyDayLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8.0),
            
            timePicker.leadingAnchor.constraint(equalTo: everyDayLabel.trailingAnchor),
            timePicker.centerYAnchor.constraint(equalTo: everyDayLabel.centerYAnchor)
        ])
    }
    
    @objc func cancelPressed() {
        dismiss(animated: true)
    }
    
    @objc func savePressed() {
        let newHabit = Habit(name: nameField.text ?? "Без названия",
                             date: timePicker.date,
                             color: (colorButton.backgroundColor ?? UIColor(named: "Color(161,22,204)"))!)
        let store = HabitsStore.shared
        store.habits.append(newHabit)
        
        NotificationCenter.default.post(name: Notification.Name("AddNewHabbit"), object: nil)
        NotificationCenter.default.post(name: Notification.Name("updateProgressByAddHabit"), object: nil)
        
        dismiss(animated: true)
    }
    
    @objc func didTapSelectColor() {
        if #available(iOS 14.0, *) {
            let colorPickerVC = UIColorPickerViewController()
            
            colorPickerVC.delegate = self
            present(colorPickerVC, animated: true)
        }
        
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    @available(iOS 14.0, *)
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        colorButton.backgroundColor = color
    }
}
