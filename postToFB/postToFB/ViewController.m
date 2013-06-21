//
//  ViewController.m
//  postToFB
//
//  Created by Shafqat Muneer on 1/16/13.
//  Copyright (c) 2013 GeniTeam. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [statusTextField release];
    [super dealloc];
}
- (IBAction)postButtonClicked:(UIButton *)sender
{
    [statusTextField resignFirstResponder];
    [self postGraphObjectToFacebook];
}

- (IBAction)authorizeButtonCLick:(id)sender
{
    
    [self requestReadPermission];
}



-(void)postGraphObjectToFacebook
{
     [self requestPublishPermission];
    //isPublishedOnce=NO;
    //[self requestReadPermission];
    
//    if (FBSession.activeSession.isOpen)
//    {
//        [self requestPublishPermission];
//    }
//    else
//    {
//        [self requestReadPermission];
//    }
    
}



#pragma mark -
#pragma mark Facebook Methods
-(void)requestReadPermission
{
    NSArray *permissions = [[NSArray alloc] initWithObjects:@"email", nil];
    
    [FBSession openActiveSessionWithReadPermissions:permissions
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                      // NSLog(@"76543 ");
                                      if (error) {
                                          // NSLog(@"error::: %@",[error description]);
                                      }
                                      else
                                      {
                                          //NSLog(@"Read permission granted::: ");
                                          //read permission granted Request Publish Permission.
                                          //if (!isPublishedOnce)
                                          //{
                                              //NSLog(@"Read permission granted:::Request for Publish ");
                                              
                                              // [self requestPublishPermission];
                                              //[self performSelector:@selector(requestPublishPermission) withObject:nil afterDelay:3.0];
                                         // }
                                          
                                      }
                                  }];
    
    
    [permissions release];
}

-(void)requestPublishPermission
{
    //[FBSession openActiveSessionWithAllowLoginUI:NO];
	if (FBSession.activeSession.isOpen)
    {
        isPublishedOnce=YES;
        NSArray *permissions = [NSArray arrayWithObjects:@"publish_actions", nil];
        
        [[FBSession activeSession] reauthorizeWithPublishPermissions:permissions
                                                     defaultAudience:FBSessionDefaultAudienceFriends
                                                   completionHandler:^(FBSession *session, NSError *error) {
                                                       if(!error)
                                                       {
                                                           [self postStatus];
                                                           
                                                           //NSLog(@"successfully got publish permissions ");
                                                       }
                                                       else
                                                       {
                                                        
                                                           // NSLog(@"failed to get publish permissions");
                                                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                                                                               message:NSLocalizedString(@"failedPublishPermissions",@"")
                                                                                                              delegate:nil
                                                                                                     cancelButtonTitle:NSLocalizedString(@"OK",@"")
                                                                                                     otherButtonTitles:nil];
                                                           [alertView show];
                                                           [alertView release];
                                                       }
                                                   }];
    }
    else
    {
        // NSLog(@"session not oppenned");
        // [FBSession openActiveSessionWithAllowLoginUI:NO];
        //[self requestReadPermission];
    }
}

-(void)postStatus
{
    
    [FBRequestConnection startForPostStatusUpdate:statusTextField.text completionHandler:^(FBRequestConnection *connection, id result, NSError *error)
     {
         [self showAlert:NSLocalizedString(@"post Succesful",@"") result:result error:error];
     }];
}


-(void)showAlert:(NSString *)message result:(id)result error:(NSError *)error
{
    NSString *alertMsg;
    NSString *alertTitle;
    if (error)
    {
        alertMsg = error.localizedDescription;
        alertTitle = NSLocalizedString(@"Error",@"");
    }
    else
    {
        alertMsg = message;
        alertTitle = NSLocalizedString(@"Success",@"");
    }
	
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                                                        message:alertMsg
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"OK",@"")
                                              otherButtonTitles:nil];
    [alertView show];
	[alertView release];
}
@end
