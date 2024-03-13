import UIKit

class TabAndNavBarsController: UITabBarController {
    
    var firstTabNavigationController: UINavigationController!
    var secondTabNavigationController: UINavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        
        let tabBarController = UITabBarController()
        let habitsViewController = HabitsViewController()
        let infoViewController = InfoViewController()
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        //UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        //if #available(iOS 15.0, *) {
            //UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        //}
        
        firstTabNavigationController = UINavigationController.init(rootViewController: HabitsViewController())
        secondTabNavigationController = UINavigationController.init(rootViewController: InfoViewController())
        
        self.viewControllers = [firstTabNavigationController, secondTabNavigationController]
        
        let item1 = UITabBarItem(title: "Привычки", image: UIImage(systemName: "rectangle.grid.1x2.fill"), tag: 0)
        let item2 = UITabBarItem(title: "Информация", image: UIImage(systemName: "info.circle.fill"), tag: 1)
        
        firstTabNavigationController.tabBarItem = item1
        secondTabNavigationController.tabBarItem = item2
        
        //UITabBar.appearance().backgroundColor = UIColor(named: "Color(242,242,247)")
        UITabBar.appearance().tintColor = UIColor(named: "Color(161,22,204)")
        //UINavigationBar.appearance().backgroundColor = UIColor(named: "Color(242,242,247)")
        
        let controllers = [habitsViewController, infoViewController]
        tabBarController.viewControllers = controllers.map {
            UINavigationController(rootViewController: $0)
        }
        tabBarController.selectedIndex = 0
    }
}
