//
//  AppRootVC.m
//  StudentsRecord
//
//  Created by Umair Aamir on 25/05/2015.
//  Copyright (c) 2015 ExcelTech Limited. All rights reserved.
//

#import "AppRootVC.h"
#import "MenuVC.h"

@interface AppRootVC ()

@end

@implementation AppRootVC

#pragma mark - Life Cycle

- (void)awakeFromNib
{
    [self loadDefaultControllers];
    [self performSelector:@selector(configureView) withObject:nil afterDelay:1.0];
}

#pragma mark - Load Child View Controllers

- (void)loadDefaultControllers
{
    self.leftMenuViewController = [MenuVC loadMenuVC];
    self.contentViewController  = [AlbumVC loadAlbumVC];
}

#pragma mark - View Configurations

- (void)configureView
{
    self.delegate = self;
    [self presentLeftMenuViewController];  
}

#pragma mark - Action Handlers

- (IBAction)unwindToAppRootVC:(UIStoryboardSegue *)segue
{
    
}

#pragma mark -
#pragma mark RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
    
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    
}


@end
