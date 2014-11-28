//
//  YLPopoverMenu.m
//  PopupMenu
//
//  Copyright (c) 2011 Yakamoz Labs. All rights reserved.
//

#import "YLPopoverMenu.h"
#import "YLMenuItem.h"

#define kPopupMargin            5
#define kPopupPadding           4
#define kPopupBorderRadius      5
#define kPopupShadowOffset      5
#define kPopupShadowBlur        10
#ifdef UI_USER_INTERFACE_IDIOM
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#else
#define IS_IPAD false
#endif

#define kPopupButtonHeight (IS_IPAD ? 100 : 75)
#define kPopupButtonWidth (IS_IPAD ? 100 : 75)
#define role [[NSUserDefaults standardUserDefaults]objectForKey:@"role"]

#define kPopupColumns     (role=="ROLE_ADMIN" ? 3 : 2)
#define kPopupAnimationDuration 0.1

@interface YLPopoverMenu(Private)
- (void)setupMenuItems;
- (void)buttonTapped:(id)sender;
@end

@implementation YLPopoverMenu

@synthesize textColor = _textColor;
@synthesize textFont = _textFont;
@synthesize delegate = _delegate;

+ (YLPopoverMenu *)popoverMenuWithItems:(NSArray *)items target:(id)target {
    YLPopoverMenu *menu = [[YLPopoverMenu alloc] initWithItems:items target:target];
    
    return [menu autorelease];
}

- (id)initWithItems:(NSArray *)items target:(id)target {
    self = [super initWithFrame:CGRectZero];
    if(self) {
        _menuItems = [items retain];
        _target = target;
        _delegate = nil;
        
        _textColor = [[UIColor whiteColor] retain];
        if (IS_IPAD) {
             _textFont = [[UIFont boldSystemFontOfSize:15] retain];
        }
        else
        {
            _textFont = [[UIFont boldSystemFontOfSize:11] retain];
        }
       
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self setOpaque:NO];
        
        
        _menuItemsInitialized = NO;
    }
    
    return self;
}

