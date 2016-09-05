//
//  YSAddViewController.m
//  菜谱
//
//  Created by qingyun on 16/8/17.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "YSAddViewController.h"
#import <AVFoundation/AVFoundation.h>

#import "TZImagePickerController.h"

@interface YSAddViewController () <UIImagePickerControllerDelegate,UITextViewDelegate,TZImagePickerControllerDelegate>
/** 获取的图片*/
@property (nonatomic, weak) UIImageView *getImv;
/** 获取的图片的数组*/
@property (nonatomic, strong) NSMutableArray *arrMImages;
/** 背景图*/
@property (nonatomic, weak) UIView *viewBack;
/** 添加图片按钮*/
@property (nonatomic, weak) UIButton * albumeButton;

@end

@implementation YSAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
    [self loadNavigationSetting];
}

#pragma mark 加载默认设置
- (void)loadDefaultSetting{
    self.navigationItem.title = @"添加";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.arrMImages = [NSMutableArray arrayWithCapacity:5];
    
    UITextView *textBack = [UITextView new];
    [self.view addSubview:textBack];
    textBack.delegate = self;
    textBack.backgroundColor = [UIColor lightGrayColor];
    textBack.text = @"抒发一下自己此刻的心情吧!!!!";
    textBack.font = [UIFont systemFontOfSize:20 weight:0.8];
    [textBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.leading.mas_equalTo(8);
        make.trailing.mas_equalTo(8);
        make.height.mas_equalTo(200);
    }];
    
    UIView *viewBack = [UIView new];
    [self.view addSubview:viewBack];
    self.viewBack = viewBack;
    [viewBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(textBack);
        make.top.equalTo(textBack.mas_bottom).offset(8);
        make.height.mas_equalTo(80);
    }];
    viewBack.backgroundColor = [UIColor lightGrayColor];
    
    UIButton * albumeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:albumeButton];
    self.albumeButton = albumeButton;
    albumeButton.titleLabel.font =[UIFont fontWithName:kfontBold size:18];
    
    [albumeButton setImage:[UIImage imageNamed:@"btn_normal"] forState:UIControlStateNormal];
    [albumeButton setImage:[UIImage imageNamed:@"btn_normal_selected"] forState:UIControlStateSelected];
    [albumeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewBack).offset(8);
        make.bottom.equalTo(viewBack).offset(-8);
        make.leading.equalTo(viewBack).offset(8);
        make.width.mas_equalTo(60);
    }];
    [albumeButton addTarget:self action:@selector(showAlbume) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark  > 展示图片的方法 <
- (void)showAlbume{
    
    TZImagePickerController *imagepickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:4 delegate:self];
    __weak typeof(self) weakSelf = self;
    [imagepickerVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isCan) {
        [weakSelf.arrMImages addObjectsFromArray:photos];
        [weakSelf loadImageViews];
    }];
    [self presentViewController:imagepickerVC animated:YES completion:nil];
    
//    UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
//    pickerVC.delegate = (id)self;
//    pickerVC.allowsEditing = NO;
//    pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    [self presentViewController:pickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
//    [self.arrMImages addObjectsFromArray:photos];
//    [self loadImageViews];
//    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark  > 加载图片 <
- (void)loadImageViews{
    NSUInteger count = self.arrMImages.count;
    if (count == 0) {
        return;
    }
    
    NSMutableArray *arrMImageViews = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger index = 0; index < count; index ++) {
        UIImage *image = self.arrMImages[index];
        UIImageView *imvBack = [[UIImageView alloc] initWithImage:image];
        [arrMImageViews addObject:imvBack];
        [self.viewBack addSubview:imvBack];
        
        if (index == 0) {
            [imvBack mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_viewBack).offset(3);
                make.bottom.equalTo(_viewBack).offset(-3);
                make.leading.equalTo(_viewBack).offset(3);
                //                make.height.equalTo(scrollView);
                make.centerY.equalTo(_viewBack);
                make.width.mas_equalTo(50);
            }];
            [self addBtnAfterTheImageView:imvBack];
        }else if (index == (count -1)){
            [imvBack mas_makeConstraints:^(MASConstraintMaker *make) {
                UIImageView *imageViewTemp = arrMImageViews[index - 1];
                make.top.equalTo(_viewBack).offset(3);
                make.bottom.equalTo(_viewBack).offset(-3);
                make.leading.equalTo(imageViewTemp.mas_trailing).offset(3);
                // make.trailing.equalTo(_viewBack).offset(-3);
                make.width.mas_equalTo(50);
                make.centerY.equalTo(_viewBack);
            }];
            [self addBtnAfterTheImageView:imvBack];
        }else{
            [imvBack mas_makeConstraints:^(MASConstraintMaker *make) {
                UIImageView *imageViewBefore = arrMImageViews[index - 1];
                make.top.equalTo(_viewBack).offset(3);
                make.bottom.equalTo(_viewBack).offset(-3);
                make.leading.equalTo(imageViewBefore.mas_trailing).offset(3);
                make.width.mas_equalTo(50);
                //                make.height.equalTo(scrollView);
                make.centerY.equalTo(_viewBack);
            }];
        }
    }
