//
//  notesCell.m
//  meepo
//
//  Created by Mikael Melander on 2018-02-02.
//  Copyright © 2018 Mikael Melander. All rights reserved.
//

#import "notesCell.h"

@interface notesCell ()

@property (weak, nonatomic)  UIImageView *bk;
@property (weak, nonatomic)  UIImageView *sideImg;
@property (weak, nonatomic)  UILabel *mainText;
@property (weak, nonatomic)  UILabel *descriptionText;

@end

#define k_placeholderText @"Title"


static CGFloat kPadding = 8.0f;
static CGFloat kTableViewWidth = -1;
static CGFloat kBigPadding = 35.0f;

@implementation notesCell


- (void)awakeFromNib {
    [super awakeFromNib];
}


-(void)layoutSubviews {
    
    
    [super layoutSubviews];
    self.bk.frame = CGRectMake(kPadding, 0, kTableViewWidth-(kPadding*2), [notesCell cellHeightForText]);
}

+ (void)setTableViewWidth:(CGFloat)tableWidth
{
    kTableViewWidth = tableWidth;
}

+ (id)cellForTableWidth:(CGFloat)width
{
    
    UIFont *mainFont = [Fonts mainFont];
    UIFont *placeholderFont = [Fonts placeholderFont];
    UIColor *placeholderColor = [Colors placeholderColor];
    UIColor *mainColor = [Colors mainColor];
    
    notesCell *cell = [[notesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    
    CGRect cellFrame = cell.frame;
    cellFrame.size.width = width;
    cell.frame = cellFrame;
    cell.backgroundColor = [UIColor clearColor];
    
    
    UIImageView *bktemp = [[UIImageView alloc] init];
    bktemp.backgroundColor = [Colors whiteColor];
    bktemp.layer.cornerRadius = 3;
    bktemp.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    bktemp.layer.shadowOffset = CGSizeMake(0, 1);
    bktemp.layer.shadowOpacity = 0.4;
    bktemp.layer.shadowRadius = 2.0;
    bktemp.clipsToBounds = NO;
    cell.bk = bktemp;
    [cell addSubview:cell.bk];
    
    
    UILabel *title = [[UILabel alloc] init];
    title.font = mainFont;
    title.textColor = mainColor;
    title.textAlignment = NSTextAlignmentLeft;
    title.lineBreakMode = NSLineBreakByWordWrapping;
    title.numberOfLines = 0;
    cell.mainText = title;
    [cell addSubview:cell.mainText];
    
    
    UILabel *description = [[UILabel alloc] init];
    description.font = placeholderFont;
    description.textColor = placeholderColor;
    description.textAlignment = NSTextAlignmentLeft;
    description.lineBreakMode = NSLineBreakByWordWrapping;
    description.numberOfLines = 2;
    description.lineBreakMode = NSLineBreakByTruncatingTail;
    cell.descriptionText = description;
    [cell addSubview:cell.descriptionText];
    
    UIImageView *sideimg = [[UIImageView alloc] init];
    sideimg.backgroundColor = [Colors mainColor];
    sideimg.alpha = 0.5;
    cell.sideImg = sideimg;
    [cell addSubview:cell.sideImg];;
    
    return cell;
}


+ (CGFloat)cellHeightForText
{
    CGFloat height = 100;
    return height;
}

+(CGSize)calculateLabelSize:(UILabel *)label {
  
    CGSize tempSize = CGSizeMake(kTableViewWidth-kPadding-kBigPadding, 999);
    
    CGRect textRect = [label.text boundingRectWithSize:tempSize
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:label.font}
                                         context:nil];
    
    CGSize size = textRect.size;
    
    return size;
}

- (void)configureCellForText:(NSDictionary *)text
{
     [self setNeedsLayout];
    self.mainText.text = [text objectForKey:@"title"];
    self.mainText.frame = CGRectMake(kPadding*2, kPadding, [notesCell calculateLabelSize:self.mainText].width, [notesCell calculateLabelSize:self.mainText].height);
    [self.mainText sizeToFit];
    
    self.descriptionText.text = [text objectForKey:@"description"];
      self.descriptionText.frame = CGRectMake(kPadding*2, kPadding*2+[notesCell calculateLabelSize:self.mainText].height, kTableViewWidth-kPadding-kBigPadding, [notesCell calculateLabelSize:self.descriptionText].height);
    [self.descriptionText sizeToFit];
    
    self.sideImg.frame = CGRectMake(self.mainText.frame.origin.x, self.mainText.frame.size.height+self.mainText.frame.origin.y + 4, self.mainText.frame.size.width, 1.5);
    
  
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (highlighted) {
        _bk.backgroundColor = [Colors lightGray];
    } else {
        _bk.backgroundColor = [Colors whiteColor];
    }
}


@end
