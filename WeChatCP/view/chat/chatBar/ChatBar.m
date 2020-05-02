//
//  ChatBar.m
//  WeChatCP
//
//  Created by lwy on 2020/4/29.
//  Copyright © 2020 lwy. All rights reserved.
//

#import "ChatBar.h"
#import <Masonry/Masonry.h>
#import "Macro.h"

@interface ChatBar ()<UITextViewDelegate>
{
    UIImage *kVoiceImage;
    UIImage *kVoiceImageHL;
    UIImage *kEmojiImage;
    UIImage *kEmojiImageHL;
    UIImage *kMoreImage;
    UIImage *kMoreImageHL;
    UIImage *kKeyboardImage;
    UIImage *kKeyboardImageHL;
}

@property (nonatomic, strong) UIButton *modeButton;

@property (nonatomic, strong) UIButton *voiceButton;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UIButton *talkButton;

@property (nonatomic, strong) UIButton *emojiButton;

@property (nonatomic, strong) UIButton *moreButton;

@end

@implementation ChatBar

- (id)init
{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor colorWithRed:245/255.0 green:245/255.0 blue:247/255.0 alpha:1.0]];
        [self p_initImage];
        
        [self addSubview:self.modeButton];
        [self addSubview:self.voiceButton];
        [self addSubview:self.textView];
        [self addSubview:self.talkButton];
        [self addSubview:self.emojiButton];
        [self addSubview:self.moreButton];
        [self p_addMasonry];
        self.state = ChatBarStateInit;
    }
    return self;
}

#pragma mark - Private method
- (void)p_initImage
{
    kVoiceImage = [UIImage imageNamed:@"chat_toolbar_voice"];
    kVoiceImageHL = [UIImage imageNamed:@"chat_toolbar_voice_HL"];
    kEmojiImage = [UIImage imageNamed:@"chat_toolbar_emotion"];
    kEmojiImageHL = [UIImage imageNamed:@"chat_toolbar_emotion_HL"];
    kMoreImage = [UIImage imageNamed:@"chat_toolbar_more"];
    kMoreImageHL = [UIImage imageNamed:@"chat_toolbar_more_HL"];
    kKeyboardImage = [UIImage imageNamed:@"chat_toolbar_keyboard"];
    kKeyboardImageHL = [UIImage imageNamed:@"chat_toolbar_keyboard_HL"];
}

- (void)p_addMasonry
{
    [self.modeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self).mas_offset(-4);
        make.width.mas_equalTo(0);
    }];
    
    [self.voiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).mas_offset(-7);
        make.left.mas_equalTo(self.modeButton.mas_right).mas_offset(1);
        make.width.mas_equalTo(38);
    }];

    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(7);
        make.bottom.mas_equalTo(self).mas_offset(-7);
        make.left.mas_equalTo(self.voiceButton.mas_right).mas_offset(4);
        make.right.mas_equalTo(self.emojiButton.mas_left).mas_offset(-4);
        make.height.mas_equalTo(HEIGHT_CHATBAR_TEXTVIEW);
    }];

    [self.talkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.textView);
        make.size.mas_equalTo(self.textView);
    }];

    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.width.mas_equalTo(self.voiceButton);
        make.right.mas_equalTo(self).mas_offset(-1);
    }];

    [self.emojiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.width.mas_equalTo(self.voiceButton);
        make.right.mas_equalTo(self.moreButton.mas_left);
    }];
}

#pragma mark - Getter
- (UIButton *)modeButton
{
    if (_modeButton == nil) {
        _modeButton = [[UIButton alloc] init];
        [_modeButton setImage:[UIImage imageNamed:@"chat_toolbar_texttolist"] forState:UIControlStateNormal];
        [_modeButton setImage:[UIImage imageNamed:@"chat_toolbar_texttolist_HL"] forState:UIControlStateHighlighted];
//        [_modeButton addTarget:self action:@selector(modeButtonDown) forControlEvents:UIControlEventTouchUpInside];
    }
    return _modeButton;
}

