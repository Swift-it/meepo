//
//  addNote.m
//  meepo
//
//  Created by Mikael Melander on 2018-02-03.
//  Copyright © 2018 Mikael Melander. All rights reserved.
//

#import "addNote.h"



@interface addNote ()

@end

static CGFloat kPadding = 16.0f;
static CGFloat kStandardHeaderLabelHeight = 40.0f;
static CGFloat kStandardButtonHeight = 50;
static CGFloat kNavbarStatusbarHeight = 55;

@implementation addNote

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
     self.view.backgroundColor = [Colors whiteColor];
    
    // Setting up Navbar
   
    UIBarButtonItem *newback = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:newback];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[Colors mainColor]];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    title = [[UITextField alloc] initWithFrame:CGRectMake(kPadding, kPadding, self.view.bounds.size.width-(kPadding*2), kStandardHeaderLabelHeight)];
    title.backgroundColor = [Colors veryLightGray];
    title.textColor = [Colors mainColor];
    title.placeholder = @"Title";
    title.font = [Fonts mainFont];
    title.delegate = self;
    [title.layer setBorderColor:[Colors mainColorLowAlpha].CGColor];
    [title.layer setBorderWidth:1.0];
    [title.layer setCornerRadius:10.0f];
    title.tag=0;
   
    description = [[UITextView alloc] initWithFrame:CGRectMake(kPadding, title.frame.size.height+title.frame.origin.y+kPadding, self.view.bounds.size.width-(kPadding*2), self.view.frame.size.height/3)];
    description.editable = YES;
    description.text = @"Description...";
    description.backgroundColor = [Colors veryLightGray];
    description.font = [Fonts placeholderFont];
    description.textColor = [Colors placeholderColor];
    [description.layer setCornerRadius:10.0f];
    description.tag = 1;
    description.delegate = self;
    
  
 
    
    // Remove keyboard
    rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(removeKeyboard)];

    
    // Change
    upload = [[UIButton alloc] initWithFrame:CGRectMake(kPadding, self.view.bounds.size.height-kStandardButtonHeight-kPadding-kNavbarStatusbarHeight, self.view.bounds.size.width-(kPadding*2), kStandardButtonHeight)];
    [upload addTarget:self action:@selector(sendNote) forControlEvents: UIControlEventTouchUpInside];
    [upload addTarget:self action:@selector(animateDownPress:) forControlEvents: UIControlEventTouchDown];
    [upload addTarget:self action:@selector(animateUpPress:) forControlEvents: UIControlEventTouchUpOutside];
    [upload setTitle:[@"Add" uppercaseString] forState:UIControlStateNormal];
    upload.titleLabel.font = [Fonts mainFont];
    upload.backgroundColor = [Colors mainColor];
    upload.clipsToBounds = YES;
    upload.layer.cornerRadius = 10/2.0f;
   
   
    
    
    // If changing not instead of createign
    if([_change count] > 0) {
         note = [[noteObject alloc] initWithDic:_change];
        [self setTitle:@"Change note"];
        [upload setTitle:[@"Save" uppercaseString] forState:UIControlStateNormal];
        title.text = [note getTitle];
        description.text = [note getDescription];
    } else {
        [self setTitle:@"Add note"];
        [upload setTitle:[@"Add" uppercaseString] forState:UIControlStateNormal];
    }
    
     [self.view addSubview:title];
     [self.view addSubview:description];
     [self.view addSubview:upload];
}


#pragma HTTP arguments



-(void)sendNote {
    
    if ([self textToShort])
        [self alert:@"Error :/" :@"Title or description to short"];
    else {
        NSDictionary *send;
        
        httpData *dataFetch = [[httpData alloc]init];
        dataFetch.delegate = self;
        if ([_change objectForKey:@"id"] != nil) {
    
            noteObject *save = [[noteObject alloc] initForSave:title.text andDesc:description.text andId:[note getId]];
            
            
            [dataFetch postData:save :@"PUT"];
        }
        else {
            noteObject *save = [[noteObject alloc] initForSave:title.text andDesc:description.text];
            [dataFetch postData:save :@"POST"];
        }
        NSLog(@"To upload JSON: %@", send);
    }
}

-(BOOL)textToShort {
    
     if (title.text.length < 3 || description.text.length < 3)
         return YES;
     else
         return NO;
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
        [self.navigationController popToRootViewControllerAnimated:YES];
    });
  

}
// Recive GET Failed.
-(void)didFailWithRequest:(NSString *)err {
    NSLog(@"%@", err);
    
    [self alert:@"Error :/" :err.description];
}


#pragma textField/textView

- (void)textViewDidBeginEditing:(UITextView *)textView
{
     [self.navigationItem setRightBarButtonItem:rightBarButton animated:YES];
    if ([textView.text isEqualToString:@"Description..."]) {
        textView.text = @"";
 
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem = nil;
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Description...";
    }
    [textView resignFirstResponder];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSInteger nextTag = textField.tag + 1;
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
     if (nextResponder) {
        [nextResponder becomeFirstResponder];
    }
    else {
        [textField resignFirstResponder];
    }
    return NO;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 10);
}


- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 10);
}


-(void)removeKeyboard {
    [description resignFirstResponder];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
