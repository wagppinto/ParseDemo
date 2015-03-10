//
//  PDViewController.m
//  ParseDemo
//
//  Created by Joshua Howland on 6/25/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "PDViewController.h"
#import "Entry.h"
#import <Parse/Parse.h>

static NSString * const entryNameKey = @"name";

@interface PDViewController () // <PFSignUpViewControllerDelegate, PFLogInViewControllerDelegate>

@property (nonatomic, strong) PFUser *currentUser;

@property (nonatomic, strong) IBOutlet UITextField *objectNameField;
@property (nonatomic, strong) IBOutlet UILabel *objectNameLabel;

@end

@implementation PDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)storeObject:(id)sender {

//    Using generic type
//    PFObject *entry = [PFObject objectWithClassName:[Entry parseClassName]];
//    [entry setObject:self.objectNameField.text forKey:entryNameKey];

//    Using Subclassed object
    Entry *entry = [Entry object];
    entry.name = self.objectNameField.text;
    
    // This could be done in the background, but I want to update the UI immediately
    NSError *error = nil;
    
    [entry pin];
    [entry save:&error];

    if (error) {
        NSLog(@"%@", error.localizedDescription);
    }

}

- (IBAction)retrieveObject:(id)sender {

//    Using generic type
//    PFQuery *query = [PFQuery queryWithClassName:[Entry parseClassName]];

//    Using subclass class method
    PFQuery *query = [Entry query];

    // This could be done in the background, but I want to update the UI immediately
    NSArray *objects = [query findObjects];
    
    if (objects.count > 0) {
        PFObject *object = objects.lastObject;
        self.objectNameLabel.text = [object objectForKey:entryNameKey];
    }

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


// Delegate methods for authentication view controllers

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
