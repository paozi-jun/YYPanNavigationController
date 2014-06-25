

import UIKit


let mochaColorGreen2 = UIColor(red: 0x96/255.0, green: 0xc8/255.0, blue: 0x60/255.0, alpha: 1)

class YYNavigationController: UINavigationController {

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    init(rootViewController: UIViewController!)
    {
        super.init(rootViewController: rootViewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.navigationBar.setBackgroundImage(YYViewUtil.imageWithColor(mochaColorGreen2), forBarMetrics: UIBarMetrics.Default)
      
        self.navigationBar.barTintColor = mochaColorGreen2
        //去掉下面的黑线
        for view : AnyObject in self.navigationBar.subviews {
            if view is UIView{
                var supView = view as UIView;
                for v: AnyObject in supView.subviews {
                    if v is UIView {
                        var subView = v as UIView;
                        subView.frame = CGRectZero;
                    }
                }
            }
        }
        
        self.navigationBar.translucent = false;
        // Do any additional setup after loading the view.
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
