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
    
    //NSString *ciphertext = _ciphertext.text;
    //_plaintext.text = [self decode:ciphertext];
    
    _plaintext.text = _ciphertext.text;
    
    _plaintext.text = [[self transpose:_plaintext.text byXChars:24 padAtEnd:true clockwise:true] mutableCopy];
    _plaintext.text = [[self transpose:_plaintext.text byXChars:8 padAtEnd:true clockwise:true] mutableCopy];
    
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
    
    int keywordOneLength = (int)[keywordOne length];
    
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

-(NSString *) transpose:(NSString *)ciphertext byXChars:(int)xChars padAtEnd:(bool)atEnd clockwise:(bool)clockwise {
    
    
    // basically we take string ciphertext and put into rows xChars wide then turn left or right and read from
    // the side
    
    
    NSMutableString *CT = [ciphertext mutableCopy];
    
    
    int ciphertextLength = (int)[ciphertext length];
    
    int numLettersToPad = xChars - (ciphertextLength % xChars);
    
    // hack!
    if (numLettersToPad == xChars) {numLettersToPad = 0;}
    
    int numStrings = (int)(ciphertextLength / xChars);
    
    //NSLog(@"number of rows: %d", numStrings);

    // either pad at beginning or end
    
    if (numLettersToPad != 0) {
        
        numStrings++;
        
        NSMutableString *padString = [NSMutableString stringWithString:@""];
        for (int i=0; i < numLettersToPad; i++) {
            [padString appendString:@"."];
        }
        
        if (atEnd) {
            //[CT stringByPaddingToLength:(ciphertextLength + numLettersToPad) withString:@"X" startingAtIndex:0];
        
            [CT insertString:padString atIndex:ciphertextLength];
            
        } else {
            [CT insertString:padString atIndex:0];
        }
    }
    
    // create an array of NSMutableStrings
    NSMutableArray *stringArrays = [NSMutableArray new];
    
    for (int i=0; i < numStrings; i++) {
        
        [stringArrays addObject:[NSMutableString stringWithString:@""]];
        
    }
    
    // split the ciphertext into arrays by xChar width, then read off from bottom left
    int arrayIndex = -1;
    for (int i=0; i < [CT length]; i++) {
        if ((i % xChars) == 0) {
            arrayIndex++;
        }
        [[stringArrays objectAtIndex:arrayIndex] appendString:[NSString stringWithFormat:@"%c", [CT characterAtIndex:i]]];
    }
    
    NSMutableString *transposedString = [NSMutableString stringWithString:@""];
    
    
    for (int j = 0; j < xChars; j++) {
        for (int i = numStrings - 1; i >= 0; i--) {
            [transposedString appendString:[[stringArrays objectAtIndex:i] substringWithRange:NSMakeRange(j,1)]];
        }
    }
    
    
    NSLog(@"transpose string: %@", [stringArrays objectAtIndex:0]);
    NSLog(@"transpose string: %@", [stringArrays objectAtIndex:1]);
    NSLog(@"transpose string: %@", [stringArrays objectAtIndex:2]);
    
    NSLog(@"transposed string final: %@", transposedString);
    
    
    return (transposedString);
    
}





@end