- (UIButton *)voiceButton
{
    if (_voiceButton == nil) {
        _voiceButton = [[UIButton alloc] init];
        [_voiceButton setImage:kVoiceImage forState:UIControlStateNormal];
        [_voiceButton setImage:kVoiceImageHL forState:UIControlStateHighlighted];
        [_voiceButton addTarget:self action:@selector(voiceButtonDown) forControlEvents:UIControlEventTouchUpInside];
    }
    return _voiceButton;
}

- (void)voiceButtonDown
{
    NSLog(@"voiceButtonDown");
}

- (UITextView *)textView
{
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        [_textView setFont:[UIFont systemFontOfSize:16.0f]];
        [_textView setReturnKeyType:UIReturnKeySend];
        [_textView.layer setMasksToBounds:YES];
        [_textView.layer setBorderWidth:BORDER_WIDTH_1PX];
        [_textView.layer setBorderColor:[UIColor colorWithWhite:0.0 alpha:0.3].CGColor];
        [_textView.layer setCornerRadius:4.0f];
        [_textView setDelegate:self];
        [_textView setScrollsToTop:NO];
    }
    return _textView;
}

- (UIButton *)talkButton
{
    if (_talkButton == nil) {
        _talkButton = [[UIButton alloc] init];
        [_talkButton setHidden:YES];
//        __weak typeof(self) weakSelf = self;
//        [_talkButton setTouchBeginAction:^{
//            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(chatBarStartRecording:)]) {
//                [weakSelf.delegate chatBarStartRecording:weakSelf];
//            }
//        } willTouchCancelAction:^(BOOL cancel) {
//            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(chatBarWillCancelRecording:cancel:)]) {
//                [weakSelf.delegate chatBarWillCancelRecording:weakSelf cancel:cancel];
//            }
//        } touchEndAction:^{
//            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(chatBarFinishedRecoding:)]) {
//                [weakSelf.delegate chatBarFinishedRecoding:weakSelf];
//            }
//        } touchCancelAction:^{
//            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(chatBarDidCancelRecording:)]) {
//                [weakSelf.delegate chatBarDidCancelRecording:weakSelf];
//            }
//        }];
    }
    return _talkButton;
}

- (UIButton *)emojiButton
{
    if (_emojiButton == nil) {
        _emojiButton = [[UIButton alloc] init];
        [_emojiButton setImage:kEmojiImage forState:UIControlStateNormal];
        [_emojiButton setImage:kEmojiImageHL forState:UIControlStateHighlighted];
        [_emojiButton addTarget:self action:@selector(emojiButtonDown) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emojiButton;
}
- (void)emojiButtonDown
{
    NSLog(@"emojiButtonDown");
}
- (UIButton *)moreButton
{
    if (_moreButton == nil) {
        _moreButton = [[UIButton alloc] init];
        [_moreButton setImage:kMoreImage forState:UIControlStateNormal];
        [_moreButton setImage:kMoreImageHL forState:UIControlStateHighlighted];
        [_moreButton addTarget:self action:@selector(moreButtonDown) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}
- (void)moreButtonDown
{
    NSLog(@"moreButtonDown");
}

- (NSString *)curText
{
    return self.textView.text;
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    [self setActivity:YES];
    if (self.state != ChatBarStateKeyboard) {
        if (_delegate && [_delegate respondsToSelector:@selector(chatBar:changeStatusFrom:to:)]) {
            [self.delegate chatBar:self changeStatusFrom:self.state to:ChatBarStateKeyboard];
        }
        if (self.state == ChatBarStateEmoji) {
            [_emojiButton setImage:kEmojiImage forState:UIControlStateNormal];
            [_emojiButton setImage:kEmojiImageHL forState:UIControlStateHighlighted];
        } else if (self.state == ChatBarStateMore) {
            [_moreButton setImage:kMoreImage forState:UIControlStateNormal];
            [_moreButton setImage:kMoreImageHL forState:UIControlStateHighlighted];
        }
        self.state = ChatBarStateKeyboard;
    }
    NSLog(@"shouldbeginedit");
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]){
        [self sendCurrentText];
        return NO;
    }
    else if (textView.text.length > 0 && [text isEqualToString:@""]) {       // delete
        if ([textView.text characterAtIndex:range.location] == ']') {
            NSUInteger location = range.location;
            NSUInteger length = range.length;
            while (location != 0) {
                location --;
                length ++ ;
                char c = [textView.text characterAtIndex:location];
                if (c == '[') {
                    textView.text = [textView.text stringByReplacingCharactersInRange:NSMakeRange(location, length) withString:@""];
                    [self p_reloadTextViewWithAnimation:YES];
                    return NO;
                }
                else if (c == ']') {
                    return YES;
                }
            }
        }
    }
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self p_reloadTextViewWithAnimation:YES];
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self p_reloadTextViewWithAnimation:YES];
}

