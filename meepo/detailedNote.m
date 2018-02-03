//
//  detailedNote.m
//  meepo
//
//  Created by Mikael Melander on 2018-02-02.
//  Copyright © 2018 Mikael Melander. All rights reserved.
//

#import "detailedNote.h"

@interface detailedNote ()

@end

static CGFloat kPadding = 16.0f;
static CGFloat kBigPadding = 40.0f;
static CGFloat kStandardHeaderLabelHeight = 50.0f;


@implementation detailedNote

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [Colors whiteColor];

 
    // Setting up Navbar
    [self setTitle:@"Details"];
    [[UIView appearance] setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *newback = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:newback];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[Colors mainColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
  
    
    title = [[UILabel alloc] initWithFrame:CGRectMake(kPadding, kPadding, self.view.bounds.size.width-(kPadding*2), kStandardHeaderLabelHeight)];
    title.font = [Fonts mainFont];
    title.textColor =  [Colors mainColor];
    title.textAlignment = NSTextAlignmentLeft;
    title.lineBreakMode = NSLineBreakByWordWrapping;
    title.lineBreakMode = NSLineBreakByTruncatingTail;
    title.numberOfLines = 0;
    title.text = [_note objectForKey:@"title"];
    title.frame = CGRectMake(kPadding, kPadding, [self calculateLabelSize:title].width, [self calculateLabelSize:title].height);
    [title sizeToFit];
    
    [self.view addSubview:title];
    
    
    description = [[UILabel alloc] init];
    description.font = [Fonts placeholderFont];
    description.textColor = [Colors placeholderColor];
    description.textAlignment = NSTextAlignmentLeft;
    description.lineBreakMode = NSLineBreakByWordWrapping;
    description.numberOfLines = 0;
    description.lineBreakMode = NSLineBreakByTruncatingTail;
    description.text = [_note objectForKey:@"description"];
    description.frame = CGRectMake(kPadding, title.frame.size.height + title.frame.origin.y + kPadding, [self calculateLabelSize:description].width, [self calculateLabelSize:description].height);
    [description sizeToFit];
    [self.view addSubview:description];

   
    // Remove
    UIButton *remove = [[UIButton alloc] initWithFrame:CGRectMake(8, self.view.bounds.size.height-150, self.view.bounds.size.width-16, 50)];
    [remove addTarget:self action:nil forControlEvents: UIControlEventTouchUpInside];
    [remove addTarget:self action:@selector(animateDownPress:) forControlEvents: UIControlEventTouchDown];
    [remove addTarget:self action:@selector(animateUpPress:) forControlEvents: UIControlEventTouchUpOutside];
    NSString *removeText = [@"Ta bort" uppercaseString];
    [remove setTitle:removeText forState:UIControlStateNormal];
    remove.titleLabel.font = [Fonts mainFont];
    remove.backgroundColor = [Colors mainColor];
    remove.clipsToBounds = YES;
    remove.layer.cornerRadius = 10/2.0f;
    [self.view addSubview:remove];
}
                      

-(void)animateDownPress:(id)sender; {
    UIButton *btnPressed = (UIButton*)sender;
    CGFloat duration=0.3;
    
    CGFloat delay=0;
    CGFloat damping=0.6;
    CGFloat velocity=1;
    
    [UIView animateWithDuration:duration
                          delay:delay
         usingSpringWithDamping:damping
          initialSpringVelocity:velocity
                        options:UIViewAnimationOptionCurveEaseInOut animations:^{
                            
                            btnPressed.transform = CGAffineTransformMakeScale(.95, .95);
                            
                            
                        }
                     completion:^(BOOL finished) {
                             [self animateUpPress:btnPressed];
                     }];
    

}

-(void)animateUpPress:(id)sender; {
    UIButton *btnPressed = (UIButton*)sender;
    CGFloat duration=0.3;
    
    CGFloat delay=0;
    CGFloat damping=0.6;
    CGFloat velocity=1;
    
    [UIView animateWithDuration:duration
                          delay:delay
         usingSpringWithDamping:damping
          initialSpringVelocity:velocity
                        options:UIViewAnimationOptionCurveEaseInOut animations:^{
                            
                            btnPressed.transform = CGAffineTransformMakeScale(1, 1);
                            
                            
                        }
                     completion:^(BOOL finished) {
                         
                     }];
    
    
}









#pragma Other

-(CGSize)calculateLabelSize:(UILabel *)label {
    
    CGSize tempSize = CGSizeMake(self.view.bounds.size.width-(kPadding*2), 999);
    
    CGRect textRect = [label.text boundingRectWithSize:tempSize
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName:label.font}
                                               context:nil];
    
    CGSize size = textRect.size;
    
    return size;
}

// Setting the style of navigationbar Title
- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        [titleView setFont:[Fonts navBar]];
        titleView.textColor = [UIColor whiteColor];
        self.navigationItem.titleView = titleView;
    }
    titleView.text = title;
    [titleView sizeToFit];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
