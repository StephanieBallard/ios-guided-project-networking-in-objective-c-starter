//
//  ViewController.m
//  Quakes-Objc
//
//  Created by Paul Solt on 2/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"
#import "LSILog.h"
#import "LSIFirstResponder.h"
#import "SABQuakeFetcher.h"

@interface ViewController ()

// let quakeFetcher: SABQuakeFetcher? = nil
@property (nonatomic) SABQuakeFetcher *quakeFetcher;

@end

@implementation ViewController

// The getter of quakefetcher variable
// This is how you make a lazy variable in obj -c
-(SABQuakeFetcher *)quakeFetcher {
    if (_quakeFetcher == nil) {
        _quakeFetcher = [[SABQuakeFetcher alloc] init];
    }
    return _quakeFetcher;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSLog(@"Hey Quakes!");
    
    // How do I create a first responder object?
    LSIFirstResponder *responder = [[LSIFirstResponder alloc] init];

//    NSLog(@"responder: %@", responder);
//    NSLog(@"name: %@", responder.name);
    
    // Objects will be nil / null
    // int / float / double / bool will be 0 (NO)
    
//    responder.name = @"John";
//    NSLog(@"name: %@", responder.name);
    
    
}




@end
