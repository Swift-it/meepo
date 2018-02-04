//
//  addNote.h
//  meepo
//
//  Created by Mikael Melander on 2018-02-03.
//  Copyright © 2018 Mikael Melander. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Colors.h"
#import "Fonts.h"
#import "httpData.h"

@interface addNote : UIViewController <UITextFieldDelegate, UITextViewDelegate, httpDataDelegate> {
    UIBarButtonItem *rightBarButton;
    UITextField *title;
    UITextView *description;
    UIButton *upload;
}

@property(nonatomic, retain) NSDictionary *change;

@end
