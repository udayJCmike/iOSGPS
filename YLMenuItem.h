//
//  YLMenuItem.h
//  PopupMenu
//
//  Copyright (c) 2011 Yakamoz Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLMenuItem : NSObject {
	NSString *_title;
	UIImage *_icon;
    UIImage *_pressedIcon;
	SEL _selector;
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) UIImage *icon;
@property (nonatomic, retain) UIImage *pressedIcon;
@property (assign) SEL selector;

+ (YLMenuItem *)menuItemWithTitle:(NSString *)title icon:(UIImage *)icon;
+ (YLMenuItem *)menuItemWithTitle:(NSString *)title icon:(UIImage *)icon pressedIcon:(UIImage *)pressedIcon;
+ (YLMenuItem *)menuItemWithTitle:(NSString *)title icon:(UIImage *)icon selector:(SEL)selector;
+ (YLMenuItem *)menuItemWithTitle:(NSString *)title icon:(UIImage *)icon pressedIcon:(UIImage *)pressedIcon selector:(SEL)selector;


- (id)initWithTitle:(NSString *)title icon:(UIImage *)icon pressedIcon:(UIImage *)pressedIcon selector:(SEL)selector;

@end
