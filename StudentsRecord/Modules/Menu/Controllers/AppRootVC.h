//
//  AppRootVC.h
//  StudentsRecord
//
//  Created by Umair Aamir on 25/05/2015.
//  Copyright (c) 2015 ExcelTech Limited. All rights reserved.
//

#import "RESideMenu.h"

@interface AppRootVC : RESideMenu <RESideMenuDelegate>

- (IBAction)unwindToAppRootVC:(UIStoryboardSegue *)segue;

@end
