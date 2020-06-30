### 1. Set user-default

#### *** AppDelegate
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    /// Reset all key
    if AppDelegate.isUITestingEnabled {
        self.setUseDefaults()
    }
}

//MARK:- Reset key UserDefault for UITest
extension AppDelegate {
    static let uiTestingKeyPrefix = "UI-TestingKey_"
    static var isUITestingEnabled: Bool {
        get {
            return ProcessInfo.processInfo.arguments.contains("UI-Testing")
        }
    }
    
    private func setUseDefaults() {
        for (key, value) in ProcessInfo.processInfo.environment where key.hasPrefix(AppDelegate.uiTestingKeyPrefix) {
            let userDefaultsKey = key.truncateUITestingKey()
            switch value {
            case "YES":
                ///UserDefaults.standard.set(true, forKey: userDefaultsKey)
                Helper.shared.saveUserDefault(key: kUserInfo, value: ["user_id": "xxxx", "email": "xxx.xxxxxx@gmail.com", "pass": "xxxxxx"])
            case "NO":
                ///UserDefaults.standard.set(false, forKey: userDefaultsKey)
                Helper.shared.removeUserDefault(key: kUserInfo)
            default:
                UserDefaults.standard.set(value, forKey: userDefaultsKey)
            }
        }
    }
}

extension String {
    func truncateUITestingKey() -> String {
        if let range = self.range(of: AppDelegate.uiTestingKeyPrefix) {
            let userDefaultsKey = self[range.upperBound...]
            return String(userDefaultsKey)
        }
        return self
    }
}
```

#### *** HuCaChat_DevUITests
```swift
class HuCaChat_DevUITests: XCTestCase {
    static let kUserInfo = "UI-TestingKey_kUserInfo"

    // MARK: - Setup for UI Test
    override func setUp() {
        /// In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launchArguments.append("UI-Testing")
        app.launchEnvironment[HuCaChat_DevUITests.kUserInfo] = "NO"
        app.launch()
    }
}
```

### 2. Accessibility Identifier
```swift
let btn = UIButton()
btn.addTarget(self, action: #selector(self.tappedBtnHome(btn:)), for: .touchUpInside)
btn.setImage(#imageLiteral(resourceName: "tabbar_chat_off"), for: .normal)
btn.setImage(#imageLiteral(resourceName: "tabbar_chat_on"), for: .selected)
btn.accessibilityIdentifier = "btnHomeBar"
```

```swift
Key path                | Type   | Value
accessibilityIdentifier | String | tableView
```
### 3. Wait for element to appear
```swift
// MARK: - Other method
    
/// Wait for element/ui to appear
private func waitForElementToAppear(_ element: XCUIElement, file: String = #file, line: UInt = #line) {
    let existsPredicate = NSPredicate(format: "exists == true")
    expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
    
    waitForExpectations(timeout: 5) { (error) -> Void in
        if (error != nil) {
            let message = "Failed to find \(element) after 5 seconds."
            self.recordFailure(withDescription: message, inFile: file, atLine: Int(line), expected: true)
        }
    }
}

/// Wait for keyboard to appear
private func tapElementAndWaitForKeyboardToAppear(_ element: XCUIElement) {
    let keyboard = XCUIApplication().keyboards.element
    while (true) {
        element.tap()
        if keyboard.exists {
            break;
        }
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.5))
    }
}
```
