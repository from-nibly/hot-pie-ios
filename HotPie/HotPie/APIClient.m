//
//  APIClient.m
//  HotPie
//
//  Created by Michael Daniels on 1/16/15.
//  Copyright (c) 2015 Michael Daniels. All rights reserved.
//

#import "APIClient.h"

@implementation APIClient

+ (APIClient *)sharedClient
{
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://137.190.207.214:3000"]];
        [_sharedClient setRequestSerializer:[AFJSONRequestSerializer serializer]];
    });
    return _sharedClient;
}

@end
