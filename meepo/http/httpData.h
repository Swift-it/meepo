//
//  httpData.h
//  meepo
//
//  Created by Mikael Melander on 2018-02-02.
//  Copyright © 2018 Mikael Melander. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol httpDataDelegate <NSObject>
@required
-(void)didFininshRequestWithJson:(NSArray *)responseJson;
-(void)didFailWithRequest:(NSString *)err;

@end

@interface httpData : NSObject


-(void)getData;
-(void)postData:(NSDictionary *)note :(NSString *)type;

@property (nonatomic,strong) NSObject <httpDataDelegate> *delegate;



@end
