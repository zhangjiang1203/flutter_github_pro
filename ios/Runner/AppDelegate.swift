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
    
    let methodChannel = FlutterMethodChannel.init(name: "com.zhangj.fluttergithubpro.flutter.io/battery", binaryMessenger: controler.binaryMessenger)
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
