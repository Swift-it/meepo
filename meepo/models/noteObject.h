//
//  noteModel.h
//  meepo
//
//  Created by Mikael Melander on 2018-02-17.
//  Copyright © 2018 Mikael Melander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface noteObject : NSObject

@property (strong, readwrite) NSString *title;
@property (strong, readwrite) NSString *description;
@property (assign) int _id;


-(id) initWithDic:(NSDictionary *)dictionary;
-(id) initForSave:(int)_id;
-(id) initForSave:(NSString *)title andDesc:(NSString *)description andId:(int)_id;
-(id) initForSave:(NSString *)title andDesc:(NSString *)description;

-(int)getId;
-(NSString *)getTitle;
-(NSString *)getDescription;
-(NSDictionary *)getJson;

@end
