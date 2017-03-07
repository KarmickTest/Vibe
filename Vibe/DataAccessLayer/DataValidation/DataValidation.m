//
//  DataValidation.m
//  ProjDemo
//
//  Created by Ankush Chakraborty on 17/11/14.
//  Copyright (c) 2014 Isis Design Services. All rights reserved.
//

#import "DataValidation.h"

@implementation DataValidation

+ (BOOL)isDeviceiPhone {
    if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone )) {
        return YES;
    }
    return NO;
}

+ (BOOL)isNullString:(NSString *)textString {
    if (textString == nil || textString == (id)[NSNull null] || [[NSString stringWithFormat:@"%@",textString] length] == 0 || [[[NSString stringWithFormat:@"%@",textString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return YES;
    }
    else{
        return NO;
    }
}

+ (BOOL)isNumericString:(NSString *)text {
    BOOL valid;
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:text];
    valid = [alphaNums isSupersetOfSet:inStringSet];
    return valid;
}

+ (BOOL)isAlphabetString:(NSString *)text {
    NSCharacterSet *alpha = [NSCharacterSet letterCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:text];
    return [alpha isSupersetOfSet:inStringSet];
}

+ (BOOL)isValidateMailid:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)isValidPassword:(NSString*)password {
    /*Minimum 6 character
     Atleast one english capital letter
     One english small letter
     One digit
     One special character (#?!@$%^&*-)*/
    
    NSString *emailRegex = @"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{6,15}$";
    NSPredicate *passwordlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [passwordlTest evaluateWithObject:password];
}

+ (BOOL)isFutureDateByToday:(NSDate *)date {
    return ([date compare:[NSDate date]] == NSOrderedSame || [date compare:[NSDate date]] == NSOrderedAscending) ? NO : YES;
}

+ (BOOL)isFutureDate:(NSDate *)date1 byDate:(NSDate *)date2 {
    return ([date1 compare:date2] == NSOrderedSame || [date1 compare:date2] == NSOrderedAscending) ? NO : YES;
}

+ (BOOL)isAgeGreaterThanOrEqualTo:(int)age dateOfBirth:(NSDate *)dob {
    NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                       components:NSCalendarUnitYear
                                       fromDate:dob
                                       toDate:[NSDate date]
                                       options:0];
    return [ageComponents year] >= age ? YES : NO;
}

+ (BOOL)validatePhone:(NSString *)phoneNumber CountryCode:(NSString *)_countryCode
{
    NSString *phoneRegex;
    if([_countryCode isEqualToString:@"+852"] || [_countryCode isEqualToString:@"+853"] || [_countryCode isEqualToString:@"+65"]){
        phoneRegex = @"^[0-9]{8,8}$";
    }
    else if ([_countryCode isEqualToString:@"+62"] || [_countryCode isEqualToString:@"+886"]){
        phoneRegex = @"^[0-9]{9,9}$";
    }
    else if ([_countryCode isEqualToString:@"+60"] || [_countryCode isEqualToString:@"+1"]){
        phoneRegex = @"^[0-9]{10,10}$";
    }
    else
    {
        phoneRegex = @"^[0-9]{11,11}$";
    }
    //phoneRegex = @"^[0-9]{6,10}$";//^((\\+)|(00))[0-9]{6,14}$
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:phoneNumber];
}

@end
