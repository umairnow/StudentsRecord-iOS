//
//  SemesterDetailContainerVC.h
//  StudentsRecord
//
//  Created by Umair Aamir on 26/05/2015.
//  Copyright (c) 2015 ExcelTech Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SemesterDetailContainerVC : UIViewController

@property (weak, nonatomic) Student *currentStudent;

- (void)swapViewControllers;
@end

