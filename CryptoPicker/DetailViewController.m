//
//  DetailViewController.m
//  CryptoPicker
//
//  Created by Rich Humphrey on 1/6/15.
//  Copyright (c) 2015 Rich Humphrey. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

NSArray *keyOnePickers;
NSArray *keyTwoPickers;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    NSString *alphabetString = @"KRYPTOSABCDEFGHIJLMNQUVWXZ";
    _kryptosAlphabet = [[NSMutableArray alloc] initWithCapacity:[alphabetString length]+1];
    
    NSString *nullChar  = @"XX";
    
    [_kryptosAlphabet addObject:nullChar];
    
    for (int i=0; i < [alphabetString length]; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [alphabetString characterAtIndex:i]];
        [_kryptosAlphabet addObject:ichar];
    }

    // create the initial settings:
    
    
    
/*
    [_x1 selectRow:0 inComponent:0 animated:YES];
    [_x2 selectRow:1 inComponent:0 animated:YES];
    [_x3 selectRow:2 inComponent:0 animated:YES];
    [_x4 selectRow:3 inComponent:0 animated:YES];
    [_x5 selectRow:4 inComponent:0 animated:YES];
    [_x6 selectRow:5 inComponent:0 animated:YES];
    [_x7 selectRow:6 inComponent:0 animated:YES];
    [_x8 selectRow:7 inComponent:0 animated:YES];
*/
    
    keyOnePickers = [NSArray arrayWithObjects:_x1, _x2, _x3, _x4, _x5, _x6, _x7, _x8, _x9, _x10, _x11, _x12,nil];
    keyTwoPickers = [NSArray arrayWithObjects:_y1, _y2, _y3, _y4, _y5, _y6, _y7, _y8, _y9, _y10, _y11, _y12,nil];
    
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return _kryptosAlphabet.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return _kryptosAlphabet[row];
}

-(void) updateX:(UIPickerView *)pickerView toRow:(NSInteger)row {
    
    
}


#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    
    // need to be replaced with some sort of strategy pattern
    if (pickerView == _x1) {
        NSLog(@"x1 changed");
    }
    NSString *ciphertext = _ciphertext.text;
    
    _plaintext.text = [self decode:ciphertext];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
                                                replacementText:(NSString *)text
{
    
    NSLog(@"changed ciphertext");
    return true;
    
}
- (IBAction)pressedDecode:(id)sender {
    
    NSString *ciphertext = _ciphertext.text;
    
    _plaintext.text = [self decode:ciphertext];
    
}

-(NSString *) decode:(NSString *)ciphertext

{
   
    NSMutableString *keywordOne = [NSMutableString stringWithString:@""];
    NSMutableString *keywordTwo = [NSMutableString stringWithString:@""];
    NSMutableString *plaintext = [NSMutableString stringWithString:@""];
    
    // go through the array of uipickers and get each letter
    // concatenate into a string
    
    for (UIPickerView *picker in keyOnePickers) {
        NSString *pickerValue = [self pickerView:picker titleForRow:[picker selectedRowInComponent:0] forComponent:0];
        if ([pickerValue  isEqual: @"XX"]) {
            continue;
        } else {
            [keywordOne appendString:pickerValue];
        }
    }
    
    
    for (UIPickerView *picker in keyTwoPickers) {
        NSString *pickerValue = [self pickerView:picker titleForRow:[picker selectedRowInComponent:0] forComponent:0];
        if ([pickerValue  isEqual: @"XX"]) {
            continue;
        } else {
            [keywordTwo appendString:pickerValue];
        }
    }
    
    NSString *returnText = [NSString stringWithFormat:@"key1 = %@\nkey2 = %@", keywordOne, keywordTwo];
    
    // create the encode and decoder hashes
    
    NSString *alphabetString = @"KRYPTOSABCDEFGHIJLMNQUVWXZ";
    NSMutableArray *cipherAlphabet = [[NSMutableArray alloc] initWithCapacity:[alphabetString length]+1];
    
    NSMutableDictionary *alphabetMap = [NSMutableDictionary new];
    
    for (int i=0; i < [alphabetString length]; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [alphabetString characterAtIndex:i]];
        [alphabetMap setObject:[NSNumber numberWithInt:i] forKey:ichar];
        [cipherAlphabet addObject:ichar];
    }
    
    int keywordOneLength;
    
    if (keywordOne == NULL) {
        keywordOneLength = 0;
    } else {
        keywordOneLength =  (int)[keywordOne length];
    }
    

    // split the ciphertext by the length of keywordOne, then decode by each letter
    for (int i=0; i < [ciphertext length]; i++) {
        NSString *character  = [NSString stringWithFormat:@"%c", [ciphertext characterAtIndex:i]];
        int cipherTextIndex = [alphabetMap[character] intValue];
        int keywordIndex = i % keywordOneLength;
        NSString *keychar = [NSString stringWithFormat:@"%c", [keywordOne characterAtIndex:keywordIndex]];
        int keycharIndex = [alphabetMap[keychar] intValue];
        
        int plaintextindex = 26 + cipherTextIndex - keycharIndex;
        
        plaintextindex = plaintextindex % 26;
        
        NSString *plaintextChar = cipherAlphabet[plaintextindex];
        [plaintext appendString:plaintextChar];
    }
    
    NSLog(@"%@", returnText);
    
    return (plaintext);

    
}






@end
