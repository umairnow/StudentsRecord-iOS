//
//  AdvertiserAnnotationView.m
//  StudentsRecord
//
//  Created by Umair Aamir on 23/05/2015.
//  Copyright (c) 2015 Umair Aamir. All rights reserved.
//

#import "MapAnnotationView.h"

@implementation MapAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.image = [UIImage imageNamed:@"map_annotation"];
    }
    return self;
}

@end
