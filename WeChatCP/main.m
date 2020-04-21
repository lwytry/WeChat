//
//  main.m
//  WeChatCP
//
//  Created by lwy on 2020/4/12.
//  Copyright © 2020 lwy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([MyAppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