- (void)dealloc {
    _delegate = nil;
    _target = nil;
    
    [_button release];
    [_menuItems release];
    [_textColor release];
    [_textFont release];
    
    [super dealloc];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
	
	int startY;
    int startX;
	if(_menuAtTop) {
		startY = _parentRect.origin.y + _parentRect.size.height + 1;
	} else {
		startY = _parentRect.origin.y - _popupHeight - 1;
	}
    if(_menuAtLeft) {
        startX = kPopupMargin;
    } else {
        startX = _parentRect.size.width - _popupWidth - kPopupMargin;
    }
	CGRect boxRect = CGRectMake(startX, startY, _popupWidth, _popupHeight);
	
	CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
	CGFloat boxColorComponents[4] =	{ 0.07, 0.07, 0.07, 1.0 };
	CGFloat blackColorComponents[4] = { 0.0, 0.0, 0.0, 1.0 };
	CGFloat boxShadowColorComponents[4] = { 0.0, 0.0, 0.0, 0.65 };	
	CGColorRef boxShadowColor = CGColorCreate(rgbColorSpace, boxShadowColorComponents);
	
	CGContextSaveGState(context);
	
	CGMutablePathRef outlinePath = CGPathCreateMutable();
	int X = boxRect.origin.x;
	int Y = boxRect.origin.y;
	int WIDTH = boxRect.size.width;
	int HEIGHT = boxRect.size.height;
	int buttonWidth = _buttonRect.size.width - (2 * kPopupMargin);
    if(_menuAtLeft) {
        buttonWidth += _buttonRect.origin.x - kPopupMargin;
    } else {
        buttonWidth += _parentRect.size.width - (_buttonRect.origin.x + _buttonRect.size.width) - kPopupMargin;
    }
	int buttonHeight = _buttonRect.size.height;
    if(buttonHeight > 30) {
        buttonHeight = 30;
    }
    
    // test for edge cases
    if(X > _buttonRect.origin.x) {
        int offset = X - _buttonRect.origin.x;
        X = _buttonRect.origin.x;
        WIDTH += offset;
        buttonWidth += offset;
    }
    
    if((X + WIDTH) < (_buttonRect.origin.x + _buttonRect.size.width)) {
        int offset = (_buttonRect.origin.x + _buttonRect.size.width) - (X + WIDTH);
        WIDTH += offset;
        buttonWidth += offset;
    }
    
    if((Y - kPopupMargin - buttonHeight) < (_parentRect.origin.y + kPopupMargin)) {
        buttonHeight -= _buttonRect.origin.y;
    }
	
	if(_menuAtTop) {
		if(_menuAtLeft) {
			// begin button part
			CGPathAddArc(outlinePath, NULL, X + kPopupMargin, Y - kPopupMargin - buttonHeight, kPopupBorderRadius, 1.0 * M_PI, 1.5 * M_PI, 0);
			CGPathAddArc(outlinePath, NULL, X + kPopupMargin + buttonWidth, Y - kPopupMargin - buttonHeight, kPopupBorderRadius, 1.5 * M_PI, 0.0, 0);
			CGPathAddArc(outlinePath, NULL, X + kPopupMargin + buttonWidth, Y + kPopupMargin, kPopupBorderRadius, 0.0 * M_PI, 1.5 * M_PI, 1);
			// end button part
			CGPathAddArc(outlinePath, NULL, X + WIDTH - kPopupMargin, Y + kPopupMargin, kPopupBorderRadius, 1.5 * M_PI, 0.0, 0);
			CGPathAddArc(outlinePath, NULL, X + WIDTH - kPopupMargin, Y + HEIGHT - kPopupMargin, kPopupBorderRadius, 0.0, 0.5 * M_PI, 0);
			CGPathAddArc(outlinePath, NULL, X + kPopupMargin, Y + HEIGHT - kPopupMargin, kPopupBorderRadius, 0.5 * M_PI, 1.0 * M_PI, 0);
			CGPathCloseSubpath(outlinePath);
		} else { // TOP RIGHT
			CGPathAddArc(outlinePath, NULL, X + kPopupMargin, Y + kPopupMargin, kPopupBorderRadius, 1.0 * M_PI, 1.5 * M_PI, 0);
			// begin button part
			CGPathAddArc(outlinePath, NULL, X + WIDTH - kPopupMargin - buttonWidth, Y + kPopupMargin, kPopupBorderRadius, 1.5 * M_PI, 1.0 * M_PI, 1);
			CGPathAddArc(outlinePath, NULL, X + WIDTH - kPopupMargin - buttonWidth, Y - kPopupMargin - buttonHeight, kPopupBorderRadius, 1.0 * M_PI, 1.5 * M_PI, 0);
			CGPathAddArc(outlinePath, NULL, X + WIDTH - kPopupMargin, Y - kPopupMargin - buttonHeight, kPopupBorderRadius, 1.5 * M_PI, 0.0, 0);
			// end button part
			CGPathAddArc(outlinePath, NULL, X + WIDTH - kPopupMargin, Y + HEIGHT - kPopupMargin, kPopupBorderRadius, 0.0, 0.5 * M_PI, 0);
			CGPathAddArc(outlinePath, NULL, X + kPopupMargin, Y + HEIGHT - kPopupMargin, kPopupBorderRadius, 0.5 * M_PI, 1.0 * M_PI, 0);
			CGPathCloseSubpath(outlinePath);
		}
	} else {
		if(_menuAtLeft) {
			CGPathAddArc(outlinePath, NULL, X + kPopupMargin, Y + kPopupMargin, kPopupBorderRadius, 1.0 * M_PI, 1.5 * M_PI, 0);
			CGPathAddArc(outlinePath, NULL, X + WIDTH - kPopupMargin, Y + kPopupMargin, kPopupBorderRadius, 1.5 * M_PI, 0.0, 0);
			CGPathAddArc(outlinePath, NULL, X + WIDTH - kPopupMargin, Y + HEIGHT - kPopupMargin, kPopupBorderRadius, 0.0, 0.5 * M_PI, 0);
			// begin button part
			CGPathAddArc(outlinePath, NULL, X + kPopupMargin + buttonWidth, Y + HEIGHT - kPopupMargin, kPopupBorderRadius, 0.5 * M_PI, 0.0 * M_PI, 1);
			CGPathAddArc(outlinePath, NULL, X + kPopupMargin + buttonWidth, Y + HEIGHT + kPopupMargin + buttonHeight, kPopupBorderRadius, 0.0 * M_PI, 0.5 * M_PI, 0);
			CGPathAddArc(outlinePath, NULL, X + kPopupMargin, Y + HEIGHT + kPopupMargin + buttonHeight, kPopupBorderRadius, 0.5 * M_PI, 1.0 * M_PI, 0);
			// end button part
			CGPathCloseSubpath(outlinePath);
		} else { // BOTTOM RIGHT
			CGPathAddArc(outlinePath, NULL, X + kPopupMargin, Y + kPopupMargin, kPopupBorderRadius, 1.0 * M_PI, 1.5 * M_PI, 0);
			CGPathAddArc(outlinePath, NULL, X + WIDTH - kPopupMargin, Y + kPopupMargin, kPopupBorderRadius, 1.5 * M_PI, 0.0, 0);
			// begin button part
			CGPathAddArc(outlinePath, NULL, X + WIDTH - kPopupMargin, Y + HEIGHT + kPopupMargin + buttonHeight, kPopupBorderRadius, 0.0, 0.5 * M_PI, 0);
			CGPathAddArc(outlinePath, NULL, X + WIDTH - kPopupMargin - buttonWidth, Y + HEIGHT + kPopupMargin + buttonHeight, kPopupBorderRadius, 0.5 * M_PI, 1.0 * M_PI, 0);
			CGPathAddArc(outlinePath, NULL, X + WIDTH - kPopupMargin - buttonWidth, Y + HEIGHT - kPopupMargin, kPopupBorderRadius, 1.0 * M_PI, 0.5 * M_PI, 1);
			// end button part
			CGPathAddArc(outlinePath, NULL, X + kPopupMargin, Y + HEIGHT - kPopupMargin, kPopupBorderRadius, 0.5 * M_PI, 1.0 * M_PI, 0);
			CGPathCloseSubpath(outlinePath);
		}
	}
	
	// box shadow
	CGContextAddRect(context, self.bounds);
	CGContextAddPath(context, outlinePath);
	CGContextEOClip(context);
	CGContextAddPath(context, outlinePath);
    if(_menuAtTop) {
        CGContextSetShadowWithColor(context, CGSizeMake(0.0, 1 * kPopupShadowOffset), kPopupShadowBlur, boxShadowColor);
    } else {
        CGContextSetShadowWithColor(context, CGSizeMake(0.0, -1 * kPopupShadowOffset), kPopupShadowBlur, boxShadowColor);
    }
	CGContextSetFillColor(context, blackColorComponents);
	CGContextFillPath(context);
	CGContextRestoreGState(context);
    
	// box background
	CGContextSaveGState(context);
	CGContextAddPath(context, outlinePath);
	CGContextClip(context);
	CGContextAddPath(context, outlinePath);
	CGContextSetFillColor(context, boxColorComponents);
	CGContextFillPath(context);
	CGContextRestoreGState(context);
	
    if([_button image] != nil) {
        UIImage *image = [_button image];
        CGSize size = CGSizeMake(image.size.width, image.size.height);
		CGRect imageRect;
		if(_menuAtTop) {
            int x = _buttonRect.origin.x + (_buttonRect.size.width - size.width) / 2;
            int y = _buttonRect.origin.y + (_buttonRect.size.height - size.height) / 2;
			imageRect = CGRectMake(x, _parentRect.origin.y + y, size.width, size.height); 
		} else {
            int x = _buttonRect.origin.x + (_buttonRect.size.width - size.width) / 2;
            int y = _buttonRect.origin.y + (_buttonRect.size.height - size.height) / 2 + 1;
			imageRect = CGRectMake(x, _parentRect.origin.y + y, size.width, size.height); 
		}
		
		[image drawInRect:imageRect];
    } else if([_button title] != nil && [[_button title] length] > 0) {
        NSString *title = [_button title];
        UIFont *textFont = [UIFont boldSystemFontOfSize:12];
        CGSize size = [title sizeWithFont:textFont forWidth:_buttonRect.size.width lineBreakMode:UILineBreakModeMiddleTruncation];
        CGRect titleRect;
		if(_menuAtTop) {
            int x = _buttonRect.origin.x + (_buttonRect.size.width - size.width) / 2;
            int y = _buttonRect.origin.y + (_buttonRect.size.height - size.height) / 2;
			titleRect = CGRectMake(x, y + _parentRect.origin.y, size.width, size.height);
		} else {
            int x = _buttonRect.origin.x + (_buttonRect.size.width - size.width) / 2;
            int y = (_buttonRect.size.height - size.height) / 2 + 1;
			titleRect = CGRectMake(x, _parentRect.origin.y + y, size.width, size.height); 
		}
		
        CGContextSaveGState(context);
        CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
        [title drawInRect:titleRect withFont:textFont lineBreakMode:UILineBreakModeMiddleTruncation alignment:UITextAlignmentCenter];
        CGContextRestoreGState(context);
    }
	
	CGColorSpaceRelease(rgbColorSpace);
	CGPathRelease(outlinePath);
	CGColorRelease(boxShadowColor);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self dismissPopoverAnimated:YES];
}


