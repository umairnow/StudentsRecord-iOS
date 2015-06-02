//
//  UIViewController+NavigationButtons.m
//  StudentsRecord
//
//  Created by Umair Aamir on 09/04/2015.
//  Copyright (c) 2015 ExcelTech Limited. All rights reserved.
//

#import "UIViewController+NavigationButtons.h"

@implementation UIViewController (NavigationButtons)

#pragma mark - Left Menu Buttons

- (void)addMenuButton
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleDone target:self action:@selector(menuButtonTouchUpInside:)];
}


#pragma mark - Action Handlers

- (void)menuButtonTouchUpInside:(UIButton *)sender
{
    [self.sideMenuViewController presentLeftMenuViewController];
}

@end
