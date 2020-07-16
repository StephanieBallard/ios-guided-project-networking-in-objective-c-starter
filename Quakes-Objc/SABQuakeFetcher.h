//
//  SABQuakeFetcher.h
//  Quakes-Objc
//
//  Created by Stephanie Ballard on 7/16/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSIQuake;

NS_ASSUME_NONNULL_BEGIN

// typealias SABQuakeFetcherCompletion = (quakes: [LSIQuake], error: Error?) -> Void)

typedef void (^SABQuakeFetcherCompletion)(NSArray <LSIQuake *> *quakes, NSError *error);

@interface SABQuakeFetcher : NSObject

-(void)fetchQuakesInDateInterval:(NSDateInterval *)interval
                     completions:(SABQuakeFetcherCompletion)completion;

@end

NS_ASSUME_NONNULL_END
