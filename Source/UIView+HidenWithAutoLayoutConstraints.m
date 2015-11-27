//
//  UIView+HidenWIthAutoLayoutConstraints.m
//  hidenWithAutolayout
//
//  Created by Tony on 15/8/20.
//  Copyright (c) 2015年 Tony. All rights reserved.
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

		while ((detailAttribute = va_arg(ap, NSLayoutAttribute)))
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

		NSNumber *savednumber = objc_getAssociatedObject(self, [constraintString UTF8String]);

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
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstAttribute = %d && firstItem = %@", attribute, self];
	NSArray *constraintsArr = [self.superview constraints];
	NSArray *fillteredArray = [constraintsArr filteredArrayUsingPredicate:predicate];

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
		return nil;
	}
	else
	{
		return fillteredArray.firstObject;
	}
}

- (NSString *)AttributeToString:(NSLayoutAttribute)attribute
{
	switch (attribute) {
		case NSLayoutAttributeLeft:
		{
			return @"NSLayoutAttributeLeft";

			break;
		}

		case NSLayoutAttributeRight:
		{
			return @"NSLayoutAttributeRight";

			break;
		}

		case NSLayoutAttributeTop:
		{
			return @"NSLayoutAttributeTop";

			break;
		}

		case NSLayoutAttributeBottom:
		{
			return @"NSLayoutAttributeBottom";

			break;
		}

		case NSLayoutAttributeLeading:
		{
			return @"NSLayoutAttributeLeading";

			break;
		}

		case NSLayoutAttributeTrailing:
		{
			return @"NSLayoutAttributeTrailing";

			break;
		}

		case NSLayoutAttributeWidth:
		{
			return @"NSLayoutAttributeWidth";

			break;
		}

		case NSLayoutAttributeHeight:
		{
			return @"NSLayoutAttributeHeight";

			break;
		}

		case NSLayoutAttributeCenterX:
		{
			return @"NSLayoutAttributeCenterX";

			break;
		}

		case NSLayoutAttributeCenterY:
		{
			return @"NSLayoutAttributeCenterY";

			break;
		}

		case NSLayoutAttributeBaseline:
		{
			return @"NSLayoutAttributeBaseline";

			break;
		}

		case NSLayoutAttributeFirstBaseline:
		{
			return @"NSLayoutAttributeFirstBaseline";

			break;
		}

		case NSLayoutAttributeLeftMargin:
		{
			return @"NSLayoutAttributeLeftMargin";

			break;
		}

		case NSLayoutAttributeRightMargin:
		{
			return @"NSLayoutAttributeRightMargin";

			break;
		}

		case NSLayoutAttributeTopMargin:
		{
			return @"NSLayoutAttributeTopMargin";

			break;
		}

		case NSLayoutAttributeBottomMargin:
		{
			return @"NSLayoutAttributeBottomMargin";

			break;
		}

		case NSLayoutAttributeLeadingMargin:
		{
			return @"NSLayoutAttributeLeadingMargin";

			break;
		}

		case NSLayoutAttributeTrailingMargin:
		{
			return @"NSLayoutAttributeTrailingMargin";

			break;
		}

		case NSLayoutAttributeCenterXWithinMargins:
		{
			return @"NSLayoutAttributeCenterXWithinMargins";

			break;
		}

		case NSLayoutAttributeCenterYWithinMargins:
		{
			return @"NSLayoutAttributeCenterYWithinMargins";

			break;
		}

		case NSLayoutAttributeNotAnAttribute:
		{
			return @"NSLayoutAttributeNotAnAttribute";

			break;
		}

		default:
			break;
	}

	return @"NSLayoutAttributeNotAnAttribute";
}

@end
