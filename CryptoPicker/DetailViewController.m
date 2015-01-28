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
    _kryptosAlphabet = [[NSMutableArray alloc] initWithCapacity:[alphabetString length]];
    
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
    
    if (pickerView == _x1) {
        NSLog(@"x1 changed");
        // equations:
        // x1 + y2 = 20
        // x6 + y2 = 9
        
        //[DetailViewController updateX:pickerView toRow:row];
        
        int y2row = ((20 - row) + 26) % 26;
        [_y2 selectRow:y2row inComponent:0 animated:YES];
        int x6row = ((9 - y2row) + 26) % 26;
        [_x6 selectRow:x6row inComponent:0 animated:YES];
        
        // x1 + y5 = 17
        int y5row = ((17 - row) + 26) % 26;
        [_y5 selectRow:y5row inComponent:0 animated:YES];
        int x8row = ((7 - y5row) + 26) % 26;
        [_x8 selectRow:x8row inComponent:0 animated:YES];
        int y8row = ((11 - x8row) + 26) % 26;
        [_y8 selectRow:y8row inComponent:0 animated:YES];
        int x7row = ((8 - y8row) + 26) % 26;
        [_x7 selectRow:x7row inComponent:0 animated:YES];
        
        int x2row = ((2 - y2row) + 26) % 26;
        [_x2 selectRow:x2row inComponent:0 animated:YES];
        int y9row = ((20 - x2row) + 26) % 26;
        [_y9 selectRow:y9row inComponent:0 animated:YES];
        int x3row = ((5 - y9row) + 26) % 26;
        [_x3 selectRow:x3row inComponent:0 animated:YES];
        
    } else if (pickerView == _x2) {
        NSLog(@"x2 changed");
        // equations:
        // x2 + y9 = 0
        // x3 + y9 = 5
        int y9row = ((0 - row) + 26) % 26;
        [_y9 selectRow:y9row inComponent:0 animated:YES];
        int x3row = ((5 - y9row) + 26) % 26;
        [_x3 selectRow:x3row inComponent:0 animated:YES];
        
        // x2 + y2 = 2
        int y2row = ((2 - row) + 26) % 26;
        [_y2 selectRow:y2row inComponent:0 animated:YES];
        int x1row = ((20 - y2row) + 26) % 26;
        [_x1 selectRow:x1row inComponent:0 animated:YES];
        int x6row = ((9 - y2row) + 26) % 26;
        [_x6 selectRow:x6row inComponent:0 animated:YES];
        
        int y5row = ((17 - x1row) + 26) % 26;
        [_y5 selectRow:y5row inComponent:0 animated:YES];
        int x8row = ((7 - y5row) + 26) % 26;
        [_x8 selectRow:x8row inComponent:0 animated:YES];
        int y8row = ((11 - x8row) + 26) % 26;
        [_y8 selectRow:y8row inComponent:0 animated:YES];
        int x7row = ((8 - y8row) + 26) % 26;
        [_x7 selectRow:x7row inComponent:0 animated:YES];
        
    } else if (pickerView == _x3) {
        NSLog(@"x3 changed");
        // x3 + y9 = 5
        // x2 + y9 = 0
        int y9row = ((5 - row) + 26) % 26;
        [_y9 selectRow:y9row inComponent:0 animated:YES];
        int x2row = ((0 - y9row) + 26) % 26;
        [_x2 selectRow:x2row inComponent:0 animated:YES];
    
        int y2row = ((2 - x2row) + 26) % 26;
        [_y2 selectRow:y2row inComponent:0 animated:YES];
        int x1row = ((20 - y2row) + 26) % 26;
        [_x1 selectRow:x1row inComponent:0 animated:YES];
        int x6row = ((9 - y2row) + 26) % 26;
        [_x6 selectRow:x6row inComponent:0 animated:YES];
        
        int y5row = ((17 - x1row) + 26) % 26;
        [_y5 selectRow:y5row inComponent:0 animated:YES];
        int x8row = ((7 - y5row) + 26) % 26;
        [_x8 selectRow:x8row inComponent:0 animated:YES];
        int y8row = ((11 - x8row) + 26) % 26;
        [_y8 selectRow:y8row inComponent:0 animated:YES];
        int x7row = ((8 - y8row) + 26) % 26;
        [_x7 selectRow:x7row inComponent:0 animated:YES];

    } else if (pickerView == _x4) {
        NSLog(@"x4 changed");
        // x4 + y6 =15
        int y6row = ((15 - row) + 26) % 26;
        [_y6 selectRow:y6row inComponent:0 animated:YES];
    } else if (pickerView == _x5) {
        NSLog(@"x5 changed");
        // x5 + y3 =11
        int y3row = ((11 - row) + 26) % 26;
        [_y3 selectRow:y3row inComponent:0 animated:YES];
    } else if (pickerView == _x6) {
        NSLog(@"x6 changed");
        // x6 + y2 = 9
        // X1 + y2 = 20
        int y2row = ((9 - row) + 26) % 26;
        [_y2 selectRow:y2row inComponent:0 animated:YES];
        int x1row = ((20 - y2row) + 26) % 26;
        [_x1 selectRow:x1row inComponent:0 animated:YES];
        
        int y5row = ((17 - x1row) + 26) % 26;
        [_y5 selectRow:y5row inComponent:0 animated:YES];
        int x8row = ((7 - y5row) + 26) % 26;
        [_x8 selectRow:x8row inComponent:0 animated:YES];
        int y8row = ((11 - x8row) + 26) % 26;
        [_y8 selectRow:y8row inComponent:0 animated:YES];
        int x7row = ((8 - y8row) + 26) % 26;
        [_x7 selectRow:x7row inComponent:0 animated:YES];
        
        // x2 + y2 = 2
        int x2row = ((2 - y2row) + 26) % 26;
        [_x2 selectRow:x2row inComponent:0 animated:YES];
        int y9row = ((0 - x2row) + 26) % 26;
        [_y9 selectRow:y9row inComponent:0 animated:YES];
        int x3row = ((5 - y9row) + 26) % 26;
        [_x3 selectRow:x3row inComponent:0 animated:YES];

    } else if (pickerView == _x7) {
        NSLog(@"x7 changed");
        // equations:
        // x7 + y8 = 8
        // x8 + y8 = 11
        // x8 + y5 = 7
        int y8row = ((8 - row) + 26) % 26;
        [_y8 selectRow:y8row inComponent:0 animated:YES];
        int x8row = ((11 - y8row) + 26) % 26;
        [_x8 selectRow:x8row inComponent:0 animated:YES];
        int y5row = ((7 - x8row) + 26) % 26;
        [_y5 selectRow:y5row inComponent:0 animated:YES];

        int x1row = ((17 - y5row) + 26) % 26;
        [_x1 selectRow:x1row inComponent:0 animated:YES];
        
        int y2row = ((20 - x1row) + 26) % 26;
        [_y2 selectRow:y2row inComponent:0 animated:YES];
        int x6row = ((9 - y2row) + 26) % 26;
        [_x6 selectRow:x6row inComponent:0 animated:YES];
        
        int x2row = ((2 - y2row) + 26) % 26;
        [_x2 selectRow:x2row inComponent:0 animated:YES];
        int y9row = ((0 - x2row) + 26) % 26;
        [_y9 selectRow:y9row inComponent:0 animated:YES];
        int x3row = ((5 - y9row) + 26) % 26;
        [_x3 selectRow:x3row inComponent:0 animated:YES];
    
    } else if (pickerView == _x8) {
        NSLog(@"x8 changed");
        // equations:
        // x7 + y8 = 8
        // x8 + y8 = 11
        // x8 + y5 = 7
        int y8row = ((11 - row) + 26) % 26;
        [_y8 selectRow:y8row inComponent:0 animated:YES];
        int x7row = ((8 - y8row) + 26) % 26;
        [_x7 selectRow:x7row inComponent:0 animated:YES];
        int y5row = ((7 - row) + 26) % 26;
        [_y5 selectRow:y5row inComponent:0 animated:YES];
        int x1row = ((17 - y5row) + 26) % 26;
        [_x1 selectRow:x1row inComponent:0 animated:YES];
        
        int y2row = ((20 - x1row) + 26) % 26;
        [_y2 selectRow:y2row inComponent:0 animated:YES];
        int x6row = ((9 - y2row) + 26) % 26;
        [_x6 selectRow:x6row inComponent:0 animated:YES];
        
        int x2row = ((2 - y2row) + 26) % 26;
        [_x2 selectRow:x2row inComponent:0 animated:YES];
        int y9row = ((0 - x2row) + 26) % 26;
        [_y9 selectRow:y9row inComponent:0 animated:YES];
        int x3row = ((5 - y9row) + 26) % 26;
        [_x3 selectRow:x3row inComponent:0 animated:YES];
        
    } else if (pickerView == _y1) {
        NSLog(@"y1 changed");
    } else if (pickerView == _y2) {
        NSLog(@"y2 changed");
        // equations:
        // x1 + y2 = 20
        // x6 + y2 = 9
        int x1row = ((20 - row) + 26) % 26;
        [_x1 selectRow:x1row inComponent:0 animated:YES];
        int x6row = ((9 - row) + 26) % 26;
        [_x6 selectRow:x6row inComponent:0 animated:YES];
        
        // x2 + y2 = 2
        int x2row = ((2 - row) + 26) % 26;
        [_x2 selectRow:x2row inComponent:0 animated:YES];
        int y9row = ((0 - x2row) + 26) % 26;
        [_y9 selectRow:y9row inComponent:0 animated:YES];
        int x3row = ((5 - y9row) + 26) % 26;
        [_x3 selectRow:x3row inComponent:0 animated:YES];
        
        // x1 + y5 = 17
        int y5row = ((17 - x1row) + 26) % 26;
        [_y5 selectRow:y5row inComponent:0 animated:YES];
        // x8 + y5 = 7
        int x8row = ((7 - y5row) + 26) % 26;
        [_x8 selectRow:x8row inComponent:0 animated:YES];
        int y8row = ((11 - x8row) + 26) % 26;
        [_y8 selectRow:y8row inComponent:0 animated:YES];
        int x7row = ((8 - y8row) + 26) % 26;
        [_x7 selectRow:x7row inComponent:0 animated:YES];
        
        
        
    } else if (pickerView == _y3) {
        NSLog(@"y3 changed");
        // equations:
        // x5 + y3 = 11
        int x5row = ((11 - row) + 26) % 26;
        [_x5 selectRow:x5row inComponent:0 animated:YES];
    } else if (pickerView == _y4) {
        NSLog(@"y4 changed");
    } else if (pickerView == _y5) {
        NSLog(@"y5 changed");
        // x8 + y5 = 7
        // x8 + y8 = 11
        // x7 + y8 = 8
        int x8row = ((7 - row) + 26) % 26;
        [_x8 selectRow:x8row inComponent:0 animated:YES];
        int y8row = ((11 - x8row) + 26) % 26;
        [_y8 selectRow:y8row inComponent:0 animated:YES];
        int x7row = ((8 - y8row) + 26) % 26;
        [_x7 selectRow:x7row inComponent:0 animated:YES];
    } else if (pickerView == _y6) {
        NSLog(@"y6 changed");
        // x4 + y6 = 15
        int x4row = ((15 - row) + 26) % 26;
        [_x4 selectRow:x4row inComponent:0 animated:YES];
    } else if (pickerView == _y7) {
        NSLog(@"y7 changed");
    } else if (pickerView == _y8) {
        NSLog(@"y8 changed");
        // x8 + y8 = 11
        // x7 + y8 = 8
        // x8 + y5 = 7
        int x8row = ((11 - row) + 26) % 26;
        [_x8 selectRow:x8row inComponent:0 animated:YES];
        int x7row = ((8 - row) + 26) % 26;
        [_x7 selectRow:x7row inComponent:0 animated:YES];
        int y5row = ((7 - x8row) + 26) % 26;
        [_y5 selectRow:y5row inComponent:0 animated:YES];
    } else if (pickerView == _y9) {
        NSLog(@"y9 changed");
        // x2 + y9 = 0
        // x3 + y9 = 5
        int x2row = ((0 - row) + 26) % 26;
        [_x2 selectRow:x2row inComponent:0 animated:YES];
        int x3row = ((5 - row) + 26) % 26;
        [_x3 selectRow:x3row inComponent:0 animated:YES];
    } else if (pickerView == _y10) {
        NSLog(@"y10 changed");
    }
    
}

@end
