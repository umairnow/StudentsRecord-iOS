//
//  UIStoryboard+AppStoryboard.m
//  StudentsRecord
//
//  Created by Umair Aamir on 31/03/2015.
//  Copyright (c) 2015 ExcelTech Limited. All rights reserved.
//

#import "UIStoryboard+AppStoryboard.h"

@implementation UIStoryboard (AppStoryboard)

#pragma mark - Storyboards

+ (UIStoryboard *)storyboardMenu
{
    return [UIStoryboard storyboardWithName:@"MenuSB" bundle:[NSBundle mainBundle]];
}

+ (UIStoryboard *)storyboardAlbum
{
    return [UIStoryboard storyboardWithName:@"AlbumSB" bundle:[NSBundle mainBundle]];
}

+ (UIStoryboard *)storyboardGrades
{
    return [UIStoryboard storyboardWithName:@"GradesSB" bundle:[NSBundle mainBundle]];
}

+ (UIStoryboard *)storyboardLocation
{
    return [UIStoryboard storyboardWithName:@"LocationSB" bundle:[NSBundle mainBundle]];
}

@end
