clear all
clc

% 使用一些关键参数描述这些梯形波信号
% 频率为1KHz，周期为T，上升时间为T/10，下降时间同样为T/10,初始化时间内信号为0
% 幅值为A，
f = 25e6;
T = 1/f;
A = 1;
T_rsie = T*(5/40);
T_fall = T*(5/40);
T_init = 1e-3;
t0 = 0;
t1 = (T-T*2/10) / 2;
t2 = t1 + T/10;
t3 = t2 + t1;
t4 = T;

%  生成线性序列
t = linspace(0,5e-7,2^12);

%计算梯形波信号
y = zeros(size(t));
for i = 1:length(t)
    tn = mod(t(i),T);
    if t0 <= tn && tn < t1
        y(i) = 0;
    elseif t1 <= tn && tn < t2
        y(i) = A * (tn - t1) / T_rsie;
    elseif t2 <= tn && tn < t3
        y(i) = A;
    elseif t3 <= tn && tn < t4
        y(i) = A * (1 - (tn - t3) / T_fall);
    end

    if y(i) > A
        y(i) = A;
    elseif y(i) < 0
        y(i) = 0;
    end
end 

%绘制波形
plot(t,y);
xlabel('time(s)');
ylabel('amplify');
title('periodic trapezoidal wave');

