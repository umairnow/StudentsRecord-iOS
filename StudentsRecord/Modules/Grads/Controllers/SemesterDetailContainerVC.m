//
//  SemesterDetailContainerVC.m
//  StudentsRecord
//
//  Created by Umair Aamir on 26/05/2015.
//  Copyright (c) 2015 ExcelTech Limited. All rights reserved.
//

#import "SemesterDetailContainerVC.h"
#import "SemesterListVC.h"
#import "SemesterBarVC.h"

@interface SemesterDetailContainerVC ()

@property (strong, nonatomic) NSString *currentSegueIdentifier;
@property (strong, nonatomic) SemesterListVC *semesterListVC;
@property (strong, nonatomic) SemesterBarVC *semesterBarVC;
@property (assign, nonatomic) BOOL transitionInProgress;


@end

@implementation SemesterDetailContainerVC

@synthesize semesterBarVC = _semesterBarVC, semesterListVC = _semesterListVC;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.transitionInProgress = NO;
    self.currentSegueIdentifier = SEGUE_SEGMENT_LIST;
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}

- (void)dealloc
{
    self.currentSegueIdentifier = nil;
    self.semesterListVC = nil;
    self.semesterBarVC = nil;
}

#pragma mark - Getters/Setters

- (void)setSemesterListVC:(SemesterListVC *)semesterListVC
{
    _semesterListVC = semesterListVC;
    _semesterListVC.currentStudent = self.currentStudent;
}

- (void)setSemesterBarVC:(SemesterBarVC *)semesterBarVC
{
    _semesterBarVC = semesterBarVC;
    _semesterBarVC.currentStudent = self.currentStudent;
}

- (SemesterListVC *)semesterListVC
{
    _semesterListVC.currentStudent = self.currentStudent;
    return _semesterListVC;
}

- (SemesterBarVC *)semesterBarVC
{
    _semesterBarVC.currentStudent = self.currentStudent;
    return _semesterBarVC;
}

#pragma mark - Segue Handlers

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // Instead of creating new VCs on each seque we want to hang on to existing
    // instances if we have it. Remove the second condition of the following
    // two if statements to get new VC instances instead.
    if ([segue.identifier isEqualToString:SEGUE_SEGMENT_LIST]) {
        self.semesterListVC = segue.destinationViewController;
    }
    
    if ([segue.identifier isEqualToString:SEGUE_SEGMENT_BAR]) {
        self.semesterBarVC = segue.destinationViewController;
    }
    
    // If we're going to the first view controller.
    if ([segue.identifier isEqualToString:SEGUE_SEGMENT_LIST]) {
        // If this is not the first time we're loading this.
        if (self.childViewControllers.count > 0) {
            [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.semesterListVC];
        }
        else {
            // If this is the very first time we're loading this we need to do
            // an initial load and not a swap.
            [self addChildViewController:segue.destinationViewController];
            UIView* destView = ((UIViewController *)segue.destinationViewController).view;
            destView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            destView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            [self.view addSubview:destView];
            [segue.destinationViewController didMoveToParentViewController:self];
        }
    }
    // By definition the second view controller will always be swapped with the
    // first one.
    else if ([segue.identifier isEqualToString:SEGUE_SEGMENT_BAR]) {
        [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.semesterBarVC];
    }
}

#pragma mark - Helping Methods

- (void)swapFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    toViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    
    [self transitionFromViewController:fromViewController toViewController:toViewController duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        [fromViewController removeFromParentViewController];
        [toViewController didMoveToParentViewController:self];
        self.transitionInProgress = NO;
    }];
}

- (void)swapViewControllers
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    if (self.transitionInProgress) {
        return;
    }
    
    self.transitionInProgress = YES;
    self.currentSegueIdentifier = ([self.currentSegueIdentifier isEqualToString:SEGUE_SEGMENT_LIST]) ? SEGUE_SEGMENT_BAR : SEGUE_SEGMENT_LIST;
    
    if (([self.currentSegueIdentifier isEqualToString:SEGUE_SEGMENT_LIST]) && self.semesterListVC) {
        [self swapFromViewController:self.semesterBarVC toViewController:self.semesterListVC];
        return;
    }
    
    if (([self.currentSegueIdentifier isEqualToString:SEGUE_SEGMENT_BAR]) && self.semesterBarVC) {
        [self swapFromViewController:self.semesterListVC toViewController:self.semesterBarVC];
        return;
    }
    
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}

@end
