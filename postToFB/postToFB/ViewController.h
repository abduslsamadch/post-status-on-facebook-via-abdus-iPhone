//
//  ViewController.h
//  postToFB
//
//  Created by Shafqat Muneer on 1/16/13.
//  Copyright (c) 2013 GeniTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface ViewController : UIViewController
{
    BOOL isPublishedOnce;
    IBOutlet UITextField *statusTextField;

}
- (IBAction)postButtonClicked:(UIButton *)sender;
- (IBAction)authorizeButtonCLick:(id)sender;

@end
