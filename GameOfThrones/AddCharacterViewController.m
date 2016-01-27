//
//  AddCharacterViewController.m
//  GameOfThrones
//
//  Created by Nicholas Naudé on 26/01/2016.
//  Copyright © 2016 Nicholas Naudé. All rights reserved.
//

#import "AddCharacterViewController.h"
#import "Character.h"
#import "AppDelegate.h"

@interface AddCharacterViewController () <UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *actorTextField;

@property (weak, nonatomic) IBOutlet UITextField *ageTextField;

@property (weak, nonatomic) IBOutlet UISegmentedControl *houseSegementedControl;

@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSegementedControl;

@property NSManagedObjectContext *moc;

@property NSString *houseName;

@property NSString *genderName;

//@property NSMutableArray *charactersArray;

@end

@implementation AddCharacterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    self.moc = appDelegate.managedObjectContext;
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//}


- (IBAction)onSegementedControlTapped:(UISegmentedControl *)sender {
    if (self.houseSegementedControl.selectedSegmentIndex == 0) {
        self.houseName = @"Stark";
    } else if (self.houseSegementedControl.selectedSegmentIndex == 1) {
        self.houseName = @"Targaryen";
    } else if (self.houseSegementedControl.selectedSegmentIndex == 2){
        self.houseName = @"Lanister";
    } else if (self.houseSegementedControl.selectedSegmentIndex == 3) {
        self.houseName = @"Tyrells";
    }
}

- (IBAction)onGenderSegmentedControlTapped:(UISegmentedControl *)sender {
    if (self.houseSegementedControl.selectedSegmentIndex == 0) {
        self.genderName = @"Male";
    } else if (self.houseSegementedControl.selectedSegmentIndex == 1) {
        self.genderName = @"Female";
    }
}

- (IBAction)onSaveTapped:(UIButton *)sender {
    Character *character = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:self.moc];
    
    character.name = self.nameTextField.text;
    character.actor = self.actorTextField.text;
    character.age = [NSNumber numberWithInteger:self.ageTextField.text];
    character.house = self.houseName;
    character.gender = self.genderName;
    
    NSError *error;
    
    if (![self.moc save:&error]) {
        NSLog(@"Failed to load %@", error.localizedDescription);
    }
}

- (IBAction)onAddPhotoTapped:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    //    [self imagePickerController:<#(nonnull UIImagePickerController *)#> didFinishPickingMediaWithInfo:<#(nonnull NSDictionary<NSString *,id> *)#>];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    Character *character = [NSEntityDescription insertNewObjectForEntityForName:@"Character" inManagedObjectContext:self.moc];
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    NSData *imageData = UIImagePNGRepresentation(chosenImage);
    character.picture = chosenImage;
}

@end
