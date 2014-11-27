//
//  YLMenuItem.m
//  PopupMenu
//
//  Copyright (c) 2011 Yakamoz Labs. All rights reserved.
//

#import "YLMenuItem.h"

@implementation YLMenuItem

@synthesize title = _title;
@synthesize icon = _icon;
@synthesize pressedIcon = _pressedIcon;
@synthesize selector = _selector;

+ (YLMenuItem *)menuItemWithTitle:(NSString *)title icon:(UIImage *)icon {
    YLMenuItem *item = [[YLMenuItem alloc] initWithTitle:title icon:icon pressedIcon:nil selector:nil];
    
    return [item autorelease];
}

+ (YLMenuItem *)menuItemWithTitle:(NSString *)title icon:(UIImage *)icon pressedIcon:(UIImage *)pressedIcon {
    YLMenuItem *item = [[YLMenuItem alloc] initWithTitle:title icon:icon pressedIcon:pressedIcon selector:nil];
    
    return [item autorelease];
}

+ (YLMenuItem *)menuItemWithTitle:(NSString *)title icon:(UIImage *)icon selector:(SEL)selector {
    YLMenuItem *item = [[YLMenuItem alloc] initWithTitle:title icon:icon pressedIcon:nil selector:selector];
    
    return [item autorelease];
}

+ (YLMenuItem *)menuItemWithTitle:(NSString *)title icon:(UIImage *)icon pressedIcon:(UIImage *)pressedIcon selector:(SEL)selector {
    YLMenuItem *item = [[YLMenuItem alloc] initWithTitle:title icon:icon pressedIcon:pressedIcon selector:selector];
    
    return [item autorelease];
}

- (id)initWithTitle:(NSString *)title icon:(UIImage *)icon pressedIcon:(UIImage *)pressedIcon selector:(SEL)selector {
    self = [super init];
    if(self) {
        _title = [title copy];
        _icon = [icon retain];
        _pressedIcon = [pressedIcon retain];
        _selector = selector;
    }
    
    return self;
}

- (void)dealloc {
    [_title release];
    [_icon release];
    [_pressedIcon release];
    _selector = nil;
    
    [super dealloc];
}

@end
