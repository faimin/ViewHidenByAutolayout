//
// UIView+HidenWIthAutoLayoutConstraints.m
// hidenWithAutolayout
//
// Created by Tony on 15/8/20.
// Copyright (c) 2015年 Tony. All rights reserved.
//

#import "UIView+HidenWithAutoLayoutConstraints.h"
#import <objc/runtime.h>

@implementation UIView (HidenWithAutoLayoutConstraints)

- (void)hideWithAutoLayoutAttributes:(NSLayoutAttribute)attributes, ...NS_REQUIRES_NIL_TERMINATION
{
    va_list ap;
    va_start(ap, attributes);

    if (attributes)
    {
        [self hideView:!self.hidden withAttribute:attributes];

        NSLayoutAttribute detailAttribute;

        while ( ( detailAttribute = va_arg(ap, NSLayoutAttribute) ) )
        {
            [self hideView:!self.hidden withAttribute:detailAttribute];
        }
    }

    va_end(ap);
    self.hidden = !self.hidden;
}

- (void)hideView:(BOOL)hidden withAttribute:(NSLayoutAttribute)attribute
{
    NSLayoutConstraint *constraint = [self constraintForAttribute:attribute];
    if (constraint)
    {
        NSString *constraintString = [self AttributeToString:attribute];
        NSNumber *savednumber      = objc_getAssociatedObject(self, [constraintString UTF8String]);

        if (!savednumber)
        {
            objc_setAssociatedObject(self, [constraintString UTF8String], @(constraint.constant), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            savednumber = @(constraint.constant);
        }

        if (hidden)
        {
            [constraint setConstant:0];
        }
        else
        {
            [constraint setConstant:savednumber.floatValue];
        }
    }
}

- (CGFloat)constraintConstantforAttribute:(NSLayoutAttribute)attribute
{
    NSLayoutConstraint *constraint = [self constraintForAttribute:attribute];
    if (constraint)
    {
        return constraint.constant;
    }
    else
    {
        return NAN;
    }
}

- (NSLayoutConstraint *)constraintForAttribute:(NSLayoutAttribute)attribute
{
    NSPredicate *predicate      = [NSPredicate predicateWithFormat:@"firstAttribute = %d && firstItem = %@", attribute, self];
    NSArray     *constraintsArr = [self.superview constraints];
    NSArray     *fillteredArray = [constraintsArr filteredArrayUsingPredicate:predicate];

    if (fillteredArray.count == 0)
    {
        NSArray *selffillteredArray = [self.constraints filteredArrayUsingPredicate:predicate];
        if (selffillteredArray.count == 0)
        {
            return nil;
        }
        else
        {
            return selffillteredArray.firstObject;
        }
    }
    else
    {
        return fillteredArray.firstObject;
    }
} /* constraintForAttribute */

- (NSString *)AttributeToString:(NSLayoutAttribute)attribute
{
    switch (attribute)
    {
        case NSLayoutAttributeLeft:
        {
            return @"NSLayoutAttributeLeft";
        }

        case NSLayoutAttributeRight:
        {
            return @"NSLayoutAttributeRight";
        }

        case NSLayoutAttributeTop:
        {
            return @"NSLayoutAttributeTop";
        }

        case NSLayoutAttributeBottom:
        {
            return @"NSLayoutAttributeBottom";
        }

        case NSLayoutAttributeLeading:
        {
            return @"NSLayoutAttributeLeading";
        }

        case NSLayoutAttributeTrailing:
        {
            return @"NSLayoutAttributeTrailing";
        }

        case NSLayoutAttributeWidth:
        {
            return @"NSLayoutAttributeWidth";
        }

        case NSLayoutAttributeHeight:
        {
            return @"NSLayoutAttributeHeight";
        }

        case NSLayoutAttributeCenterX:
        {
            return @"NSLayoutAttributeCenterX";
        }

        case NSLayoutAttributeCenterY:
        {
            return @"NSLayoutAttributeCenterY";
        }

        case NSLayoutAttributeBaseline:
        {
            return @"NSLayoutAttributeBaseline";
        }

        case NSLayoutAttributeFirstBaseline:
        {
            return @"NSLayoutAttributeFirstBaseline";
        }

        case NSLayoutAttributeLeftMargin:
        {
            return @"NSLayoutAttributeLeftMargin";
        }

        case NSLayoutAttributeRightMargin:
        {
            return @"NSLayoutAttributeRightMargin";
        }

        case NSLayoutAttributeTopMargin:
        {
            return @"NSLayoutAttributeTopMargin";
        }

        case NSLayoutAttributeBottomMargin:
        {
            return @"NSLayoutAttributeBottomMargin";
        }

        case NSLayoutAttributeLeadingMargin:
        {
            return @"NSLayoutAttributeLeadingMargin";
        }

        case NSLayoutAttributeTrailingMargin:
        {
            return @"NSLayoutAttributeTrailingMargin";
        }

        case NSLayoutAttributeCenterXWithinMargins:
        {
            return @"NSLayoutAttributeCenterXWithinMargins";
        }

        case NSLayoutAttributeCenterYWithinMargins:
        {
            return @"NSLayoutAttributeCenterYWithinMargins";
        }

        case NSLayoutAttributeNotAnAttribute:
        {
            return @"NSLayoutAttributeNotAnAttribute";
        }

        default:
            break;
    } /* switch */

    return @"NSLayoutAttributeNotAnAttribute";
} /* AttributeToString */

@end
