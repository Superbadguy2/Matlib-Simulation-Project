% 通过MATLAB编程实现,通过正弦波合成周期为10s,幅度为1V 的三角波,要
% 求其均方误差MSE小于0.1。
clc
clear
% 描述参数周期为10s，角频率为w
T = 10;
w = 2*pi/T;
k = 3;
ak = zeros(1,k);
bk = zeros(1,k);

% 初始化波形
m = 2^8;
t0 = 0;
t1 = 10;
t= linspace(t0,t1,m);
y = zeros(1,m);

% 添加直流分量
a0 = 1;
for i = 1:m
    y(i) = a0 / 2;
end

% 添加谐波分量
for i = 1:k
    ak(i) = getak(w,i,T);
    bk(i) = getbk(w,i,T);
    y = y + ak(i).*cos(i.*w.*t) + bk(i).*sin(i.*w.*t);
end

% 均方误差（Root Mean Squared Error，RMSE）：RMSE是回归任务中常用的损失函数，
% 它衡量模型预测值与实际值之间的平均平方误差。

% 计算理想化波形信号
y1 = zeros(1,m);
for i = 1:m
    if i <= m/2
        y1(i) = t(i) ./ 5;
    else 
        y1(i) = 2 - t(i) ./ 5;
    end
end

% 绘制图像
plot(t,y);
hold on;
plot(t,y1);

% 均方误差(Mean Squared Error,简称MSE)，先对预测值和观测值进行相减，计算误差；然后将所有误差项平方后求和；最后取平均值。
% 均方根误差(Root Mean Squared Error,简称RMSE),需要先对数据做平方处理，然后求平均值，最后取平方根。
y_error = y1 - y;
RMSE = sqrt(mean(y_error.^2));
% 四种求MSE的方法
MSE1 = mse(y_error);
MSE2 = sum(y_error.^2) / length(y_error);
MSE3 = mean(y_error.^2);
MSE4 = mse(y1,y);
fprintf('%d\n',RMSE);

% 获取傅里叶级数ak
function ak = getak(w,k,T)
    f1 = @(t) abs(t./5).*cos(k.*w.*t);
    ak = integral(f1,-(T/2),T/2);
    ak = 2 * ak / T;
end

% 获取傅里叶级数bk
function bk = getbk(w,k,T)
    f2 = @(t) abs(t./5).*sin(k.*w.*t);
    bk = integral(f2,-(T/2),T/2);
    bk = 2 * bk / T;
end