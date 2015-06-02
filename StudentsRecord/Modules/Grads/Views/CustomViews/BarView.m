//
//  BarView.m
//  StudentsRecord
//
//  Created by Umair Aamir on 26/05/2015.
//  Copyright (c) 2015 ExcelTech Limited. All rights reserved.
//

#import "BarView.h"
#import "UIView+NibLoading.h"

@implementation BarView

- (instancetype)init
{
    self = [super init];
    if (self) {
        return [self loadFromNib:self];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    self = [super awakeAfterUsingCoder:aDecoder];
    if (self) {
        return [self loadFromNib:self];
    }
    return self;
}

- (instancetype)loadFromNib:(BarView *)barView
{
    if ([[barView subviews] count] == 0) {
        BarView* loadedView = [[self class] loadFromNib];
        loadedView.frame = self.frame;
        
        loadedView.autoresizingMask = self.autoresizingMask;
        loadedView.translatesAutoresizingMaskIntoConstraints = self.translatesAutoresizingMaskIntoConstraints;
        
        for (NSLayoutConstraint *constraint in self.constraints)
        {
            id firstItem = constraint.firstItem;
            if (firstItem == self)
            {
                firstItem = loadedView;
            }
            id secondItem = constraint.secondItem;
            if (secondItem == self)
            {
                secondItem = loadedView;
            }
            [loadedView addConstraint:
             [NSLayoutConstraint constraintWithItem:firstItem
                                          attribute:constraint.firstAttribute
                                          relatedBy:constraint.relation
                                             toItem:secondItem
                                          attribute:constraint.secondAttribute
                                         multiplier:constraint.multiplier
                                           constant:constraint.constant]];
        }
        return loadedView;
    }
    return barView;
}

@end
