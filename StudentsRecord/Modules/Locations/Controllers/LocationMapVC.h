//
//  LocationMapVC.h
//  StudentsRecord
//
//  Created by Umair Aamir on 14/04/2015.
//  Copyright (c) 2015 ExcelTech Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface LocationMapVC : UIViewController <MKMapViewDelegate> {
    
    __weak IBOutlet MKMapView *locationMap;
}
/**
 * Load Event Map
 **/
+ (UINavigationController *)loadLocationMapVC;

@end
