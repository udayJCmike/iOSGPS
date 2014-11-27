//
//  YLPopoverMenu.h
//  PopupMenu
//
//  Copyright (c) 2011 Yakamoz Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YLPopoverMenuDelegate;

@interface YLPopoverMenu : UIView {
    NSArray *_menuItems;
    
    UIBarButtonItem *_button;
    CGRect _buttonRect;
    CGRect _parentRect;
    BOOL _menuAtTop;
    BOOL _menuAtLeft;
    BOOL _menuItemsInitialized;
    NSUInteger _popupWidth;
    NSUInteger _popupHeight;
    
    UIColor *_textColor;
    UIFont *_textFont;
    
    id _target;
    NSObject<YLPopoverMenuDelegate> *_delegate;
}

@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic, retain) UIFont *textFont;
@property (nonatomic, assign) NSObject<YLPopoverMenuDelegate> *delegate;

+ (YLPopoverMenu *)popoverMenuWithItems:(NSArray *)items target:(id)target;
- (id)initWithItems:(NSArray *)items target:(id)target;

- (void)presentPopoverFromBarButtonItem:(UIBarButtonItem *)button animated:(BOOL)animated;
- (void)dismissPopoverAnimated:(BOOL)animated;
- (NSString *)buttonTitleAtIndex:(NSInteger)index;

@end


@protocol YLPopoverMenuDelegate<NSObject>
@required
- (void)popoverMenu:(YLPopoverMenu *)menu didSelectItem:(int)item;
@end
