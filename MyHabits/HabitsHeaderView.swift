import UIKit

class HabitsHeaderView: UIView {
    
    var allHabits: Int = 4
    var doneHabits: Int = 2
    lazy var progress: Float = { (Float(doneHabits) / Float(allHabits)) }()
    
    private lazy var motivationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Всё получится!"
        label.textColor = .systemGray2
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1

        return label
    }()
    
    private lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(Int(progress * 100.0))%"
        label.textColor = .systemGray2
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1

        return label
    }()
    
    private lazy var progressLine: UIProgressView = {
        let progressLine = UIProgressView(progressViewStyle: .default)
        progressLine.translatesAutoresizingMaskIntoConstraints = false
        
        progressLine.trackTintColor = .systemGray2
        progressLine.progressTintColor = UIColor(named: "Color(161,22,204)")
        progressLine.setProgress(progress, animated: true)
        
        return progressLine
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        self.addSubview(motivationLabel)
        self.addSubview(progressLabel)
        self.addSubview(progressLine)
    }
    
    private func setupConstraints() {
        
        let safeAreaGuide = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            motivationLabel.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16.0),
            motivationLabel.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 16.0),
            
            progressLabel.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16.0),
            progressLabel.topAnchor.constraint(equalTo: motivationLabel.topAnchor),
            
            progressLine.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16.0),
            progressLine.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16.0),
            progressLine.topAnchor.constraint(equalTo: motivationLabel.bottomAnchor, constant: 16.0),
            progressLine.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor, constant: -16.0),
        ])
    }
}
