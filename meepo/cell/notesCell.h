//
//  notesCell.h
//  meepo
//
//  Created by Mikael Melander on 2018-02-02.
//  Copyright © 2018 Mikael Melander. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fonts.h"
#import "Colors.h"

static NSString *kCellIdentifier = @"notesCell";

@interface notesCell : UITableViewCell

+ (void)setTableViewWidth:(CGFloat)tableWidth;
+ (id)cellForTableWidth:(CGFloat)width;
+ (CGFloat)cellHeightForText;
- (void)configureCellForText:(NSDictionary *)Text;

@property (nonatomic, strong) NSDictionary *Object;

@end

