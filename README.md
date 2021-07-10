# shellToolBox
shell 语言编写的工具包，**包含以下文件**。
+ `toolBoxV1.0.sh`
+ `install_essential_tools.sh`
+ `kernel_replace.sh`


## 0. toolBoxV1.0.sh
主文件，其中包含了压缩工具、系统监测工具、日期工具... 最重要的是提供了一个选择菜单，帮助我们使用这些工具。

![image](https://user-images.githubusercontent.com/29876896/125155556-696b1680-e193-11eb-8b30-441c96dba762.png)


### De/Compression Tool
针对 .gz/.bz2/.tar/.zip/.xz 格式进行压缩以及解压，下图所示，列出了同目录下的文件以及目录：
![image](https://user-images.githubusercontent.com/29876896/125155634-c8309000-e193-11eb-9099-c88948352c6b.png)
1. 选择某个目录，点击OK：
![image](https://user-images.githubusercontent.com/29876896/125155660-eeeec680-e193-11eb-9dde-e9d819c1ea72.png)
2. 显示如下提示，点击OK：
![image](https://user-images.githubusercontent.com/29876896/125155668-03cb5a00-e194-11eb-87b3-046315d8641f.png)
3. 选择压缩/解压/查看，这里选择压缩：
![image](https://user-images.githubusercontent.com/29876896/125155690-31b09e80-e194-11eb-9366-44cf9f29d5ed.png)
4. 选择压缩/解压目录的格式，选择.gz：
![image](https://user-images.githubusercontent.com/29876896/125155703-455c0500-e194-11eb-811f-7a33c1286f27.png)
5. 提示完成。
![image](https://user-images.githubusercontent.com/29876896/125155712-5278f400-e194-11eb-8627-77bf9e559852.png)

目录下查看：
```bash
ubuntu@ubuntu:~/Documents/toolBox$ ls
temp  test1  test1.tar.gz  test2  test3  test4  test5  TOOLBOX  toolBoxV1.0.sh
```

1. 选择压缩包，进行查看：
![image](https://user-images.githubusercontent.com/29876896/125155756-8e13be00-e194-11eb-829b-e28d7e041234.png)
2. 选择压缩包：
![image](https://user-images.githubusercontent.com/29876896/125155774-aa175f80-e194-11eb-8da9-f1aa08e27ad6.png)
3. 进行查看：
![image](https://user-images.githubusercontent.com/29876896/125155786-b996a880-e194-11eb-9e95-ab694e8940e3.png)
4. 选择文件格式：
![image](https://user-images.githubusercontent.com/29876896/125155800-c6b39780-e194-11eb-8e13-b021ba917967.png)
5. 内容显示：
![image](https://user-images.githubusercontent.com/29876896/125156052-1b0b4700-e196-11eb-9219-e06b3810d477.png)

1. 选择压缩包，进行解压：
![image](https://user-images.githubusercontent.com/29876896/125156066-370ee880-e196-11eb-9b75-ac87334d44d2.png)
2. 选择解压选项：
![image](https://user-images.githubusercontent.com/29876896/125156084-4726c800-e196-11eb-831f-185c090aedb3.png)
3. 选择格式
![image](https://user-images.githubusercontent.com/29876896/125156098-51e15d00-e196-11eb-9714-bcc643d6adee.png)
4. 解压

### SystemWatch Tool
主要调用 `htop` 命令。


### Show Date Tool
主要调用 `date` 命令。


## 1. install_essential_tools.sh
主要的命令：
```bash
sudo apt-get install -y vim git m4 gcc g++ net-tools
wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
sudo add-apt-repository 'deb https://typora.io/linux ./'
sudo apt-get update
sudo apt-get install -y typora
```
1. 安装必要的库；
2. 安装 typora；
3. 配置 .vimrc；
4. 为 Typora 配置 Han 主题；


## 2. kernel_replace.sh
内核替换自动化脚本，对于 Linux-4.x, Linux-5.x 有较好支持，

```bash
# 1. Copy this directory to the kernel source file named linux-xxx that you downloaded;
# 2. three points to focus on in this script depend on your environment.
```