#pragma mark -
#pragma mark Instance Methods
- (void)presentPopoverFromBarButtonItem:(UIBarButtonItem *)button animated:(BOOL)animated {
    UIView *buttonView = (UIView *)[button performSelector:@selector(view)];
	UIView *buttonSuperview = [buttonView superview];
	UIView *containerView = nil;
    CGRect containerFrame;
    
    _button = [button retain];
    _buttonRect = buttonView.frame;
    _parentRect = buttonSuperview.frame;
    
	if([buttonSuperview isKindOfClass:[UINavigationBar class]]) {
		UINavigationController *navController = [(UINavigationBar *)buttonSuperview delegate];
        containerView = [navController view];
        containerFrame = containerView.frame;
        if(UIInterfaceOrientationIsLandscape([[navController topViewController] interfaceOrientation])) {
            int width = containerFrame.size.width;
            containerFrame.size.width = containerFrame.size.height;
            containerFrame.size.height = width;
        }
	} else if([buttonSuperview isKindOfClass:[UIToolbar class]]) {
		containerView = [buttonSuperview superview];
        containerFrame = containerView.frame;
	}
    
    if(containerView == nil) {
        NSLog(@"Cannot determine container view for UIBarButtonItem");
        return;
    }
    
    containerFrame.origin = CGPointMake(0, 0);
    if(containerFrame.size.width != _parentRect.size.width) {
        int temp = containerFrame.size.width;
        containerFrame.size.width = containerFrame.size.height;
        containerFrame.size.height = temp;
    }
    self.frame = containerFrame;
    
    _menuAtTop = _parentRect.origin.y < (containerFrame.size.height / 2) ? YES : NO;
    _menuAtLeft = _buttonRect.origin.x < (containerFrame.size.width / 2) ? YES : NO;
    
    [self setupMenuItems];
    
    if(animated) {
        self.alpha = 0.0;
    }
	
    [containerView addSubview:self];
    [containerView bringSubviewToFront:self];
    
    if(animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:kPopupAnimationDuration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.alpha = 1.0;
        [UIView commitAnimations];
    }
}

