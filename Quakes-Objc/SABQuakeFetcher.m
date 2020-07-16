//
//  SABQuakeFetcher.m
//  Quakes-Objc
//
//  Created by Stephanie Ballard on 7/16/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "SABQuakeFetcher.h"
#import "LSIErrors.h"
#import "LSIQuakeResults.h"

// static variables means it is going to be limited to the only this code file (as opposed to it being available globally like in swift)
static NSString *baseURLString = @"https://earthquake.usgs.gov/fdsnws/event/1/query";

@implementation SABQuakeFetcher

// Sample query: https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=2014-01-01&endtime=2014-01-02

- (void)fetchQuakesInDateInterval:(NSDateInterval *)interval completions:(SABQuakeFetcherCompletion)completion {
    // set up URL (add query parameters)
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:baseURLString];
//    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:baseURLString];
    
    NSISO8601DateFormatter *formatter = [[NSISO8601DateFormatter alloc] init];
    NSString *startTimeString = [formatter stringFromDate:interval.startDate];
    NSString *endTimeString = [formatter stringFromDate:interval.endDate];
    
    NSURLQueryItem *formatItem = [NSURLQueryItem queryItemWithName:@"format" value:@"geojson"];
    NSURLQueryItem *startItem = [NSURLQueryItem queryItemWithName:@"starttime" value:startTimeString];
    NSURLQueryItem *endItem = [NSURLQueryItem queryItemWithName:@"endtime" value:endTimeString];
    
    urlComponents.queryItems = @[formatItem, startItem, endItem];
    
    NSURL *requestURL = urlComponents.URL;
    
    if (requestURL == nil) {
        // Dont keep this in production code, create a custom error.
        completion(@[], [[NSError alloc] init]);
    }
    
    // set up URLRequest
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestURL];
    request.HTTPMethod = @"GET";
    
    // Perform Data task
    NSURLSessionDataTask *dataTask = [NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // Handle errors, check for data
        if (error) {
            completion(@[], error);
            return;
        }
        if (data == nil) {
            NSError *dataError = errorWithMessage(@"Data is nil and we dont expect that", LSIDataNilError);
            completion(@[], dataError);
            return;
        }
        // Decode the data using NSJSONSerialization
        NSError *jsonError = nil;
        
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData: data options:0 error:&error];
        
        if (jsonError) {
            completion(@[], jsonError);
            return;
        }
        
        LSIQuakeResults *results = [[LSIQuakeResults alloc] initWithDictionary:jsonDictionary];
        completion(results.quakes, nil);
    }];
    
    [dataTask resume];
                                      
}
                                      
                                      
@end
