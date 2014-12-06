//
//  CalloutView.h
//  MapView
//
//  Created by dev27 on 5/30/13.
//  Copyright (c) 2013 codigator. All rights reserved.
//

#import <UIKit/UIKit.h>
#ifdef UI_USER_INTERFACE_IDIOM
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#else
#define IS_IPAD false
#endif
@interface CalloutView : UIView
@property (weak, nonatomic) IBOutlet UILabel *calloutLabel;

@end
