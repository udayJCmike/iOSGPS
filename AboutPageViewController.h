//
//  AboutPageViewController.h
//  DeemGPS
//
//  Created by DeemsysInc on 26/11/14.
//  Copyright (c) 2014 deemsysinc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutPageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *contentTableView;

@end
