//
//  ViewController.h
//  meepo
//
//  Created by Mikael Melander on 2018-02-02.
//  Copyright © 2018 Mikael Melander. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Colors.h"
#import "Fonts.h"
#import "notesCell.h"
#import "httpData.h"
#import "detailedNote.h"

@interface ViewController : UIViewController  <UITableViewDataSource, UITableViewDelegate, httpDataDelegate> {
  
    NSArray *notesArray;

}

@property (nonatomic, strong) UITableView *table;


@end