- (void)dismissPopoverAnimated:(BOOL)animated {
	if(animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:kPopupAnimationDuration];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(hideAnimationDidStop:finished:context:)];
        self.alpha = 0.0;
        [UIView commitAnimations];
    } else {
        [self removeFromSuperview];
    }
}

- (NSString *)buttonTitleAtIndex:(NSInteger)index {
    if(index < 0 || index >= [_menuItems count]) {
        return nil;
    }
    
    return [[_menuItems objectAtIndex:index] title];
}

- (void) hideAnimationDidStop:(NSString*) animationID finished:(NSNumber*) finished context:(void*) context {
	[self removeFromSuperview];
}


#pragma mark -
#pragma mark Private Methods
- (void)setupMenuItems {
    if(_menuItems == nil) {
        return;
    }
    
    if(_menuItemsInitialized) {
        return;
    }
    
    int rows = [_menuItems count] / kPopupColumns;
	rows += ([_menuItems count] % kPopupColumns) > 0 ? 1 : 0;
    _popupWidth = (kPopupColumns * kPopupButtonWidth) + ((kPopupColumns + 1) * kPopupPadding);
    _popupHeight = ((rows + 1) * kPopupPadding) + (rows * kPopupButtonHeight);
	
    int startY;
    int startX;
	if(_menuAtTop) {
		startY = _parentRect.origin.y + _parentRect.size.height + 1;
	} else {
		startY = _parentRect.origin.y - _popupHeight - 1;
	}
    if(_menuAtLeft) {
        startX = kPopupMargin + kPopupPadding;
    } else {
        startX = _parentRect.size.width - _popupWidth - kPopupMargin + kPopupPadding;
    }
    
	CGRect startRect = CGRectMake(startX, startY + kPopupPadding, kPopupButtonWidth, kPopupButtonHeight);
	int counter = 0;
	for(YLMenuItem *item in _menuItems) {
		CGRect bRect = startRect;
		int row = counter / kPopupColumns;
		int column = counter % kPopupColumns;
		bRect.origin.x += (column * kPopupButtonWidth) + (column * kPopupPadding);
		bRect.origin.y += (row * kPopupButtonHeight) + (row * kPopupPadding);
		
		UIButton* b = [[[UIButton alloc] initWithFrame:bRect] autorelease];
		[b addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [b setBackgroundImage:[UIImage imageNamed:@"button_bg.png"] forState:UIControlStateNormal];
        if([item icon]) {
            [b setImage:[item icon] forState:UIControlStateNormal];
        }
        if([item pressedIcon]) {
            [b setImage:[item pressedIcon] forState:UIControlStateHighlighted];
        }
		[b setTag:counter];
		
		int labelWidth = bRect.size.width;
		int labelHeight = 15;
        CGRect lRect;
        if (IS_IPAD) {
             lRect = CGRectMake((bRect.size.width - labelWidth) / 2, (bRect.size.height - labelHeight)-5, labelWidth, labelHeight);
        }
        else
        {
             lRect = CGRectMake((bRect.size.width - labelWidth) / 2, (bRect.size.height - labelHeight)-3, labelWidth, labelHeight);
        }
		
		UILabel* l = [[UILabel alloc] initWithFrame:lRect];
		[l setTextAlignment:UITextAlignmentCenter];
        [l setShadowColor:[UIColor blackColor]];
        [l setShadowOffset:CGSizeMake(0, -1)];
		[l setTextColor:_textColor];
		[l setFont:_textFont];
		[l setBackgroundColor:[UIColor clearColor]];
		[l setText:[item title]];
		[b addSubview:l];
		[l release];
		[self addSubview:b];
		
		counter++;
	}
	
    _menuItemsInitialized = YES;
	[self setNeedsDisplay];
}

- (void)buttonTapped:(id)sender {
    UIButton *b = (UIButton *)sender;
	
	// if delegate is set call delegate function, otherwise call the selector of the tapped menu item
	if(_delegate) {
        [_delegate popoverMenu:self didSelectItem:[b tag]];
	} else {
		YLMenuItem *item = [_menuItems objectAtIndex:[b tag]];
		if([item selector] != nil) {
			[_target performSelectorOnMainThread:[item selector] withObject:nil waitUntilDone:YES];
		}
	}
	
    [self dismissPopoverAnimated:YES];
}

@end
