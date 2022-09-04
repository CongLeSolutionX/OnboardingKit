# OnboardingKit

OnboardingKit provides an onboarding flow that is simple and easy to implement.

<p align="center">
<img src="https://github.com/CongLeSolutionX/OnboardingKit/blob/45cf8e92721778fda74e51ed2760204332e009a8/Demo.gif" width="300" height="600"/>
</p>

## Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Credits](#credits)

## Requirements

- iOS 15.0 or later
- Xcode 13.0 or later
- Swift 5.0 or later


## Installation
There are two ways to use OnboardingKit in your project:
- using Swift Package Manager
- manual install (build frameworks or embed Xcode Project)

### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

> Xcode 11+ is required to build Onboardingit and SnapKit using Swift Package Manager.


To integrate OnboardingKit into your Xcode project using Swift Package Manager, add it to the dependencies value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/CongLeSolutionX/OnboardingKit.git", .upToNextMajor(from: "1.0.0"))
]
```

[Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

### Manually

If you prefer not to use Swift Package Manager, you can integrate OnboardingKit into your project manually.

---

## Usage

### Quick Start

```swift
import UIKit
import OnboardingKit

class ViewController: UIViewController {
    
    private var onboardingKit: OnboardingKit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async { // we dont need [weak self] since DispatchQueue.main.async does not create reference that being held by the ViewController
            self.onboardingKit = OnboardingKit(
                slides: [
                    .init(image: UIImage(named: "imSlide1")!,
                          title: "Personalized offers at 40,000+ places"),
                    .init(image: UIImage(named: "imSlide2")!,
                          title: "Stack your rewards every time you pay"),
                    .init(image: UIImage(named: "imSlide3")!,
                          title: "Enjoy now, pay later"),
                    .init(image: UIImage(named: "imSlide4")!,
                          title: "Earn cashback with your physical card"),
                    .init(image: UIImage(named: "imSlide5")!,
                          title: "Save and earn cashback with Deals or eCards")
                ],
                tintColor: UIColor(red: 133/255, green: 187/255, blue: 101/255, alpha: 1.0),
                themeFont: UIFont(
                    name: "Chalkboard SE Bold", size: 28) ??
                    .systemFont(ofSize: 28, weight: .bold)
            )
            self.onboardingKit?.delegate = self
            self.onboardingKit?.launchOnboarding(rootVC: self)
        }
    }
    
    // Transit to the first main view of the app
    private func transit(viewControler: UIViewController) {
        let foregroundScences = UIApplication.shared.connectedScenes.filter {
            $0.activationState == .foregroundActive
        }
        
        let window = foregroundScences
            .map{ $0 as? UIWindowScene }
            .compactMap { $0 }
            .first?.windows.filter({ $0.isKeyWindow })
            .first
        
        guard let uiWindow = window else { return }
        uiWindow.rootViewController = viewControler
        
        UIView.transition(
            with: uiWindow,
            duration: 0.3,
            options: [.transitionCrossDissolve],
            animations: nil,
            completion: nil
        )
    }
}
// MARK: - OnboardingKitDelegate
extension ViewController: OnboardingKitDelegate {
    func nextButtonDidTap(atIndex index: Int) {
        print("Next button is tapped at index: \(index)")
    }
    
    func getStartedButtonDidTap() {
        onboardingKit?.dismissOnboarding()
        onboardingKit = nil
        transit(viewControler: MainViewController())
    }
}

```

## Credits 

- Cong Le

## License

OnboardingKit is released under the MIT license. See [LICENSE](LICENSE.md) for details.
