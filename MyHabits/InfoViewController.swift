import UIKit

class InfoViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    private lazy var labelView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        label.text = "Привычка за 21 день"
        
        return label
    }()
    
    private lazy var textView: UILabel = {
        let textInf = UILabel()
        textInf.translatesAutoresizingMaskIntoConstraints = false
        
        textInf.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textInf.textColor = .black
        textInf.numberOfLines = 0
        textInf.text = """
Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:

1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.

2. Выдержать 2 дня в прежнем состоянии самоконтроля.

3. Отметить в дневнике первую неделю изменений и подвести первые итоги – что оказалось тяжело, что – легче, с чем еще предстоит серьезно бороться.

4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.

5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.

6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.

Источник: psychbook.ru
"""
        
        return textInf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Информация"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(labelView)
        contentView.addSubview(textView)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            labelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            labelView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16.0),
            
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            textView.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 16.0),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

