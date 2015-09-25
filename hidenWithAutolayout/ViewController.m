//
//  ViewController.m
//  hidenWithAutolayout
//
//  Created by Tony on 15/8/20.
//  Copyright (c) 2015年 Tony. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *redview;
@property (strong, nonatomic) IBOutlet UIView *pinkView;

@end

@implementation ViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)ClickAtion:(id)sender
{
//    self.redview.hidden=!self.redview.hidden;

	[self.redview hideWithAutoLayoutAttributes:NSLayoutAttributeTop, NSLayoutAttributeHeight, nil];

	[self.pinkView hideWithAutoLayoutAttributes:NSLayoutAttributeLeft, NSLayoutAttributeWidth, nil];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
