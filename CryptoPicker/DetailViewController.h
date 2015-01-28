//
//  DetailViewController.h
//  CryptoPicker
//
//  Created by Rich Humphrey on 1/6/15.
//  Copyright (c) 2015 Rich Humphrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    
    
}

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (strong, nonatomic) NSMutableArray *kryptosAlphabet;
@property (weak, nonatomic) IBOutlet UIPickerView *x1;
@property (weak, nonatomic) IBOutlet UIPickerView *x2;
@property (weak, nonatomic) IBOutlet UIPickerView *x3;
@property (weak, nonatomic) IBOutlet UIPickerView *x4;
@property (weak, nonatomic) IBOutlet UIPickerView *x5;
@property (weak, nonatomic) IBOutlet UIPickerView *x6;
@property (weak, nonatomic) IBOutlet UIPickerView *x7;
@property (weak, nonatomic) IBOutlet UIPickerView *x8;
@property (weak, nonatomic) IBOutlet UIPickerView *y1;
@property (weak, nonatomic) IBOutlet UIPickerView *y2;
@property (weak, nonatomic) IBOutlet UIPickerView *y3;
@property (weak, nonatomic) IBOutlet UIPickerView *y4;
@property (weak, nonatomic) IBOutlet UIPickerView *y5;
@property (weak, nonatomic) IBOutlet UIPickerView *y6;
@property (weak, nonatomic) IBOutlet UIPickerView *y7;
@property (weak, nonatomic) IBOutlet UIPickerView *y8;
@property (weak, nonatomic) IBOutlet UIPickerView *y9;
@property (weak, nonatomic) IBOutlet UIPickerView *y10;

-(void) updateX:(UIPickerView *)pickerView toRow:(NSInteger)row;

@end

