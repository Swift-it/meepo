//
//  httpData.m
//  meepo
//
//  Created by Mikael Melander on 2018-02-02.
//  Copyright © 2018 Mikael Melander. All rights reserved.
//

#import "httpData.h"

@implementation httpData

-(void)getData:(NSString *)requestString {
    
    NSURL *url = [[NSURL alloc]initWithString:requestString];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *err) {
                
                NSError *error = nil;
                
                // request error
                if (error) {
                    [self.delegate didFailWithRequest:[NSString stringWithFormat:@"error: %@", error]];
                }
                // response error
                if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                    NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
                    if (statusCode != 200) {
                        [self.delegate didFailWithRequest:[NSString stringWithFormat:@"request failed with status code: %ld", (long)statusCode]];
                    }
                }
                
               if (!error) {
                   NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                   NSLog(@"%@", jsonArray);
                    [self.delegate didFininshRequestWithJson:jsonArray];
                }
                else
                    return;
    }] resume];
}

@end
