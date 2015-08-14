//
//  BUYProductVariantCell.m
//  Mobile Buy SDK
//
//  Created by David Muzi on 2015-07-06.
//  Copyright (c) 2015 Shopify Inc. All rights reserved.
//

#import "BUYProductVariantCell.h"
#import "BUYVariantOptionView.h"
#import "BUYProductVariant.h"
#import "BUYOptionValue.h"
#import "BUYImageKit.h"

@interface BUYProductVariantCell ()
@property (nonatomic, strong) BUYVariantOptionView *optionView1;
@property (nonatomic, strong) BUYVariantOptionView *optionView2;
@property (nonatomic, strong) BUYVariantOptionView *optionView3;
@property (nonatomic, strong) NSArray *disclosureConstraint;
@property (nonatomic, strong) NSArray *noDisclosureConstraint;
@property (nonatomic, strong) UIImageView *disclosureIndicatorImageView;
@property (nonatomic, strong) BUYTheme *theme;
@end

@implementation BUYProductVariantCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		self.layoutMargins = UIEdgeInsetsMake(12, self.layoutMargins.left, 12, self.layoutMargins.right);

		UIView *backgroundView = [[UIView alloc] init];
		[self setSelectedBackgroundView:backgroundView];
		
		_optionView1 = [[BUYVariantOptionView alloc] init];
		_optionView1.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_optionView1];
		
		_optionView2 = [[BUYVariantOptionView alloc] init];
		_optionView2.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_optionView2];
		
		_optionView3 = [[BUYVariantOptionView alloc] init];
		_optionView3.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_optionView3];
		
		_disclosureIndicatorImageView = [[UIImageView alloc] init];
		_disclosureIndicatorImageView.translatesAutoresizingMaskIntoConstraints = NO;
		[self.contentView addSubview:_disclosureIndicatorImageView];
		
		NSDictionary *views = NSDictionaryOfVariableBindings(_optionView1, _optionView2, _optionView3, _disclosureIndicatorImageView);
		
		self.disclosureConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_optionView1]-(16)-[_optionView2]-(16)-[_optionView3]-(>=8)-[_disclosureIndicatorImageView]-|" options:0 metrics:nil views:views];
		self.noDisclosureConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_optionView1]-(16)-[_optionView2]-(16)-[_optionView3]-(>=8)-[_disclosureIndicatorImageView]-|" options:0 metrics:nil views:views];
		
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_optionView1]-|" options:0 metrics:nil views:views]];
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_optionView2]-|" options:0 metrics:nil views:views]];
		[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_optionView3]-|" options:0 metrics:nil views:views]];
		
		[self.contentView addConstraint: [NSLayoutConstraint constraintWithItem:_disclosureIndicatorImageView
																	  attribute:NSLayoutAttributeCenterY
																	  relatedBy:NSLayoutRelationEqual
																		 toItem:_disclosureIndicatorImageView.superview
																	  attribute:NSLayoutAttributeCenterY
																	 multiplier:1.0f
																	   constant:0.0f]];
	}

	return self;
}

- (void)setProductVariant:(BUYProductVariant *)productVariant
{
	_productVariant = productVariant;

	NSArray *productOptions = productVariant.options;
	
	switch (productVariant.options.count) {
		case 3:
			[self.optionView3 setTextForOptionValue:productOptions[2]];
			[self.optionView2 setTextForOptionValue:productOptions[1]];
			[self.optionView1 setTextForOptionValue:productOptions[0]];
			break;
		
		case 2:
			[self.optionView3 setTextForOptionValue:nil];
			[self.optionView2 setTextForOptionValue:productOptions[1]];
			[self.optionView1 setTextForOptionValue:productOptions[0]];
			break;
			
		case 1:
			[self.optionView3 setTextForOptionValue:nil];
			[self.optionView2 setTextForOptionValue:nil];
			[self.optionView1 setTextForOptionValue:productOptions[0]];
			break;
		
		default:
			break;
		}
}

-(void)setAccessoryType:(UITableViewCellAccessoryType)accessoryType
{
	self.disclosureIndicatorImageView.hidden = accessoryType != UITableViewCellAccessoryDisclosureIndicator;
	if (accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
		self.selectionStyle = UITableViewCellSelectionStyleDefault;
		[NSLayoutConstraint activateConstraints:self.disclosureConstraint];
		[NSLayoutConstraint deactivateConstraints:self.noDisclosureConstraint];
	} else {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		[NSLayoutConstraint deactivateConstraints:self.disclosureConstraint];
		[NSLayoutConstraint activateConstraints:self.noDisclosureConstraint];
	}
}

- (void)setTheme:(BUYTheme *)theme
{
	_theme = theme;
	switch (theme.style) {
		case BUYThemeStyleDark:
			self.backgroundColor = BUY_RGB(26, 26, 26);
			self.selectedBackgroundView.backgroundColor = BUY_RGB(60, 60, 60);
			break;
		case BUYThemeStyleLight:
			self.backgroundColor = [UIColor whiteColor];
			self.selectedBackgroundView.backgroundColor = BUY_RGB(242, 242, 242);
			break;
		default:
			break;
	}
	_disclosureIndicatorImageView.image = [BUYImageKit imageOfDisclosureIndicatorImageWithFrame:CGRectMake(0, 0, 10, 16) color:theme.style == BUYThemeStyleDark ? BUY_RGB(76, 76, 76) : BUY_RGB(191, 191, 191)];
	
	[self.optionView1 setTheme:theme];
	[self.optionView2 setTheme:theme];
	[self.optionView3 setTheme:theme];
}

@end
