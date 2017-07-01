/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Popover view controller for app settings.
*/

import UIKit
import SceneKit

enum Setting: String {
    // Bool settings with SettingsViewController switches
    case debugMode
    case scaleWithPinchGesture
    case ambientLightEstimation
    case dragOnInfinitePlanes
    case showHitTestAPI
    case use3DOFTracking
    case use3DOFFallback
	case useOcclusionPlanes

    // Integer state used in virtual object picker
    case selectedObjectID

    static func registerDefaults() {
        UserDefaults.standard.register(defaults: [
            Setting.ambientLightEstimation.rawValue: true,
            Setting.dragOnInfinitePlanes.rawValue: true,
            Setting.selectedObjectID.rawValue: -1
        ])
    }
}
extension UserDefaults {
    func bool(for setting: Setting) -> Bool {
        return bool(forKey: setting.rawValue)
    }
    func set(_ bool: Bool, for setting: Setting) {
        set(bool, forKey: setting.rawValue)
    }
    func integer(for setting: Setting) -> Int {
        return integer(forKey: setting.rawValue)
    }
    func set(_ integer: Int, for setting: Setting) {
        set(integer, forKey: setting.rawValue)
    }
}

class SettingsViewController: UITableViewController {
	
	@IBOutlet weak var debugModeSwitch: UISwitch!
	@IBOutlet weak var scaleWithPinchGestureSwitch: UISwitch!
	@IBOutlet weak var ambientLightEstimateSwitch: UISwitch!
	@IBOutlet weak var dragOnInfinitePlanesSwitch: UISwitch!
	@IBOutlet weak var showHitTestAPISwitch: UISwitch!
	@IBOutlet weak var use3DOFTrackingSwitch: UISwitch!
	@IBOutlet weak var useAuto3DOFFallbackSwitch: UISwitch!
	@IBOutlet weak var useOcclusionPlanesSwitch: UISwitch!
    @IBOutlet weak var resetAllAnimationsButton: UIButton!
    
    var virtualObject:SCNNode = SCNNode()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        populateSettings()
    }

	@IBAction func didChangeSetting(_ sender: UISwitch) {
		let defaults = UserDefaults.standard
		switch sender {
            case debugModeSwitch:
                defaults.set(sender.isOn, for: .debugMode)
            case scaleWithPinchGestureSwitch:
                defaults.set(sender.isOn, for: .scaleWithPinchGesture)
            case ambientLightEstimateSwitch:
                defaults.set(sender.isOn, for: .ambientLightEstimation)
            case dragOnInfinitePlanesSwitch:
                defaults.set(sender.isOn, for: .dragOnInfinitePlanes)
            case showHitTestAPISwitch:
                defaults.set(sender.isOn, for: .showHitTestAPI)
            case use3DOFTrackingSwitch:
                defaults.set(sender.isOn, for: .use3DOFTracking)
            case useAuto3DOFFallbackSwitch:
                defaults.set(sender.isOn, for: .use3DOFFallback)
			case useOcclusionPlanesSwitch:
				defaults.set(sender.isOn, for: .useOcclusionPlanes)
            default: break
		}
	}
	
    @IBAction func resetAllAnimations(_ sender: Any) {
        print("\n[DEBUG] RESET ALL ANIMATION!")
//        print(self.virtualObject.childNodes)
        for child in self.virtualObject.childNodes {
            if (child.name == "Virtual object root node") {
                print("== [child] \(String(describing: child.name))")
                for child1 in child.childNodes {
                    print("==== [child1] \(String(describing: child1.name))")
                    for child2 in child1.childNodes {
                        print("==== ==== [child2] \(String(describing: child2.name))")
                        for child3 in child2.childNodes {
                            print("==== ==== [child3] \(String(describing: child3.name))")
                            child3.animationPlayer(forKey: child3.animationKeys[0])?.stop()
                            child3.animationPlayer(forKey: child3.animationKeys[0])?.play()
                        }
                    }
                }
            }
        }
    }
    private func populateSettings() {
		let defaults = UserDefaults.standard

		debugModeSwitch.isOn = defaults.bool(for: Setting.debugMode)
		scaleWithPinchGestureSwitch.isOn = defaults.bool(for: .scaleWithPinchGesture)
		ambientLightEstimateSwitch.isOn = defaults.bool(for: .ambientLightEstimation)
		dragOnInfinitePlanesSwitch.isOn = defaults.bool(for: .dragOnInfinitePlanes)
		showHitTestAPISwitch.isOn = defaults.bool(for: .showHitTestAPI)
		use3DOFTrackingSwitch.isOn = defaults.bool(for: .use3DOFTracking)
		useAuto3DOFFallbackSwitch.isOn = defaults.bool(for: .use3DOFFallback)
		useOcclusionPlanesSwitch.isOn = defaults.bool(for: .useOcclusionPlanes)
	}
}
