//
//  TDPickerController.m
//  Spotassist
//
//  Created by Andrey Kan on 3/31/14.
//  Copyright (c) 2014 Livewings. All rights reserved.
//

#import "TDPickerController.h"


@implementation TDPickerController

- (id)init {
    return [self initWithNibName:@"TDPickerController" bundle:nil];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        int dialogHeight = 250;
        int topInset = 200;
        if(OSVersionIsAtLeastiOS7()) {
            dialogHeight = 250;
            topInset = 160;
        } else {
            dialogHeight = 204;
            topInset = 200;
        }
        self.formSheet = [[MZFormSheetController alloc] initWithSize:CGSizeMake(320, dialogHeight) viewController:self];
        self.formSheet.transitionStyle = MZFormSheetTransitionStyleSlideFromBottom;
        self.formSheet.shouldDismissOnBackgroundViewTap = NO;
        self.formSheet.portraitTopInset = topInset;
        //self.formSheet.landscapeTopInset = 40;
        
        //self.formSheet.shadowOpacity = 0.9;

        //id appearance = [MZFormSheetController appearance];
        
        //[appearance setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.8]];
        //[appearance setBackgroundColor:<#(UIColor *)#>];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(OSVersionIsAtLeastiOS7()) {
        [self.toolbar removeFromSuperview];
        [self.titleToolbarLabel removeFromSuperview];
        self.view.alpha = 0.7;
    } else {
        [self.applyButton removeFromSuperview];
        [self.cancelButton removeFromSuperview];
        [self.titleLabel removeFromSuperview];
        self.view.alpha = 1;
    }
    
    self.pickerData = [NSMutableArray arrayWithCapacity:0];
    self.numberOfComponents = 1;
    
}
- (void)viewWillAppear:(BOOL)animated {
    if(OSVersionIsAtLeastiOS7()) {
        self.titleLabel.text = self.pickerTitle;
    } else {
        self.titleToolbarLabel.text = self.pickerTitle;
    }
    
    int currentValueIndex = -1;
    int currentIndex = 0;
    for(NSString *value in self.pickerData) {
        if([value isEqualToString:self.selectedValue]) {
            currentValueIndex = currentIndex;
            break;
        }
        
        currentIndex++;
    }
    
    if(currentValueIndex>=0) {
        [self.pickerView selectRow:currentValueIndex inComponent:0 animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showDialog {
    [self.formSheet presentAnimated:YES completionHandler:^(UIViewController *presentedFSViewController) {
        //NSLog(@"complete");
        
    }];
}

-(IBAction)cancelEdit:(id)sender {
    //NSLog(@"cancelEdit");
    if (self.pickerDelegate && [self.pickerDelegate respondsToSelector:@selector(TDPickerController:cancelPicker:)]) {
        [self.pickerDelegate TDPickerController:self cancelPicker:YES];
    }
    [self.formSheet dismissAnimated:TRUE completionHandler:^(UIViewController *presentedFSViewController) {
        //NSLog(@"closed");
    }];
}
-(IBAction)applyEdit:(id)sender {
    //NSLog(@"applyEdit");
    if (self.pickerDelegate) {
        NSMutableString *str = [NSMutableString stringWithString:@""];
        for (int i = 0; i < self.numberOfComponents; i++) {
            if (self.numberOfComponents == 1) {
                [str appendString:self.pickerData[[self.pickerView selectedRowInComponent:0]]];
            }else{
                NSMutableArray *componentData = self.pickerData[i];
                [str appendString:componentData[[self.pickerView selectedRowInComponent:i]]];
                if (i<self.numberOfComponents-1) {
                    [str appendString:@" "];
                }
            }
        }
        
        if ([self.pickerDelegate respondsToSelector:@selector(TDPickerController:selectedValue:index:)]) {
            [self.pickerDelegate TDPickerController:self selectedValue:str index:[self.pickerView selectedRowInComponent:0]];
        }
    }
    [self.formSheet dismissAnimated:TRUE completionHandler:^(UIViewController *presentedFSViewController) {
        //NSLog(@"closed");
    }];
}

#pragma mark - picker delegate and datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.numberOfComponents;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.numberOfComponents > 1) {
        NSMutableArray *comp = self.pickerData[component];
        return comp.count;
    }
    return self.pickerData.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (self.numberOfComponents > 1) {
        NSMutableArray *comp = self.pickerData[component];
        return comp[row];
    }
    return self.pickerData[row];
}


@end