//    if (count > 5) {
//        UIAlertController *alertContorller = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"添加照片请不要超过六张" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:nil];
//        [alertContorller addAction:alertAction];
//        [self presentViewController:alertContorller animated:YES completion:nil];
//    }
}

#pragma mark  > 添加按钮 <
- (void)addBtnAfterTheImageView:(UIImageView *)imvLast{
    [self.albumeButton removeFromSuperview];
    UIButton *albumeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:albumeButton];
    self.albumeButton = albumeButton;
//    albumeButton.titleLabel.font =[UIFont fontWithName:kfontBold size:18];
    [albumeButton setImage:[UIImage imageNamed:@"btn_normal"] forState:UIControlStateNormal];
    [albumeButton setImage:[UIImage imageNamed:@"btn_normal_selected"] forState:UIControlStateDisabled];
    [albumeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewBack).offset(8);
        make.bottom.equalTo(self.viewBack).offset(-8);
        make.leading.equalTo(imvLast.mas_trailing).offset(8);
        make.width.mas_equalTo(60);
    }];
    [albumeButton addTarget:self action:@selector(showAlbume) forControlEvents:UIControlEventTouchUpInside];
    if (self.arrMImages.count >= 6) {
        self.albumeButton.enabled = NO;
        
//        UIAlertController *alertContorller = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"添加照片请不要超过六张" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleDefault handler:nil];
//        [alertContorller addAction:alertAction];
//        [self presentViewController:alertContorller animated:YES completion:nil];
    }
}

#pragma mark 加载导航栏设置
- (void)loadNavigationSetting{
    
    UIBarButtonItem *itemWrong = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(clickTheCancelAction:)];
    self.navigationItem.leftBarButtonItem = itemWrong;
    
    UIBarButtonItem *itemSend = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(clickTheSendBtn:)];
    self.navigationItem.rightBarButtonItem = itemSend;
}

#pragma mark  > 点击了勾选或者取消按钮触发的方法 <
- (void)clickTheCancelAction:(UIBarButtonItem *)button{
    NSLog(@">>>>%s",__func__);
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark  > 点击发送时触发的方法 <
- (void)clickTheSendBtn:(UIBarButtonItem *)sendBtn{
    NSLog(@">>>>%s",__func__);
}

#pragma mark  >  textview的代理方法  UITextViewDelegate <
/** 当开始编辑的时候触发的方法*/
- (void)textViewDidBeginEditing:(UITextView *)textView{
    textView.text = nil;
    textView.clearsOnInsertion = YES;
}

#pragma mark  > UIImagePickerControllerDelegate <
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *getimage = info[UIImagePickerControllerOriginalImage];
    [self.arrMImages addObject:getimage];
    //    NSLog(@"image>>>%@",getimage);
    [self loadImageViews];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
-(AVCaptureVideoOrientation)avOrientationForDeviceOrientation:(UIDeviceOrientation)deviceOrientation
{
    AVCaptureVideoOrientation result = (AVCaptureVideoOrientation)deviceOrientation;
    if ( deviceOrientation == UIDeviceOrientationLandscapeLeft )
        result = AVCaptureVideoOrientationLandscapeRight;
    else if ( deviceOrientation == UIDeviceOrientationLandscapeRight )
        result = AVCaptureVideoOrientationLandscapeLeft;
    return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
