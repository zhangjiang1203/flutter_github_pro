import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let controler  = window.rootViewController as! FlutterViewController
    
    let methodChannel = FlutterMethodChannel(name: "com.zhangj.fluttergithubpro.flutter.io/battery", binaryMessenger: controler.binaryMessenger)
    methodChannel.setMethodCallHandler { (call, result) in
        print("开始方法调用")
        //获取电池信息
        if (call.method == "getBatteryLevel"){
            self.getBatteryLevel(result: result)
        }else{
            result(FlutterMethodNotImplemented)
        }
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
    private func getBatteryLevel(result:FlutterResult){
        let devive = UIDevice.current
        devive.isBatteryMonitoringEnabled = true
        if(devive.batteryState == .unknown){
            result(FlutterError.init(code: "UNAVAILABLE", message: "电池信息不可用", details: nil))
        }else{
            result(Int(devive.batteryLevel * 100))
        }
    }
}

extension FlutterViewController{
    //摇一摇功能
    override open var canBecomeFirstResponder: Bool{
        get{
            return true
        }
    }
    
    override open func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("开始晃动")
    }
    
    override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            let alertView = UIAlertController(title: "LookIn功能", message: "", preferredStyle: .alert)
            let docLookIn = UIAlertAction(title: "导出为LookIn文档", style: .default) { (action) in
                NotificationCenter.default.post(name: NSNotification.Name("Lookin_Export"), object: nil)
            }
            let show2DAction = UIAlertAction(title: "2D视图", style: .default) { (action) in
                NotificationCenter.default.post(name: NSNotification.Name("Lookin_2D"), object: nil)
            }
            let show3DAction = UIAlertAction(title: "3D视图", style: .default) { (action) in
                NotificationCenter.default.post(name: NSNotification.Name("Lookin_3D"), object: nil)
            }
            let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
                
            }
            alertView.addAction(docLookIn)
            alertView.addAction(show2DAction)
            alertView.addAction(show3DAction)
            alertView.addAction(cancelAction)
            self.present(alertView, animated: true)
        }
    }
    
    override open func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("取消晃动")
    }
}
