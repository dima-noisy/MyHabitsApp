import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    private enum Constants {
        static let verticalSpacing: CGFloat = 8.0
        static let horizontalPadding: CGFloat = 16.0
        static let profileDescriptionVerticalPadding: CGFloat = 8.0
        static let contentViewCornerRadius: CGFloat = 10.0
    }
    
    public lazy var habitName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2

        return label
    }()
    
    private lazy var everyDayAt: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
        label.textColor = .systemGray2
        
        return label
    }()
    
    private lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
        label.textColor = .systemGray
        
        return label
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.contentsGravity = .center
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20.0
        button.layer.borderWidth = 2.0
        
        
        //let habbitsState = (HabitsStore.shared.habits.filter { $0.name.contains(habitName.text!) } ).first
        //if habbitsState!.isAlreadyTakenToday {
            //let actualBackground = habitName.textColor
            //doneButton.backgroundColor = actualBackground
            //let imageConfig = UIImage.SymbolConfiguration(weight: .bold)
            //let imageCheck = UIImage(systemName: "checkmark", withConfiguration: imageConfig)?.withTintColor(.white, renderingMode: .alwaysOriginal)
            //doneButton.setImage(imageCheck,for: .normal)
        //}
        
        button.addTarget(self, action: #selector(didTapDone(_:)), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupView()
        addSubviews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = Constants.contentViewCornerRadius
        contentView.backgroundColor = .white
    }
    
    private func addSubviews() {
        contentView.addSubview(habitName)
        contentView.addSubview(everyDayAt)
        contentView.addSubview(counterLabel)
        contentView.addSubview(doneButton)
    }
    
    private func setupLayouts() {
        
        NSLayoutConstraint.activate([
            habitName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            habitName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -70.0),
            habitName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            
            everyDayAt.leadingAnchor.constraint(equalTo: habitName.leadingAnchor),
            everyDayAt.topAnchor.constraint(equalTo: habitName.bottomAnchor, constant: 10.0),
            
            counterLabel.leadingAnchor.constraint(equalTo: habitName.leadingAnchor),
            counterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0),
            
            doneButton.widthAnchor.constraint(equalToConstant: 40.0),
            doneButton.heightAnchor.constraint(equalToConstant: 40.0),
            doneButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25.0),
            doneButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(with oneOfHabits: Habit) {
        habitName.text = oneOfHabits.name
        habitName.textColor = oneOfHabits.color
        everyDayAt.text = oneOfHabits.dateString
        let indexSearcher = HabitsStore().habits.firstIndex(of: oneOfHabits)
        counterLabel.text = "Счётчик: \(HabitsStore.shared.habits[indexSearcher!].trackDates.count)"
        doneButton.layer.borderColor = oneOfHabits.color.cgColor
    }
    
    @objc func didTapDone(_ sender: UIButton!) {

        let habbitsSalvation = (HabitsStore.shared.habits.filter { $0.name.contains(habitName.text!) } ).first!

        if habbitsSalvation.isAlreadyTakenToday {
            print("is Already Taken Today")
        } else {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "updateProgressByPressCheck"), object: nil)
            
            HabitsStore.shared.track(habbitsSalvation)
            
            doneButton.backgroundColor = habbitsSalvation.color
            let imageConfig = UIImage.SymbolConfiguration(weight: .bold)
            let imageCheck = UIImage(systemName: "checkmark", withConfiguration: imageConfig)?.withTintColor(.white, renderingMode: .alwaysOriginal)
            doneButton.setImage(imageCheck,for: .normal)
        }
    }
    
}
