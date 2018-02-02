//
//  Colors.m
//  Meepo
//
//  Created by Mikael Melander on 2018-02-01.
//  Copyright © 2018 Mikael Melander. All rights reserved.
//

#import "Colors.h"

@implementation Colors


+ (UIColor*) mainColor
{
    return [UIColor colorWithRed:37/255.0 green:139/255.0 blue:137/255.0 alpha:1];
}

+ (UIColor*) veryLightGray
{
    return [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
}

+ (UIColor*) lightGray
{
    return [UIColor colorWithRed:236/255.0 green:240/255.0 blue:241/255.0 alpha:1];
}

+ (UIColor*) placeholderColor
{
    return [UIColor colorWithRed:149/255.0 green:165/255.0 blue:166/255.0 alpha:1];
}

// From Facebook :)
+ (UIColor*) meepoColor
{
    return [UIColor colorWithRed:241/255.0 green:112/255.0 blue:48/255.0 alpha:1];
}

@end