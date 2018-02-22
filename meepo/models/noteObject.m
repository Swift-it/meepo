//
//  noteModel.m
//  meepo
//
//  Created by Mikael Melander on 2018-02-17.
//  Copyright © 2018 Mikael Melander. All rights reserved.
//

#import "noteObject.h"

@implementation noteObject
@synthesize title, description;

-(id) initWithDic:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self)
    {
        self._id = [[dictionary objectForKey:@"id"] intValue];
        self.title = [dictionary objectForKey:@"title"];
        self.description = [dictionary objectForKey:@"description"];
    }
    return self;
}

-(id) initForSave:(int)_id {
    self = [super init];
    if (self)
    {
        self._id = _id;
    }
    return self;
}

-(id) initForSave:(NSString *)title andDesc:(NSString *)description {
    self = [super init];
    if (self)
    {
        self.title = title;
        self.description = description;
    }
    return self;
}

-(id) initForSave:(NSString *)title andDesc:(NSString *)description andId:(int)_id {
    self = [super init];
    if (self)
    {
        self.title = title;
        self.description = description;
        if (_id)
            self._id = _id;
    }
    return self;
}

-(int)getId {
    return self._id;
}

-(NSString *)getTitle {
    
    if (self.title.length > 0) {
        NSString *title = [NSString stringWithFormat:@"%@%@", [[self.title substringToIndex:1] uppercaseString], [self.title substringFromIndex:1]];
        return title;
    }
    else
        return nil;
}
-(NSString *)getDescription {
     if (self.title.length > 0)
         return self.description;
     else
         return nil;
}

-(NSDictionary *)getJson {
   
    NSDictionary *dic;
    
    if (self._id)
      dic = [[NSDictionary alloc] initWithObjectsAndKeys:self.title ,@"title", self.description ,@"description",[NSNumber numberWithInt:self._id],@"id", nil];
    else
        dic = [[NSDictionary alloc] initWithObjectsAndKeys:self.title ,@"title", self.description ,@"description", nil];

    
    return dic;
    
}


@end
