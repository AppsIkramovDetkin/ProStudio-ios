//
//  AppDelegate.swift
//  ProStudio
//
//  Created by Nikita on 22/06/2018.
//  Copyright © 2018 Nikita. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("test build")
        
        //TEMP LOADING VIEW DELETE IT AFTER LOAD TO GIT
        let root: RegistraionViewController = RegistraionViewController()
        if let window = self.window {
            window.rootViewController = root
        }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
			
			FirebaseApp.configure()
			
			let chat = FBChat(chat_ID: "12", from: 1, to: 2, failure: createChatFailure)
			chat.sendText(text: "message 1", failure: messageFailure, success: messageSuccess)
			chat.sendText(text: "message 2", failure: messageFailure, success: messageSuccess)
			
			if let localFile = Bundle.main.url(forResource: "image", withExtension: "jpg"){
				chat.sendImage(imageURL: localFile, failure: messageFailure, success: messageSuccess)
				chat.sendVideo(videoURL: localFile, failure: messageFailure, success: messageSuccess)
			}
			
			let user = FBUser(email: "aizikovich4@mail2.ru", password: "qwerty")
			let auth = FBAuthentication()
			auth.register(email: user.getEmail(), password: user.getPassword(), failure: registrationFailure, success: registrationSuccess )
			auth.login(user: user, failure: loginFailure, success: loginSuccess)
        return true
    }
	
	func messageFailure(err: Error) {
		print("messageFailure")
	}
	
	func messageSuccess() {
		print("messageSuccess")
	}
	
	func createChatFailure(err: Error) {
		print("createChatFailure")
	}
	
	func registrationSuccess() {
		print("registrationSuccess")
	}
	
	func registrationFailure() {
		print("registrationFailure")
	}
	
	func loginSuccess() {
		print("loginSuccess")
	}
	
	func loginFailure() {
		print("loginFailure")
	}

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

