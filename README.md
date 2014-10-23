2048-AI
=======
>一个C++小程序，运行在Android手机上，可以抓取游戏2048的运行画面，进行简单的图像处理，识别出当前的布局，并通过算法计算出最优的滑动方向，模拟滑动事件。

![1](https://raw.githubusercontent.com/buptpatriot/2048-AI/master/screenshot/1.png)
![2](https://raw.githubusercontent.com/buptpatriot/2048-AI/master/screenshot/2.png)

####编译(需要NDK)
    ./build
    
>在bin目录下生成可执行文件: 2048ai(ver < 4.0), 2048ai-ics(4.0 <= ver <4.1.2), 2048ai-jb(ver >= 4.1.2)

####运行
  启动手机上的[2048](http://www.wandoujia.com/apps/com.digiplex.game)游戏，将手机连接电脑。执行以下命令：
  
    adb push bin/2048ai-jb /data/local/tm
    adb shell
    /data/local/tmp/2048ai-jb
