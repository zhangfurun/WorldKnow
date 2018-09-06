//
//  AddressChooseViewController.m
//  WorldKnow
//
//  Created by ifenghui on 2018/9/6.
//  Copyright © 2018年 张福润. All rights reserved.
//

#import "AddressChooseViewController.h"


#import "CityModel.h"
@interface AddressChooseViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSDictionary *dict;//用于存储省份-城市的数据
    NSArray *provinceArray;//省份的数组
    NSArray *cityArray;//城市的数组，在接下来的代码中会有根据省份的选择进行数据更新的操作
    NSMutableArray *districtNameArray;//区/县的分组
    NSMutableArray *districtNumberArray;//区县编码
}
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIButton *buttonBack;

@end

@implementation AddressChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPicker];
    self.districtNameStr=@"三明";
    self.districtNumberStr=@"101230801";
    self.buttonBack.layer.cornerRadius=16;
    self.buttonBack.layer.masksToBounds=YES;
    
    // Do any additional setup after loading the view.
}
//获取city天气的详情
-(void)getCityWeatherDetailWithCityNumber:(NSString *)cityNumber{
    NSURLSession *session=[NSURLSession sharedSession];
    NSMutableURLRequest *requset=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://apistore.baidu.com/microservice/weather?cityid=%@",cityNumber]]];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:requset completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(data){
            NSMutableDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@",dic);
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.cityModel setValuesForKeysWithDictionary:dic[@"retData"]];
                
            });
        }
    }];
    [task resume];
    
    
}
-(CityModel *)cityModel{
    if(!_cityModel){
        _cityModel=[[CityModel alloc]init];
    }
    return _cityModel;
}

- (IBAction)backAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)sureAction:(id)sender {
    
    
    //通过编号获取该城市的天气详情
    [self getCityWeatherDetailWithCityNumber:self.districtNumberStr];
    __weak typeof(self) WS = self;
    [self dismissViewControllerAnimated:YES completion:^{
        
        //            NSLog(@"%@",weakSelf.cityModel.temp);
        if (WS.block) {
            WS.block(WS.cityModel);
        }
        
    }];
    
}

-(void)setCityWeatherBlcok:(cityWeatherBlock)block{
    _block=block;
}

-(void)initPicker{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"code_1" ofType:@"plist"];
    dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    //省份的数组
    provinceArray = [dict allKeys];
    
    
    
    
    
    
    //城市的数组
    NSInteger selectedProvinceIndex = [self.pickerView selectedRowInComponent:0];
    NSString *seletedProvince = [provinceArray objectAtIndex:selectedProvinceIndex];
    NSDictionary *dicSheng=[dict objectForKey:seletedProvince];
    cityArray = dicSheng.allKeys;
    
    
    
    
    
    
    
    
    //县区的分组s
    NSInteger selectedCityIndex = [self.pickerView selectedRowInComponent:1];
    NSString *seletedCity = [cityArray objectAtIndex:selectedCityIndex];
    
    NSArray *cityArr=dicSheng[seletedCity];
    districtNameArray=[NSMutableArray array];
    districtNumberArray=[NSMutableArray array];
    for(int i=0;i<cityArr.count;i++){
        NSDictionary *dicQu=cityArr[i];
        
        NSString *districtName=dicQu[@"district"];
        NSString *districtNumber=dicQu[@"code"];
        [districtNameArray addObject:districtName];
        [districtNumberArray addObject:districtNumber];
    }
    
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}
//确定picker的每个轮子的item数
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {//省份个数
        return [provinceArray count];
    } else {//市的个数
        if(component==1){
            return [cityArray count];
        }
        else{
            return [districtNameArray count];
        }
    }
}
//确定每个轮子的每一项显示什么内容
#pragma mark 实现协议UIPickerViewDelegate方法
-(NSString *)pickerView:(UIPickerView *)pickerView
            titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {//选择省份名
        return [provinceArray objectAtIndex:row];
    } else {//选择市名
        if(component==1){
            return [cityArray objectAtIndex:row];
        }
        else{
            return [districtNameArray objectAtIndex:row];
        }
    }
}
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(component==0){
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
        [self.pickerView selectRow:0 inComponent:2 animated:YES];
    }
    else{
        if(component==1){
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
        }
    }
    
    NSInteger selectedProvinceIndex = [self.pickerView selectedRowInComponent:0];
    NSString *seletedProvince = [provinceArray objectAtIndex:selectedProvinceIndex];
    NSDictionary *dicSheng=[dict objectForKey:seletedProvince];
    cityArray = dicSheng.allKeys;
    
    //重点！更新第二个轮子的数据
    [self.pickerView reloadComponent:1];
    
    
    
    NSInteger selectedCityIndex = [self.pickerView selectedRowInComponent:1];
    NSString *seletedCity = [cityArray objectAtIndex:selectedCityIndex];
    
    NSArray *cityArr=dicSheng[seletedCity];
    districtNameArray=[NSMutableArray array];
    districtNumberArray=[NSMutableArray array];
    for(int i=0;i<cityArr.count;i++){
        NSDictionary *dicQu=cityArr[i];
        NSString *districtName=dicQu[@"district"];
        NSString *districtNumber=dicQu[@"code"];
        [districtNameArray addObject:districtName];
        [districtNumberArray addObject:districtNumber];
    }
    [self.pickerView reloadComponent:2];
    
    NSInteger selectedQuIndex = [self.pickerView selectedRowInComponent:2];
    //    NSString *seletedQu = [districtNameArray objectAtIndex:selectedQuIndex];
    //
    //
    //    self.districtNameStr=seletedQu;
    
    
    NSString *seletedQuNumber = [districtNumberArray objectAtIndex:selectedQuIndex];
    self.districtNumberStr=seletedQuNumber;
    
    
    
    
    
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

