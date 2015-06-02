//
//  SemesterBarVC.h
//  StudentsRecord
//
//  Created by Umair Aamir on 26/05/2015.
//  Copyright (c) 2015 ExcelTech Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBBarChartView.h"

@interface SemesterBarVC : UIViewController <JBBarChartViewDataSource, JBBarChartViewDelegate> {
    
    __weak IBOutlet JBBarChartView *barChartView;
}

@property (weak, nonatomic) Student *currentStudent;

@end
