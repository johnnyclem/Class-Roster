//
//  StudentDetailViewController.m
//  Class Roster
//
//  Created by John Clem on 1/3/14.
//  Copyright (c) 2014 John Clem. All rights reserved.
//

#import "StudentDetailViewController.h"

@interface StudentDetailViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet UILabel *studentNameLabel;
@property (nonatomic, weak) IBOutlet UIButton *studentPhotoButton;

@end

@implementation StudentDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithStudent:(Student *)student
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.student = student;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [_studentPhotoButton setUserInteractionEnabled:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_student) {
        [_studentNameLabel setText:_student.name];
        if (_student.profilePicture) {
            [_studentPhotoButton setBackgroundImage:nil forState:UIControlStateNormal];
            [_studentPhotoButton setImage:_student.profilePicture forState:UIControlStateNormal];
            [_studentPhotoButton setUserInteractionEnabled:NO];
            [_studentPhotoButton.layer setMasksToBounds:YES];
            [_studentPhotoButton.layer setCornerRadius:128.f];
            [_studentPhotoButton setTitle:@"" forState:UIControlStateNormal];
        } else {
            [_studentPhotoButton setUserInteractionEnabled:YES];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)takeStudentPhoto:(id)sender
{
    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
    [imagePickerVC setDelegate:self];
    [imagePickerVC setSourceType:UIImagePickerControllerSourceTypeCamera];
    [imagePickerVC setAllowsEditing:YES];
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"Finished Picking Photo: %@", info[UIImagePickerControllerEditedImage]);
    
    [picker dismissViewControllerAnimated:YES completion:^{
        _student.profilePicture = info[UIImagePickerControllerEditedImage];
        [_studentPhotoButton setBackgroundImage:nil forState:UIControlStateNormal];
        [_studentPhotoButton setImage:_student.profilePicture forState:UIControlStateNormal];
        [_studentPhotoButton setUserInteractionEnabled:NO];
        [_studentPhotoButton.layer setMasksToBounds:YES];
        [_studentPhotoButton.layer setCornerRadius:128.f];
        [_studentPhotoButton setTitle:@"" forState:UIControlStateNormal];
    }];
}

@end
