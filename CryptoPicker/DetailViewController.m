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
NSString *alphabetString = @"";
int cribMatrix[13][13];
bool xkeyMask[13];
bool ykeyMask[13];

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
    [_x1 selectRow:8 inComponent:0 animated:YES];
    [_x2 selectRow:9 inComponent:0 animated:YES];
    [_x3 selectRow:7 inComponent:0 animated:YES];
    [_x4 selectRow:10 inComponent:0 animated:YES];
    [_x5 selectRow:16 inComponent:0 animated:YES];
    [_x6 selectRow:7 inComponent:0 animated:YES];
    [_x7 selectRow:7 inComponent:0 animated:YES];
    [_x8 selectRow:8 inComponent:0 animated:YES];

    [_y1 selectRow:5 inComponent:0 animated:YES];
    [_y2 selectRow:12 inComponent:0 animated:YES];
    [_y3 selectRow:7 inComponent:0 animated:YES];
    [_y4 selectRow:5 inComponent:0 animated:YES];
    */
    
    [_x1 selectRow:1 inComponent:0 animated:YES];
    [_y1 selectRow:1 inComponent:0 animated:YES];
    
    [_x2 selectRow:1 inComponent:0 animated:YES];
    [_x3 selectRow:1 inComponent:0 animated:YES];
    [_x4 selectRow:1 inComponent:0 animated:YES];
    [_x5 selectRow:1 inComponent:0 animated:YES];
    [_x6 selectRow:1 inComponent:0 animated:YES];
    [_x7 selectRow:1 inComponent:0 animated:YES];
    [_x8 selectRow:1 inComponent:0 animated:YES];

    [_y2 selectRow:1 inComponent:0 animated:YES];
    [_y3 selectRow:1 inComponent:0 animated:YES];
    [_y4 selectRow:1 inComponent:0 animated:YES];
    [_y5 selectRow:1 inComponent:0 animated:YES];
    [_y6 selectRow:1 inComponent:0 animated:YES];
    [_y7 selectRow:1 inComponent:0 animated:YES];
    [_y8 selectRow:1 inComponent:0 animated:YES];
    [_y9 selectRow:1 inComponent:0 animated:YES];
    [_y10 selectRow:1 inComponent:0 animated:YES];
    
    
    keyOnePickers = [NSArray arrayWithObjects:_x1, _x2, _x3, _x4, _x5, _x6, _x7, _x8, _x9, _x10, _x11, _x12,nil];
    keyTwoPickers = [NSArray arrayWithObjects:_y1, _y2, _y3, _y4, _y5, _y6, _y7, _y8, _y9, _y10, _y11, _y12,nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setAlphabetString:(NSString *)alphabet {
    
    alphabetString = alphabet;
    
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

-(void) changePickers:(NSString *)pickerRow pickerCol:(int) position {
    
    
    int thisPickerPosition;

    /*
    for (int i = 0; i < 12; i++) {
        for (int j = 0; j < 12; j++) {
            NSLog(@"%d", cribMatrix[i][j]);
        }
    }
    */
    
    if ([pickerRow isEqualToString:@"x"]) {
        thisPickerPosition = (int)[keyOnePickers[position - 1] selectedRowInComponent:0] - 1;
        NSLog(@"Changed picker %@ - %d to position %d", pickerRow, position, thisPickerPosition );

        xkeyMask[position] = false; //only do it once
        // then go through the y pickers that are not masked
        // change them
        for (int i = 1; i < 13; i++) {
        
            if ((cribMatrix[position][i] != -1) && (ykeyMask[i])) {
                
                NSLog(@"Update Y - %d  so that X - %d and it add to - %d", i, position, cribMatrix[position][i]);
                // find the positon of x-position
                // add cribMatrix to it and mod by 26
                NSUInteger newRow = ((26 + (cribMatrix[position][i] - thisPickerPosition)) % 26) + 1;
                
                NSLog(@"updating ypicker %d to %zd", i, newRow);
                [keyTwoPickers[i - 1] selectRow:newRow inComponent:0 animated:true];
                [self changePickers:@"y" pickerCol:i];
                
                
            }
        
        
        }
        
        
        
    } else if ([pickerRow isEqualToString:@"y"]) {

        thisPickerPosition = (int)[keyTwoPickers[position - 1] selectedRowInComponent:0] - 1;
        NSLog(@"Changed picker %@ - %d to position %d", pickerRow, position, thisPickerPosition );

        ykeyMask[position] = false;  // only do it once
        // then go through the x pickers that are not masked
        // change them
        for (int i = 1; i < 13; i++) {

            if ((cribMatrix[i][position] != -1) && (xkeyMask[i])) {
                
                NSLog(@"Update X - %d  so that Y - %d and it add to - %d", i, position, cribMatrix[i][position]);
            
                NSUInteger newRow = ((26 + (cribMatrix[i][position] - thisPickerPosition)) % 26) + 1;
                
                NSLog(@"updating xpicker %d to %zd", i, newRow);
                
                [keyOnePickers[i - 1] selectRow:newRow inComponent:0 animated:true];
                [self changePickers:@"x" pickerCol:i];
                
            }
            
        }
        
    }
    
}




#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    
    // initialize the cribMatrix with -1 values for null
    for (int i = 0; i < 13; i++) {
        for (int j = 0; j < 12; j++) {
            cribMatrix[i][j] = -1;
        }
        
    }

    // initialize the masks to all true
    for (int i = 0; i < 13; i++) {
        xkeyMask[i] = true;
        ykeyMask[i] = true;
    }

    // called whenever a picker is turned
    NSString *ciphertext = _ciphertext.text;
    _plaintext.text = [self decode:ciphertext];
    
    // now change all the other pickers according to the cribMatrix
    // first get the number of the picker that was changed
    int xpicker = 0;
    int xpickernum = 0;
    for (UIPickerView *picker in keyOnePickers) {
        if (pickerView == picker) {
            xpickernum = xpicker + 1;
        }
        xpicker++;
    }

    //NSLog(@"Changed xpicker: %d", xpickernum);

    int ypicker = 0;
    int ypickernum = 0;
    for (UIPickerView *picker in keyTwoPickers) {
        if (pickerView == picker) {
            ypickernum = ypicker + 1;
        }
        ypicker++;
    }
    
    //NSLog(@"Changed y picker: %d", ypickernum);

    if (xpickernum != 0) {
        [self changePickers:@"x" pickerCol:xpickernum];
    } else {
        [self changePickers:@"y" pickerCol:ypickernum];
    }
    
    // then decode it again?
    _plaintext.text = [self decode:ciphertext];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
                                                replacementText:(NSString *)text
{
    
    //NSLog(@"changed ciphertext");
    return true;
    
}

- (IBAction)pressedTranspose:(id)sender {

    //NSString *ciphertext = _ciphertext.text;
    //_plaintext.text = [self decode:ciphertext];
    
    
    int xChars = [_boxWidth.text intValue];
    
    _plaintext.text = _ciphertext.text;
    
    //_plaintext.text = [[self transpose:_plaintext.text byXChars:24 padAtEnd:true clockwise:true] mutableCopy];
    //_plaintext.text = [[self transpose:_plaintext.text byXChars:14 padAtEnd:false clockwise:true] mutableCopy];
    _plaintext.text = [[self transpose:_plaintext.text byXChars:xChars padAtEnd:false clockwise:true] mutableCopy];
    
}



- (IBAction)pressedReset:(id)sender {
    
    [_x1 selectRow:1 inComponent:0 animated:YES];
    [_x2 selectRow:0 inComponent:0 animated:YES];
    [_x3 selectRow:0 inComponent:0 animated:YES];
    [_x4 selectRow:0 inComponent:0 animated:YES];
    [_x5 selectRow:0 inComponent:0 animated:YES];
    [_x6 selectRow:0 inComponent:0 animated:YES];
    [_x7 selectRow:0 inComponent:0 animated:YES];
    [_x8 selectRow:0 inComponent:0 animated:YES];
    [_x9 selectRow:0 inComponent:0 animated:YES];
    [_x10 selectRow:0 inComponent:0 animated:YES];
    [_x11 selectRow:0 inComponent:0 animated:YES];
    [_x12 selectRow:0 inComponent:0 animated:YES];
    
    [_y1 selectRow:1 inComponent:0 animated:YES];
    [_y2 selectRow:0 inComponent:0 animated:YES];
    [_y3 selectRow:0 inComponent:0 animated:YES];
    [_y4 selectRow:0 inComponent:0 animated:YES];
    [_y5 selectRow:0 inComponent:0 animated:YES];
    [_y6 selectRow:0 inComponent:0 animated:YES];
    [_y7 selectRow:0 inComponent:0 animated:YES];
    [_y8 selectRow:0 inComponent:0 animated:YES];
    [_y9 selectRow:0 inComponent:0 animated:YES];
    [_y10 selectRow:0 inComponent:0 animated:YES];
    [_y11 selectRow:0 inComponent:0 animated:YES];
    [_y12 selectRow:0 inComponent:0 animated:YES];
    
}

-(NSString *) decodeVigenere:(NSString *)ciphertext withKeyword:(NSString *)keyword {
    
    NSMutableString *plaintext = [NSMutableString stringWithString:@""];
    
    //NSString *alphabetString = @"KRYPTOSABCDEFGHIJLMNQUVWXZ";
    if ([alphabetString  isEqual: @""]) {
        [self setAlphabetString:@"KRYPTOSABCDEFGHIJLMNQUVWXZ"];
    }
    
    NSMutableArray *cipherAlphabet = [[NSMutableArray alloc] initWithCapacity:[alphabetString length]+1];
    
    NSMutableDictionary *alphabetMap = [NSMutableDictionary new];
    
    for (int i=0; i < [alphabetString length]; i++) {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [alphabetString characterAtIndex:i]];
        [alphabetMap setObject:[NSNumber numberWithInt:i] forKey:ichar];
        [cipherAlphabet addObject:ichar];
    }
    
    int keywordLength = (int)[keyword length];
    
    int vigIndex = 0;
    
    // split the ciphertext by the length of keyword, then decode by each letter
    for (int i=0; i < [ciphertext length]; i++) {
        
        if (keywordLength == 0) {break;}
        
        NSString *character  = [NSString stringWithFormat:@"%c", [ciphertext characterAtIndex:i]];

        // skip if it's not in the alphabet
        if ([alphabetString rangeOfString:character].location == NSNotFound){
            [plaintext appendString:character];
            continue;
        }
        
        int cipherTextIndex = [alphabetMap[character] intValue];
        int keywordIndex = vigIndex % keywordLength;
        NSString *keychar = [NSString stringWithFormat:@"%c", [keyword characterAtIndex:keywordIndex]];
        int keycharIndex = [alphabetMap[keychar] intValue];
        
        int plaintextindex = 26 + cipherTextIndex - keycharIndex;
        
        plaintextindex = plaintextindex % 26;
        
        NSString *plaintextChar = cipherAlphabet[plaintextindex];
        [plaintext appendString:plaintextChar];
    
        vigIndex++;
    
    }
    
    return (plaintext);
}


-(NSString *) decode:(NSString *)ciphertext

{
   
    NSMutableString *keywordOne = [NSMutableString stringWithString:@""];
    NSMutableString *keywordTwo = [NSMutableString stringWithString:@""];
    NSString *plaintext = [NSMutableString stringWithString:@""];
    
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
    
    //NSString *returnText = [NSString stringWithFormat:@"key1 = %@\nkey2 = %@", keywordOne, keywordTwo];
    //NSLog(@"%@", returnText);
    
    plaintext = [self decodeVigenere:ciphertext withKeyword:keywordOne];
    
    int xChars = [_boxWidth.text intValue];
    
    plaintext = [self transpose:plaintext byXChars:xChars padAtEnd:FALSE clockwise:true];
    
    // change the alphabet key if you want
    //[self setAlphabetString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ"];
    
    plaintext = [self decodeVigenere:plaintext withKeyword:keywordTwo];

    int turnBack = (int)[plaintext length] / xChars;

    if (turnBack == 0) { turnBack = 1;};
    
    plaintext = [self transpose:plaintext byXChars:turnBack padAtEnd:FALSE clockwise:false];
    
    // determine the value of x and y that are used to encode the crib NYPVTTMZFPK to BERLINCLOCK
    int keyOneLength = (int)[keywordOne length];
    int keyTwoLength = (int)[keywordTwo length];
    int plaintextLength = (int)[_plaintext.text length];
    NSMutableDictionary *keyOneMap = [NSMutableDictionary new];
    NSMutableDictionary *keyTwoMap = [NSMutableDictionary new];
    
    NSString *tempText = _plaintext.text;
    
    NSMutableString *positionData = [NSMutableString stringWithString:@""];
    
    // in order to figure out where the cribstring is and what is was encoded with, we need to
    // know its location, the key lengths, and the number of padded chars
    
    // essentially do the decode process over without changing anything...
    
    int vigIndex = 0;
    int numPads = 0;
    // split the ciphertext by the length of keyword, then decode by each letter
    for (int i=0; i < plaintextLength; i++) {
        
        if (keyOneLength == 0) {break;}
        
        NSString *character  = [NSString stringWithFormat:@"%c", [tempText characterAtIndex:i]];
        
        // skip if it's not in the alphabet
        if ([alphabetString rangeOfString:character].location == NSNotFound){
            numPads++;
            continue;
        }
        int keywordIndex = vigIndex % keyOneLength;

        [positionData appendString:[NSString stringWithFormat:@"%@ - %i",character,keywordIndex + 1]];
        //NSLog (@"%i - %@ - %i",vigIndex,character,keywordIndex + 1);
        [keyOneMap setObject:[NSNumber numberWithInt:keywordIndex + 1] forKey:[NSString stringWithFormat:@"%d",vigIndex]];
        
        vigIndex++;
        
    }

    // then transpose and check for y key map
    tempText = [[self transpose:tempText byXChars:xChars padAtEnd:false clockwise:true] mutableCopy];

    vigIndex = 0;
    // split the ciphertext by the length of keyword, then decode by each letter
    for (int i=0; i < plaintextLength; i++) {
        
        if (keyTwoLength == 0) {break;}
        
        NSString *character  = [NSString stringWithFormat:@"%c", [tempText characterAtIndex:i]];
        
        // skip if it's not in the alphabet
        if ([alphabetString rangeOfString:character].location == NSNotFound){
            continue;
        }
        int keywordIndex = vigIndex % keyTwoLength;
        // the position of the char is different due to the transposition
        // there should be a formula to figure it out...
        //int position =
        
        [positionData appendString:[NSString stringWithFormat:@"%@ - %i",character,keywordIndex + 1]];
        //NSLog (@"%i - %@ - %i",vigIndex,character,keywordIndex + 1);
        [keyTwoMap setObject:[NSNumber numberWithInt:keywordIndex + 1] forKey:[NSString stringWithFormat:@"%d",vigIndex]];
        vigIndex++;
        
    }
    
    
    // B == char 64 (base 1)
    NSMutableDictionary *cribInfo = [NSMutableDictionary new];
    
    /*
    [cribInfo setObject:@"E" forKey:@"64"];
    [cribInfo setObject:@"L" forKey:@"65"];
    [cribInfo setObject:@"Y" forKey:@"66"];
    [cribInfo setObject:@"O" forKey:@"67"];
    [cribInfo setObject:@"I" forKey:@"68"];
    [cribInfo setObject:@"E" forKey:@"69"];
    [cribInfo setObject:@"C" forKey:@"70"];
    [cribInfo setObject:@"B" forKey:@"71"];
    [cribInfo setObject:@"A" forKey:@"72"];
    [cribInfo setObject:@"Q" forKey:@"73"];
    [cribInfo setObject:@"K" forKey:@"74"];
    */
    [cribInfo setObject:[NSNumber numberWithInt:11] forKey:@"64"];
    [cribInfo setObject:[NSNumber numberWithInt:17] forKey:@"65"];
    [cribInfo setObject:[NSNumber numberWithInt:2] forKey:@"66"];
    [cribInfo setObject:[NSNumber numberWithInt:5] forKey:@"67"];
    [cribInfo setObject:[NSNumber numberWithInt:15] forKey:@"68"];
    [cribInfo setObject:[NSNumber numberWithInt:11] forKey:@"69"];
    [cribInfo setObject:[NSNumber numberWithInt:9] forKey:@"70"];
    [cribInfo setObject:[NSNumber numberWithInt:8] forKey:@"71"];
    [cribInfo setObject:[NSNumber numberWithInt:7] forKey:@"72"];
    [cribInfo setObject:[NSNumber numberWithInt:20] forKey:@"73"];
    [cribInfo setObject:[NSNumber numberWithInt:0] forKey:@"74"];
    
    // initialize the cribMatrix with -1 values for null
    for (int i = 0; i < 13; i++) {
        for (int j = 0; j < 13; j++) {
            cribMatrix[i][j] = -1;
        }
        
    }
    
    NSArray *sortedKeys = [[cribInfo allKeys] sortedArrayUsingSelector: @selector(compare:)];
    //NSMutableArray *sortedValues = [NSMutableArray array];
    for (NSString *key in sortedKeys) {
    
        int cribPosition = [key intValue];
    
        int xposition = (cribPosition + numPads) % xChars;
        int yposition = (int)(cribPosition + numPads) / xChars;
        if (xposition == 0) {
            xposition = xChars;
        } else {
            yposition++;
        }
        
        int numPadOffset = numPads;
    
        if (xposition <= numPads) {
            numPadOffset = numPads - xposition;
        }
        
        
        int transposePosition = (((xposition - 1) * turnBack) + (turnBack - yposition)) - numPadOffset;
    
        //NSLog(@"Decode char num x %d y %d with %@ and %@ - %@", cribPosition, transposePosition, keyOneMap[[NSString stringWithFormat:@"%d",(cribPosition - 1)]],
        //      keyTwoMap[[NSString stringWithFormat:@"%d",transposePosition]], cribInfo[[NSString stringWithFormat:@"%d",cribPosition]]);
    
        // now create the add to the cribMatrix accordingly
        
        cribMatrix[[keyOneMap[[NSString stringWithFormat:@"%d",(cribPosition - 1)]] intValue]]
                  [[keyTwoMap[[NSString stringWithFormat:@"%d",transposePosition]] intValue]]
        = [cribInfo[[NSString stringWithFormat:@"%d",cribPosition]] intValue];
        
    }
    //NSLog(@"\n");
    
    return (plaintext);

    
}

-(NSString *) transpose:(NSString *)ciphertext byXChars:(int)xChars padAtEnd:(bool)atEnd clockwise:(bool)clockwise {
    
    
    // basically we take string ciphertext and put into rows xChars wide then turn left or right and read from
    // the side
    
    
    NSMutableString *CT = [ciphertext mutableCopy];
    
    //NSLog(@"ciphertext is: %@", ciphertext);
    
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
    
    if (clockwise) {
        for (int j = 0; j < xChars; j++) {
            for (int i = numStrings - 1; i >= 0; i--) {
                [transposedString appendString:[[stringArrays objectAtIndex:i] substringWithRange:NSMakeRange(j,1)]];
            }
        }
    } else {
        for (int j = xChars - 1; j >= 0; j--) {
            for (int i = 0; i < numStrings; i++) {
                [transposedString appendString:[[stringArrays objectAtIndex:i] substringWithRange:NSMakeRange(j,1)]];
            }
        }
    }
    
    //NSLog(@"transpose string: %@", [stringArrays objectAtIndex:0]);
    //NSLog(@"transpose string: %@", [stringArrays objectAtIndex:1]);
    //NSLog(@"transpose string: %@", [stringArrays objectAtIndex:2]);
    
    //NSLog(@"transposed string final: %@", transposedString);
    
    
    return (transposedString);
    
}

- (IBAction)K1pressed:(id)sender {
    
    NSString *K1 = @"EMUFPHZLRFAXYUSDJKZLDKRNSHGNFI"
                    "VJYQTQUXQBQVYUVLLTREVJYQTMKYRDMFD";
    _ciphertext.text = K1;
    
}

- (IBAction)K2pressed:(id)sender {

    NSString *K2 = @"VFPJUDEEHZWETZYVGWHKKQETGFQJNCE"
    "GGWHKKDQMCPFQZDQMMIAGPFXHQRLG"
    "TIMVMZJANQLVKQEDAGDVFRPJUNGEUNA"
    "QZGZLECGYUXUEENJTBJLBQCRTBJDFHRR"
    "YIZETKZEMVDUFKSJHKFWHKUWQLSZFTI"
    "HHDDDUVHDWKBFUFPWNTDFIYCUQZERE"
    "EVLDKFEZMOQQJLTTUGSYQPFEUNLAVIDX"
    "FLGGTEZFKZBSFDQVGOGIPUFXHHDRKF"
    "FHQNTGPUAECNUVPDJMQCLQUMUNEDFQ"
    "ELZZVRRGKFFVOEEXBDMVPNFQXEZLGRE"
    "DNQFMPNZGLFLPMRJQYALMGNUVPDXVKP"
    "DQUMEBEDMHDAFMJGZNUPLGESWJLLAETG";
    _ciphertext.text = K2;

}

- (IBAction)K3pressed:(id)sender {

    NSString *K3 = @"ENDYAHROHNLSRHEOCPTEOIBIDYSHNAIA"
    "CHTNREYULDSLLSLLNOHSNOSMRWXMNE"
    "TPRNGATIHNRARPESLNNELEBLPIIACAE"
    "WMTWNDITEENRAHCTENEUDRETNHAEOE"
    "TFOLSEDTIWENHAEIOYTEYQHEENCTAYCR"
    "EIFTBRSPAMHHEWENATAMATEGYEERLB"
    "TEEFOASFIOTUETUAEOTOARMAEERTNRTI"
    "BSEDDNIAAHTTMSTEWPIEROAGRIEWFEB"
    "AECTDDHILCEIHSITEGOEAOSDDRYDLORIT"
    "RKLMLEHAGTDHARDPNEOHMGFMFEUHE"
    "ECDMRIPFEIMEHNLSSTTRTVDOHW";
    _ciphertext.text = K3;

}
- (IBAction)K4pressed:(id)sender {

    NSString *K4 = @"OBKRUOXOGHULBSOLIFBBWFLRVQQPRNGKS"
    "SOTWTQSJQSSEKZZWATJKLUDIAWINFBN"
    "YPVTTMZFPKWGDKZXTJCDIGKUHUAUEKCAR";
    _ciphertext.text = K4;

}


@end
