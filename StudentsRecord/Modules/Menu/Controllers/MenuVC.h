//
//  MenuVC.h
//  StudentsRecord
//
//  Created by Umair Aamir on 25/05/2015.
//  Copyright (c) 2015 ExcelTech Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "LocationMapVC.h"
#import "GradesVC.h"
#import "AlbumVC.h"

@interface MenuVC : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    __weak IBOutlet UITableView *tvMenu;
}

/**
 * singleton menu controllers
 **/
+ (MenuVC *)loadMenuVC;

@end
