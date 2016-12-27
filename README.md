# LSUDPDataDetail
A framework that use one line of code to solve hex or decimal multifarious data transformation problem when a UDP or TCP communications.

一个在UDP或TCP通信时，16进制、10进制、NSData等数据之间的转换发送等工具处理类库

UDP指令里面包含通信的地址，设备Id，发送的数据等具体指令协议解读,以及16进制、10进制、NSData等之间的转换，请查看Demo，或者参阅 [我的博客](http://www.jianshu.com/users/5df251480905/latest_articles)

 ![image](https://github.com/CoderLSWang/LSUDPDataDetail/blob/master/LSUDPDataDetail/ScreenShots/Snip20161202_30.png) 
 ![image](https://github.com/CoderLSWang/LSUDPDataDetail/blob/master/LSUDPDataDetail/ScreenShots/SimulatorScreenShothome.png)


## 一. Installation 安装

* CocoaPods：pod 'LSUDPDataDetail'
* 手动导入：将LSUDPDataDetail文件夹拽入项目中，导入头文件：#import "LSUDPDataDetail.h"

## 二. Example 例子

    //指令的发送
    - (void)sendCombustibleGasCommand
    {
        //address:333333333333333303d0
        //Node address of the smart devices and sensors is not binding, if a sensor node chassis changed, then the sensor's address has changed
        //智能设备中的节点地址和传感器不是绑定一起的，如果某个传感器的节点底盘换了，那么这个传感器的地址也换了，所以这里是动态的

        NSString *addressHexStr = @"333333333333333303d0";
        NSData *addressData = [LSUDPDataDetail commandByteDataFromHexString:addressHexStr];
        [self combustibleGasCommandData:addressData];

    }

    //The data of nodes will coming here , if u want to control node (smart home/sensor), u need to get the address of the node (device).This address is get from here.And sensor data is also get from here.
    //节点发过来的数据都会来到这里，控制节点（智能家居/传感器）需要拿到节点的地址(设备刚入网的时候)，便是在这里获取。读取传感器发过来的采集到的数据也是在这里获取

    - (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data
    fromAddress:(NSData *)address
    withFilterContext:(nullable id)filterContext
    {

        //Selection of sensors, when the equipment send collectd data / 设备发送来采集的数据时，对传感器的甄选

        NSString *commandHexStr = [LSUDPDataDetail getHexStringFromData:data withRange:NSMakeRange(2, 6)];
        if ([commandHexStr isEqualToString:@"545243"]) {//TRC ：The command header / 命令头
        NSLog(@"dataHexStr = %@",dataHexStr);
        }

    }


## 三. Requirements 要求
iOS7及以上系统可使用. ARC环境.

## 四. More 更多 

If you find a bug, please create a issue.  
Welcome to pull requests.  
More infomation please view demo.  
如果你发现了bug，请提一个issue。  
欢迎给我提pull requests。  
