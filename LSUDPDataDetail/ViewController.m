//
//  ViewController.m
//  LSUDPDataDetail
//
//  Created by 王良山 on 2016/12/6.
//  Copyright © 2016年 liangshanw. All rights reserved.
//

#import "ViewController.h"
#import "LSUDPSmartHome.h"


#define socketHostStr @"192.168.23.525"
#define servicePortStr @"7000"

@interface ViewController ()<GCDAsyncUdpSocketDelegate>


@property (weak, nonatomic) IBOutlet UITextView *outPutTextView;

@property (strong, nonatomic)GCDAsyncUdpSocket * udpSocket;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    //UdpSocket objects is obtained from this method
    //this method will bind port, UDP doesn't need to connect, u can directly send and receive instructions.
    //_udpSocket对象从这个方法获取
    //调用这个方法会绑定端口，UDP不需要连接，这一步操作完成即可收发指令了
    
    _udpSocket = [[LSUDPSmartHome sharedInstance] bindToPortWithsocketHost:socketHostStr andservicePort:[NSString stringWithFormat:@"%@",servicePortStr].intValue andUdpSocketDelegate:self];
    
}

- (IBAction)sendCommandClick {
    
    //Here is an example about combustible gas sensor reading instruction
    //这里以发送读取可燃气体传感器的指令作为示例
    
    NSLog(@"click send button");
    [self sendCombustibleGasCommand];
}


#pragma mark --------------------
#pragma mark 指令的收发
- (void)sendCombustibleGasCommand
{
    //address:333333333333333303d0
    //Node address of the smart devices and sensors is not binding, if a sensor node chassis changed, then the sensor's address has changed
    //智能设备中的节点地址和传感器不是绑定一起的，如果某个传感器的节点底盘换了，那么这个传感器的地址也换了，所以这里是动态的
    
    NSString *addressHexStr = @"333333333333333303d0";
    NSData *addressData = [LSUDPSmartHome commandByteDataFromHexString:addressHexStr];
    [self combustibleGasCommandData:addressData];
    
    
}
//combustibleGas
- (void)combustibleGasCommandData:(NSData *)addressData
{
    //u can use the method of commandByteDataFromHexString: to convert hexadecimal string into sendData. There is a example in front about combustible gas
    //这里可以直接使用commandByteDataFromHexString：方法将16进制的字符串抓换成sendData，上面的可燃气体即为示例，这里不做修改了
    
    Byte sendInfo[4];
    sendInfo[0] = 0x26;//&
    sendInfo[1] = 0x54;//T
    sendInfo[2] = 0x52;//R
    sendInfo[3] = 0x43;//C
    
    NSMutableData *sendData = [[NSMutableData alloc] initWithBytes:sendInfo length:4];
    
    //Tip: don't calculate the byte's length with the method of sizeof, otherwise it will go wrong
    //注意：长度不可使用sizeof来计算，否则会出错
    
    //address / 地址
    [sendData appendData:addressData];
    
    //instruction / 指令
    Byte dataInfo[18];
    dataInfo[0] = 0x78;
    dataInfo[1] = 0x78;
    
    dataInfo[2] = 0x31;
    dataInfo[3] = 0x32;
    dataInfo[4] = 0x33;
    dataInfo[5] = 0x78;
    
    dataInfo[6] = 0x78;
    dataInfo[7] = 0x78;
    dataInfo[8] = 0x78;
    dataInfo[9] = 0x78;
    
    dataInfo[10] = 0x78;
    dataInfo[11] = 0x78;
    dataInfo[12] = 0x78;
    dataInfo[13] = 0x78;
    dataInfo[14] = 0x78;
    dataInfo[15] = 0x78;
    
    dataInfo[16] = 0x28;//crc
    dataInfo[17] = 0x2A;//*
    
    NSMutableData *shujuData = [[NSMutableData alloc] initWithBytes:dataInfo length:18];
    [sendData appendData:shujuData];
    NSLog(@"sendData = %@",sendData);//26545243 33333333 33333333 03d07878 31323378 78787878 78787878 7878282a
    [_udpSocket sendData:sendData toHost:socketHostStr port:[NSString stringWithFormat:@"%@",servicePortStr].intValue withTimeout:-1 tag:0];
}



