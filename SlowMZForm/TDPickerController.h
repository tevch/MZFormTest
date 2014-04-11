//
//  TDPickerController.h
//  Spotassist
//
//  Created by Andrey Kan on 3/31/14.
//  Copyright (c) 2014 Livewings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZFormSheetController.h"

@class TDPickerController;

@protocol TDPickerSelectorDelegate <NSObject>
@optional
-(void) TDPickerController:(TDPickerController *)selector selectedValue:(NSString *)value index:(NSInteger)idx;
-(void) TDPickerController:(TDPickerController *)selector cancelPicker:(BOOL)cancel;
@end

@interface TDPickerController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property(nonatomic, weak) IBOutlet UIBarButtonItem * cancelToolbarButton;
@property(nonatomic, weak) IBOutlet UIBarButtonItem * applyToolbarButton;
@property(nonatomic, weak) IBOutlet UIToolbar * toolbar;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) NSString *selectedValue;

@property(nonatomic, retain) NSString *pickerTitle;
@property(nonatomic, weak) IBOutlet UILabel * titleLabel;
@property(nonatomic, weak) IBOutlet UILabel * titleToolbarLabel;

@property(nonatomic, weak) IBOutlet UIButton * cancelButton;
@property(nonatomic, weak) IBOutlet UIButton * applyButton;

@property (nonatomic, strong) NSMutableArray *pickerData;
@property (nonatomic, assign) int numberOfComponents;
@property (nonatomic, retain) id<TDPickerSelectorDelegate> pickerDelegate;



@property(nonatomic, retain) MZFormSheetController *formSheet;

-(IBAction)cancelEdit:(id)sender;
-(IBAction)applyEdit:(id)sender;

-(void)showDialog;

@end
