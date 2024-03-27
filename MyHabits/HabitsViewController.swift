import UIKit

public class HabitsViewController: UIViewController {
    
    private enum CellReuseID: String {
        case progress = "ProgressCollectionViewCell_ReuseID"
        case habit = "HabitCollectionViewCell_ReuseID"
    }
    
    private lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: viewLayout
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(
            ProgressCollectionViewCell.self,
            forCellWithReuseIdentifier: CellReuseID.progress.rawValue
        )
        collectionView.register(
            HabitCollectionViewCell.self,
            forCellWithReuseIdentifier: CellReuseID.habit.rawValue
        )
        
        return collectionView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupCollectionView()
        setupLayouts()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Сегодня"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupLayouts() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }
    
    private enum LayoutConstant {
        static let spacing: CGFloat = 16.0
        static let itemHeight: CGFloat = 70.0
    }
    
    /*
    private func tuneTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50.0
        
    }
*/
    
    @objc func addTapped() {
        let newHabitViewController = HabitViewController()
        //newHabitViewController.delegate = self
        //newHabitViewController.modalTransitionStyle = .coverVertical
        //newHabitViewController.modalPresentationStyle = .fullScreen
        navigationController?.present(UINavigationController(rootViewController: newHabitViewController), animated: true)
        //present(newHabitViewController, animated: true)
    }
     
}

extension HabitsViewController: UICollectionViewDataSource {
    
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if section == 0 {
            return 1
        } else {
            return HabitsStore.shared.habits.count
        }
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CellReuseID.progress.rawValue,
                for: indexPath
            ) as? ProgressCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            return cell
        }
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CellReuseID.habit.rawValue,
            for: indexPath
        ) as? HabitCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let oneOfHabits = HabitsStore.shared.habits[indexPath.row]
        cell.configure(with: oneOfHabits)
        
        return cell
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    private func itemWidth(
        for width: CGFloat,
        spacing: CGFloat
    ) -> CGFloat {
        let itemsInRow: CGFloat = 1
        
        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        
        return floor(finalWidth)
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = itemWidth(
            for: view.frame.width,
            spacing: LayoutConstant.spacing
        )
        
        return CGSize(width: width, height: LayoutConstant.itemHeight)
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        UIEdgeInsets(
            top: LayoutConstant.spacing,
            left: LayoutConstant.spacing,
            bottom: LayoutConstant.spacing,
            right: LayoutConstant.spacing
        )
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        LayoutConstant.spacing
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        LayoutConstant.spacing
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        cell.contentView.backgroundColor = .systemBackground
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print("Did select cell at \(indexPath.row)")
        
        //let profile = profiles[indexPath.row]
        
        let viewController = UIViewController()
        //viewController.title = profile.name
        viewController.view.backgroundColor = .systemBackground
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
