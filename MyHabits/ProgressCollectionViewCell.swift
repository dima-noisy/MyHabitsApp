import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    private enum Constants {
        static let verticalSpacing: CGFloat = 8.0
        static let horizontalPadding: CGFloat = 16.0
        static let profileDescriptionVerticalPadding: CGFloat = 8.0
        static let contentViewCornerRadius: CGFloat = 10.0
    }
    
    private lazy var motivationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Всё получится!"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1

        return label
    }()
    
    private lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(Int(HabitsStore.shared.todayProgress * 100.0))%"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1

        return label
    }()
    
    private lazy var progressLine: UIProgressView = {
        let progressLine = UIProgressView(progressViewStyle: .default)
        progressLine.translatesAutoresizingMaskIntoConstraints = false
        
        progressLine.trackTintColor = .systemGray2
        progressLine.progressTintColor = UIColor(named: "Color(161,22,204)")
        progressLine.setProgress(HabitsStore.shared.todayProgress, animated: true)
        
        return progressLine
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupView()
        addSubviews()
        setupLayouts()
        updateProgressLine()
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
        contentView.addSubview(motivationLabel)
        contentView.addSubview(progressLabel)
        contentView.addSubview(progressLine)
    }
    
    private func setupLayouts() {
        
        NSLayoutConstraint.activate([
            motivationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            motivationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            
            progressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            progressLabel.topAnchor.constraint(equalTo: motivationLabel.topAnchor),
            
            progressLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            progressLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            progressLine.topAnchor.constraint(equalTo: motivationLabel.bottomAnchor, constant: 16.0),
            progressLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0),
        ])
    }
    
    func updateProgressLine() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateLine(notification:)), name: Notification.Name(rawValue: "updateProgressByAddHabit"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateLine(notification:)), name: Notification.Name(rawValue: "updateProgressByPressCheck"), object: nil)
    }
    
    @objc func updateLine(notification: NSNotification) {
        progressLine.setProgress(HabitsStore.shared.todayProgress, animated: true)
        progressLabel.text = "\(Int(HabitsStore.shared.todayProgress * 100.0))%"
    }
    
}

