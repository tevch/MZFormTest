//
//  ViewController.m
//  SlowMZForm
//
//  Created by Andrey Kan on 4/11/14.
//
//

#import "ViewController.h"
#import "TDPickerController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showMZForm:(id)sender {
    NSLog(@"showMZForm");
    
    NSMutableArray * patternValues = [[NSMutableArray alloc] init];
    for(int altitude = 100; altitude<1500;altitude+=50) {
        [patternValues addObject: [NSString stringWithFormat:@"%d", altitude]];
    }
    
    TDPickerController* picker = [[TDPickerController alloc] init];
    picker.pickerTitle = @"Select Turn Altitude";
    picker.pickerData = patternValues;
    picker.selectedValue = [NSString stringWithFormat:@"%d", 500];
    
    [picker showDialog];
}

@end
