import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    private lazy var habitName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 1

        return label
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
        //contentView.layer.cornerRadius = Constants.contentViewCornerRadius
        contentView.backgroundColor = .white
    }
    
    private func addSubviews() {
        contentView.addSubview(habitName)
    }
    
    private func setupLayouts() {
        
        //let safeAreaGuide = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            habitName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            habitName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0)
        ])
    }
    
    func configure(with oneOfHabits: Habit) {
        habitName.text = oneOfHabits.name
        habitName.textColor = oneOfHabits.color
        //textView.text = post.description
        //likesView.text = "Likes: \(post.likes)"
        //viewsView.text = "Views: \(post.views)"
        
        //let imageProcessor = ImageProcessor()
        //imageProcessor.processImage(sourceImage: photoView.image!, filter: .noir) {
            //photoView.image = $0
        //}
    }
}
