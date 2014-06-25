

import UIKit

class YYSocialTabViewController: UIViewController {

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.orangeColor()
        
        var pushButton = UIButton(frame: CGRectMake(0, 100, 160, 50))
        pushButton.setTitle("push", forState: UIControlState.Normal)
        pushButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        pushButton.addTarget(self, action: "pushButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(pushButton)
        
        var popButton = UIButton(frame: CGRectMake(160, 100, 160, 50))
        popButton.setTitle("pop", forState: UIControlState.Normal)
        popButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        popButton.addTarget(self, action: "popButtonClick", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(popButton)
        // Do any additional setup after loading the view.
    }

    func pushButtonClick(){
        var nextVC = YYSocialTabViewController(nibName: nil, bundle: nil)
        self.navigationController.pushViewController(nextVC, animated: true);
        
    }
    
    func popButtonClick(){
        self.navigationController.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