#pragma mark --------------------
#pragma mark UDPdelegate
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didConnectToAddress:(NSData *)address
{
}
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotConnect:(NSError *)error
{
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
    NSLog(@"send successed-----");
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
    NSLog(@"send failed-----");
}

//The data of nodes will coming here , if u want to control node (smart home/sensor), u need to get the address of the node (device).This address is get from here.And sensor data is also get from here.
//节点发过来的数据都会来到这里，控制节点（智能家居/传感器）需要拿到节点的地址(设备刚入网的时候)，便是在这里获取。读取传感器发过来的采集到的数据也是在这里获取

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data
      fromAddress:(NSData *)address
withFilterContext:(nullable id)filterContext
{
    
    //1.the data that combustible gas sensor into the  Local area network sended : / 可燃气体传感器入网发来的数据：
    //26 4A 4F 4E 33 33 33 33 33 33 33 33 03 D0 52 4F 55 0B 5A BC 08 00 4B 12 00 00 00 0B 78 78 78 2A
    //"0B" is the combustible gas sensor's id : / 可燃气体Id：0B
    
    
    //2.the data that combustible gas detector collected 可燃气器采集到的数据：
    //26524741333333333333333303d030373178787878787878787878787878782a
    
    
    NSLog(@"The received data / 接收到的数据%@",data);
    
    //Hexadecimal string data type / 16进制字符串类型的data
    NSString *dataHexStr = [LSUDPSmartHome convertDataToHexDataStr:data];
    NSLog(@"dataHexStr = %@",dataHexStr);
    _outPutTextView.text = dataHexStr;
    
    //Get hexadecimal device ID, the range u need according to your company's agreement to set/ 获取16进制设备ID,range需要根据自己公司的协议或具体的data值来截取
    NSString *DeviceIdHexStr = [LSUDPSmartHome getHexStringFromData:data withRange:NSMakeRange(54, 2)];
    NSLog(@"DeviceIdHexStr = %@",DeviceIdHexStr);
    
    NSString *DeviceIdDecStr = [LSUDPSmartHome getDecStringFromData:data withRange:NSMakeRange(54, 2)];
    NSLog(@"DeviceIdDecStr = %@",DeviceIdDecStr);
    
    
    
    //get device address / 获取设备地址
    NSString *addressHexStr = [LSUDPSmartHome getHexStringFromData:data withRange:NSMakeRange(8, 20)];
    NSLog(@"addressHexStr = %@",addressHexStr);
    
    
    //When sensor connected to the Local area network , u need according to the decimal hardware device ID to identify the intelligence is whice one/ 入网时，根据10进制设备ID来辨别是哪个智能硬件
    switch (DeviceIdDecStr.integerValue) {
        case 11://this is combustible gas
            NSLog(@"this is combustible gas / 这个是可燃气体传感器");
            break;
        case 4:
            
            break;
            
        default:
            break;
    }
    
    
    //Selection of sensors, when the equipment send collectd data / 设备发送来采集的数据时，对传感器的甄选
    
    NSString *commandHexStr = [LSUDPSmartHome getHexStringFromData:data withRange:NSMakeRange(2, 6)];
    if ([commandHexStr isEqualToString:@"545243"]) {//TRC ：The command header / 命令头
        NSLog(@"dataHexStr = %@",dataHexStr);
    }
    
}

/**
 * Called when the socket is closed.
 **/
- (void)udpSocketDidClose:(GCDAsyncUdpSocket *)sock withError:(NSError *)error
{
    
}

@end
