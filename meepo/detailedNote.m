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
static CGFloat kStandardHeaderLabelHeight = 50.0f;


@implementation detailedNote

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [Colors whiteColor];

 
    // Setting up Navbar
    [self setTitle:@"Details"];
    UIBarButtonItem *newback = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:newback];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[Colors mainColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
  
    
    
    NSLog(@"id: %@", [_note objectForKey:@"id"]);
    
    
    
    UIScrollView *scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    scroller.scrollEnabled = YES;
    scroller.bounces = YES;
    
    title = [[UILabel alloc] init];
    title.font = [Fonts mainFont];
    title.textColor =  [Colors mainColor];
    title.textAlignment = NSTextAlignmentLeft;
    title.lineBreakMode = NSLineBreakByWordWrapping;
    title.lineBreakMode = NSLineBreakByTruncatingTail;
    title.numberOfLines = 0;
    title.text = [_note objectForKey:@"title"];
    title.frame = CGRectMake(kPadding, kPadding, [self calculateLabelSize:title].width, [self calculateLabelSize:title].height);
    [title sizeToFit];
    
    [scroller addSubview:title];
    
    
    UIImageView *sideimg = [[UIImageView alloc] initWithFrame:CGRectMake(title.frame.origin.x, title.frame.origin.y+title.frame.size.height + 1.5, title.frame.size.width, 1)];
    sideimg.backgroundColor = [Colors mainColor];
    sideimg.alpha = 0.5;
    [scroller addSubview:sideimg];
    
    
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
    [scroller addSubview:description];
    

    // Change
    UIButton *change = [[UIButton alloc] initWithFrame:CGRectMake(8, description.frame.size.height+description.frame.origin.y+kPadding, self.view.bounds.size.width-16, 50)];
    [change addTarget:self action:nil forControlEvents: UIControlEventTouchUpInside];
    [change addTarget:self action:@selector(animateDownPress:) forControlEvents: UIControlEventTouchDown];
    [change addTarget:self action:@selector(animateUpPress:) forControlEvents: UIControlEventTouchUpOutside];
    [change setTitle:[@"Ändra" uppercaseString] forState:UIControlStateNormal];
    change.titleLabel.font = [Fonts mainFont];
    change.backgroundColor = [Colors mainColor];
    change.clipsToBounds = YES;
    change.layer.cornerRadius = 10/2.0f;
    [scroller addSubview:change];
    
    // Remove
    UIButton *remove = [[UIButton alloc] initWithFrame:CGRectMake(8, change.frame.origin.y+change.frame.size.height+kPadding, self.view.bounds.size.width-16, 50)];
    [remove addTarget:self action:@selector(remove) forControlEvents: UIControlEventTouchUpInside];
    [remove addTarget:self action:@selector(animateDownPress:) forControlEvents: UIControlEventTouchDown];
    [remove addTarget:self action:@selector(animateUpPress:) forControlEvents: UIControlEventTouchUpOutside];
    [remove setTitle:[@"Ta bort" uppercaseString] forState:UIControlStateNormal];
    remove.titleLabel.font = [Fonts mainFont];
    remove.backgroundColor = [Colors redColor];
    remove.clipsToBounds = YES;
    remove.layer.cornerRadius = 10/2.0f;
    [scroller addSubview:remove];
    
    
    
    scroller.contentSize = CGSizeMake(self.view.bounds.size.width, remove.frame.size.height+remove.frame.origin.y+85+kPadding);
    [self.view addSubview:scroller];
}


-(void)deleteNote {
    
    if (title.text.length < 3 || description.text.length < 3)
        [self alert:@"Error :/" :@"Title or description to short"];
    else {
        NSDictionary *send = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:[[_note objectForKey:@"id"] intValue]],@"id", nil];
        
       NSLog(@"To upload JSON: %@", send);
        
        httpData *dataFetch = [[httpData alloc]init];
        dataFetch.delegate = self;
        [dataFetch postData:send :@"DELETE"]; 
        
        NSLog(@"%@", send);
        
    }
}

-(void)didFininshRequestWithJson:(NSArray *)responseJson
{
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        title.text = @"";
        description.text = @"";
        NSLog(@"%@", responseJson);
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"update"
         object:self];
        [[self navigationController] popViewControllerAnimated:YES];
    });
  
    NSLog(@"Finished");
    
    
}
// Recive GET Failed.
-(void)didFailWithRequest:(NSString *)err {
    NSLog(@"%@", err);
    
    [self alert:@"Error :/" :err.description];
}


#pragma Other

-(void)alert:(NSString *)title :(NSString *)desc {
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:desc
                                  preferredStyle:UIAlertControllerStyleAlert];
    alert.view.tintColor = [Colors mainColor];
    
    
    
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Ok"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    [alert addAction:cancel];
    
    
    [self presentViewController:alert animated:YES completion:nil];
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


#pragma Button selectors

-(void)remove {
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Remove"
                                  message:@"Are you sure you want to remove note?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    alert.view.tintColor = [Colors mainColor];
    

    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Yes"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [self deleteNote];
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {

                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    [alert addAction:cancel];
    [alert addAction:ok];
    
    
    [self presentViewController:alert animated:YES completion:nil];
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
