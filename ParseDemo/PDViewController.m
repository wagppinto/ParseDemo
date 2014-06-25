//
//  PDViewController.m
//  ParseDemo
//
//  Created by Joshua Howland on 6/25/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "PDViewController.h"
#import <Parse/Parse.h>

@interface PDViewController () <PFSignUpViewControllerDelegate, PFLogInViewControllerDelegate>

@property (nonatomic, strong) PFUser *currentUser;

@end

@implementation PDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)signIn:(id)sender {

    PFLogInViewController *logIn = [PFLogInViewController new];
    logIn.delegate = self;
    [self presentViewController:logIn animated:YES completion:nil];
    
}

- (IBAction)signUp:(id)sender {

    PFSignUpViewController *signUp = [PFSignUpViewController new];
    signUp.delegate = self;
    [self presentViewController:signUp animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    self.currentUser = user;
    
    [self addUserData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    self.currentUser = user;
    
    [self addUserData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)addUserData {

    PFQuery *query = [PFQuery queryWithClassName:@"yourData"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if ([objects count] == 0) {
            
            PFObject *yourData = [PFObject objectWithClassName:@"yourData"];
            yourData[@"dictionaryKey"] = @"dictionaryValue";
            
            // If there is a current user you can set that user as the only user that can access this object:
            if (self.currentUser) {
                yourData.ACL = [PFACL ACLWithUser:self.currentUser];
            }
            
            [yourData saveInBackground];
            
        } else {
            
            NSLog(@"You already stored your data");
        }
    
    }];
    
}


@end
