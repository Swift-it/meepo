//
//  detailedNote.h
//  meepo
//
//  Created by Mikael Melander on 2018-02-02.
//  Copyright © 2018 Mikael Melander. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Colors.h"
#import "Fonts.h"
#import "httpData.h"
#import "addNote.h"


@interface detailedNote : UIViewController <httpDataDelegate> {
  
    UILabel *title;
    UILabel *description;
}
@property(nonatomic, retain) NSDictionary *note;

@end
