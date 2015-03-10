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
#import <ParseUI/ParseUI.h>

static NSString * const entryNameKey = @"name";

@interface PDViewController ()

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

}

- (IBAction)retrieveObject:(id)sender {

}

- (IBAction)signIn:(id)sender {

}

- (IBAction)signUp:(id)sender {

}

- (void)addUserData {

}

@end
