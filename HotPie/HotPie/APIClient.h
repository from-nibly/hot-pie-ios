//
//  APIClient.h
//  HotPie
//
//  Created by Michael Daniels on 1/16/15.
//  Copyright (c) 2015 Michael Daniels. All rights reserved.
//

#import <AFNetworking.h>

@interface APIClient : AFHTTPRequestOperationManager

+ (APIClient *)sharedClient;

@end
