import UIKit

class HabitsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Сегодня"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}
