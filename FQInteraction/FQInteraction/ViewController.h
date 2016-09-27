//
//  ViewController.h
//  FQInteraction
//
//  Created by 冯倩 on 16/9/27.
//  Copyright © 2016年 冯倩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSObjcDelegate <JSExport>
- (id)getUserInfo;
- (void)showView:(NSString *)str;
@end


@interface ViewController : UIViewController<JSObjcDelegate>
@end

