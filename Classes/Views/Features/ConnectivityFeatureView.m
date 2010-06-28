//
//  ConnectivityFeatureView.m
//  Digital 2.0
//
//  Created by Adrian on 6/21/10.
//  Copyright 2010 akosma software. All rights reserved.
//

#import "ConnectivityFeatureView.h"

@interface ConnectivityFeatureView ()

- (void)loadWebsite:(NSString *)urlString;
- (void)shareViaEmail;

@end



@implementation ConnectivityFeatureView

@synthesize mainView = _mainView;
@synthesize twitterImageView = _twitterImageView;
@synthesize facebookImageView = _facebookImageView;
@synthesize safariImageView = _safariImageView;
@synthesize mailImageView = _mailImageView;
@synthesize webView = _webView;
@synthesize descriptionLabel = _descriptionLabel;
@synthesize titleLabel = _titleLabel;

- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        self.requiresNetwork = YES;

        [[NSBundle mainBundle] loadNibNamed:@"ConnectivityFeatureView"
                                      owner:self 
                                    options:nil];
        
        [self addSubview:self.mainView];
        [self loadWebsite:@"http://www.twitter.com/"];
        
        UITapGestureRecognizer *recognizer1 = [[[UITapGestureRecognizer alloc] initWithTarget:self 
                                                                                       action:@selector(touched:)] autorelease];
        UITapGestureRecognizer *recognizer2 = [[[UITapGestureRecognizer alloc] initWithTarget:self 
                                                                                       action:@selector(touched:)] autorelease];
        UITapGestureRecognizer *recognizer3 = [[[UITapGestureRecognizer alloc] initWithTarget:self 
                                                                                       action:@selector(touched:)] autorelease];
        UITapGestureRecognizer *recognizer4 = [[[UITapGestureRecognizer alloc] initWithTarget:self 
                                                                                       action:@selector(touched:)] autorelease];
        
        [self.twitterImageView addGestureRecognizer:recognizer1];
        [self.facebookImageView addGestureRecognizer:recognizer2];
        [self.safariImageView addGestureRecognizer:recognizer3];
        [self.mailImageView addGestureRecognizer:recognizer4];
    }
    return self;
}

- (void)dealloc 
{
    self.mainView = nil;
    self.twitterImageView = nil;
    self.facebookImageView = nil;
    self.safariImageView = nil;
    self.mailImageView = nil;
    self.webView = nil;
    self.descriptionLabel = nil;
    self.titleLabel = nil;

    [super dealloc];
}

#pragma mark -
#pragma mark UIGestureRecognizer handlers

- (void)touched:(UITapGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        if (recognizer.view == self.twitterImageView)
        {
            [self loadWebsite:@"http://twitter.com/"];
        }
        else if (recognizer.view == self.facebookImageView)
        {
            [self loadWebsite:@"http://facebook.com/"];
        }
        else if (recognizer.view == self.safariImageView)
        {
            [self loadWebsite:@"http://www.moserdesign.ch/"];
        }
        else if (recognizer.view == self.mailImageView)
        {
            [self shareViaEmail];
        }
    }
}

#pragma mark -
#pragma mark Overridden methods

- (void)setOrientation:(UIInterfaceOrientation)newOrientation
{
    [super setOrientation:newOrientation];
    
    CGRect titleLabelFrame = CGRectMake(20.0, 45.0, 104.0, 23.0);
    CGRect twitterImageViewFrame = CGRectMake(20.0, 105.0, 78.0, 78.0);
    CGRect facebookImageViewFrame = CGRectMake(20.0, 191.0, 78.0, 78.0);
    CGRect safariImageViewFrame = CGRectMake(20.0, 277.0, 78.0, 78.0);
    CGRect mailImageViewFrame = CGRectMake(20.0, 363.0, 78.0, 78.0);
    CGRect webViewFrame = CGRectMake(106.0, 105.0, 898.0, 336.0);
    CGRect descriptionLabelFrame = CGRectMake(20.0, 449.0, 984.0, 50.0);
    
    if (UIInterfaceOrientationIsPortrait(newOrientation))
    {
        titleLabelFrame = CGRectMake(20.0, 45.0, 104.0, 23.0);
        twitterImageViewFrame = CGRectMake(20.0, 105.0, 78.0, 78.0);
        facebookImageViewFrame = CGRectMake(106.0, 105.0, 78.0, 78.0);
        safariImageViewFrame = CGRectMake(192.0, 105.0, 78.0, 78.0);
        mailImageViewFrame = CGRectMake(278.0, 105.0, 78.0, 78.0);
        webViewFrame = CGRectMake(20.0, 191.0, 728.0, 504.0);
        descriptionLabelFrame = CGRectMake(20.0, 703.0, 728.0, 67.0);
    }
    
    self.titleLabel.frame = titleLabelFrame;
    self.twitterImageView.frame = twitterImageViewFrame;
    self.facebookImageView.frame = facebookImageViewFrame;
    self.safariImageView.frame = safariImageViewFrame;
    self.mailImageView.frame = mailImageViewFrame;
    self.webView.frame = webViewFrame;
    self.descriptionLabel.frame = descriptionLabelFrame;
}

#pragma mark -
#pragma mark Private methods

- (void)loadWebsite:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)shareViaEmail
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ConnectivityFeatureViewOpenShareByEmailNotification 
                                                        object:self];
}

@end
