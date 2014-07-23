//
//  databaseurl.h
//  webservice
//
//  Created by DeemsysInc on 6/19/14.
//  Copyright (c) 2014 DeemsysInc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface databaseurl : NSObject
{
    BOOL isConnect;
    NSString *Headername;
}
+(databaseurl*)sharedInstance;
-(NSString*)submitvalues;
- (NSString*) DBurl;
-(NSString *)returndbresult:(NSString *)post URL:(NSURL *)url;
-(NSString *)imagecheck:(NSString*)imagename;
-(BOOL)validateNameForContactUsPage:(NSString *)firstname;
-(BOOL)validateMobileForContactUsPage:(NSString*)mobilenumber;
-(BOOL)validateEmailForContactUsPage:(NSString*)candidate;
-(BOOL)validateOtherNameForContactUsPage:(NSString *)firstname;
@end
