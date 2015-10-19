//
//  LocationMapVC.m
//  StudentsRecord
//
//  Created by Umair Aamir on 26/05/2015.
//  Copyright (c) 2015 ExcelTech Limited. All rights reserved.
//

#import "LocationMapVC.h"
#import "MapAnnotation.h"
#import "MapAnnotationView.h"

@interface LocationMapVC ()

@property (assign, nonatomic) BOOL zoomed;
@property (strong, nonatomic) NSArray *coordinates;
@property (strong, nonatomic) NSMutableArray *locations;
@end

@implementation LocationMapVC

static NSString * const AnnotIdentifier     = @"LocAnnotation";

#pragma mark - Life Cycle

+ (UINavigationController *)loadLocationMapVC
{
    static UINavigationController *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[UIStoryboard storyboardLocation] instantiateInitialViewController];
    });
    return _sharedInstance;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeVariables];
    [self setupAppearance];
    [self loadData];
}

- (void)setupAppearance
{
    [self addMenuButton];
}


- (void)initializeVariables
{
    [self removeAllAnnotations];
    self.coordinates = @[@{@"lat": @(31.498360), @"long": @(74.396677)}, @{@"lat": @(30.822064), @"long": @(32.151491)}, @{@"lat": @(30.822064), @"long": @(32.151491)}, @{@"lat": @(2.108899), @"long": @(25.312500)}];
}

- (void)loadData
{
    self.locations = [NSMutableArray new];
    [self.coordinates enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        Location *loc = [Location new];
        loc.latitude = obj[@"lat"];
        loc.longitude = obj[@"long"];
        [self.locations addObject:loc];
    }];
    [self addLocationAnnotations];
}

#pragma mark - Helping Methods

- (void)addLocationAnnotations
{
    [self.locations enumerateObjectsUsingBlock:^(Location *loc, NSUInteger idx, BOOL *stop) {
        MapAnnotation *annotation = [MapAnnotation annotationWithCoordinate:CLLocationCoordinate2DMake(loc.latitude.doubleValue, loc.longitude.doubleValue) title:@"Ben" subtitle:@"At School"];
        [locationMap addAnnotation:annotation];
    }];
}

- (void)removeAllAnnotations
{
    NSMutableArray *mapAnnotations = locationMap.annotations.mutableCopy;
    [mapAnnotations removeObject:locationMap.userLocation];
    [locationMap removeAnnotations:mapAnnotations];
}

- (void)setMapRegionWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    MKCoordinateRegion region   = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(.1, .1));
    MKCoordinateRegion adjustedRegion = [locationMap regionThatFits:region];
    [locationMap setRegion:adjustedRegion animated:YES];
}

#pragma mark - MKMapViewDelegate Methods

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (!self.zoomed) {
        self.zoomed = YES;
        return;
    }
    [self setMapRegionWithCoordinate:userLocation.coordinate];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MapAnnotation class]]) {
        MapAnnotationView *annotationView = [[MapAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotIdentifier];
        annotationView.canShowCallout = YES;
        return annotationView;
    } else {
        return [locationMap viewForAnnotation:locationMap.userLocation];
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [mapView deselectAnnotation:view.annotation animated:YES];
}

@end
