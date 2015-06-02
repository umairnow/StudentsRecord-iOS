//
//  SRUtility.h
//  StudentsRecord
//
//  Created by Umair Aamir on 25/05/2015.
//  Copyright (c) 2015 ExcelTech Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StudentsHolder.h"

#define utility [SRUtility sharedInstance]

@interface SRUtility : NSObject

/**
 * singleton method
 **/
+ (instancetype)sharedInstance;

/**
 * loads images from app bundle and save to temp directory
 **/
- (void)saveImagesToAppData;

/**
 * loads all saved files from temporary directory
 **/
-(NSMutableArray *)loadSavedFiles;

/**
 * save image to directory
 **/
- (void)saveImage:(UIImage *)image withName:(NSString *)imageName;

/**
 * show error message
 **/
- (void)showErrorMessageBarWithTitle:(NSString *)title andMessage:(NSString *)message;

@property (readonly, nonatomic) StudentsHolder *studentHolder;

@end