- (void)setActivity:(BOOL)activity
{
    _activity = activity;
    if (activity) {
        [self.textView setTextColor:[UIColor blackColor]];
    } else {
        [self.textView setTextColor:[UIColor grayColor]];
    }
}
#pragma mark - Private Methods
- (void)p_reloadTextViewWithAnimation:(BOOL)animation
{
    CGFloat textHeight = [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, MAXFLOAT)].height;
    CGFloat height = textHeight > HEIGHT_CHATBAR_TEXTVIEW ? textHeight : HEIGHT_CHATBAR_TEXTVIEW;
    height = textHeight <= HEIGHT_MAX_CHATBAR_TEXTVIEW ? textHeight : HEIGHT_MAX_CHATBAR_TEXTVIEW;
    [self.textView setScrollEnabled:textHeight > height];
    if (height != self.textView.frame.size.height) {
        if (animation) {
            [UIView animateWithDuration:0.2 animations:^{
                [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(height);
                }];
                if (self.superview) {
                    [self.superview layoutIfNeeded];
                }
                if (self.delegate && [self.delegate respondsToSelector:@selector(chatBar:didChangeTextViewHeight:)]) {
                    [self.delegate chatBar:self didChangeTextViewHeight:self.textView.frame.size.height];
                }
            } completion:^(BOOL finished) {
                if (textHeight > height) {
                    [self.textView setContentOffset:CGPointMake(0, textHeight - height) animated:YES];
                }
                if (self.delegate && [self.delegate respondsToSelector:@selector(chatBar:didChangeTextViewHeight:)]) {
                    [self.delegate chatBar:self didChangeTextViewHeight:height];
                }
            }];
        }
        else {
            [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height);
            }];
            if (self.superview) {
                [self.superview layoutIfNeeded];
            }
            if (self.delegate && [self.delegate respondsToSelector:@selector(chatBar:didChangeTextViewHeight:)]) {
                [self.delegate chatBar:self didChangeTextViewHeight:height];
            }
            if (textHeight > height) {
                [self.textView setContentOffset:CGPointMake(0, textHeight - height) animated:YES];
            }
        }
    }
    else if (textHeight > height) {
        if (animation) {
            CGFloat offsetY = self.textView.contentSize.height - self.textView.frame.size.height;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.textView setContentOffset:CGPointMake(0, offsetY) animated:YES];
            });
        }
        else {
            [self.textView setContentOffset:CGPointMake(0, self.textView.contentSize.height - self.textView.frame.size.height) animated:NO];
        }
    }
}

- (BOOL)resignFirstResponder
{
//    [self.moreButton setImage:kMoreImage imageHL:kMoreImageHL];
//    [self.emojiButton setImage:kEmojiImage imageHL:kEmojiImageHL];
    if (self.state == ChatBarStateKeyboard) {
        [self.textView resignFirstResponder];
        self.state = ChatBarStateInit;
        if (self.delegate && [self.delegate respondsToSelector:@selector(chatBar:changeStatusFrom:to:)]) {
            [self.delegate chatBar:self changeStatusFrom:self.state to:ChatBarStateInit];
        }
    }
    return [super resignFirstResponder];
}

#pragma mark - Public Methods
- (void)sendCurrentText
{
    if (self.textView.text.length > 0) {     // send Text
        if (_delegate && [_delegate respondsToSelector:@selector(chatBar:sendText:)]) {
            [_delegate chatBar:self sendText:self.textView.text];
        }
    }
    [self.textView setText:@""];
    [self p_reloadTextViewWithAnimation:YES];
}
@end
