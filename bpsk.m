clear;close all;clc;

N=100000;
SNRdb=-10:2:25

ber_BPSK=[];
for i = 1: numel(SNRdb)
    bitsTX=randi([0 1],1,N);
    symbolTX=bitsTX;
    symbolTX(symbolTX==0)=-1;
    noise = (randn(size(symbolTX)) + 1i*randn(size(symbolTX)))/sqrt(2);
    SNR=10^(SNRdb(i)/10);
    sigma=sqrt(SNR);
    symbolRX=sigma.*symbolTX+noise;
    bitsRX=(symbolRX>0);
    NOE=sum(bitsTX~=bitsRX);
    ber1=NOE/N;
    ber_BPSK=[ber_BPSK ber1];
end

BER=[];
for i = 1: numel(SNRdb)
    symbolTX=[];
bitsTX = rand(1,N)>0.5;
for k=1:2:N
    if bitsTX(k)==0 && bitsTX(k+1)==0
        y=cosd(225)+j*sind(225);
    elseif bitsTX(k)==0 && bitsTX(k+1)==1
        y=cosd(135)+j*sind(135);
    elseif bitsTX(k)==1 && bitsTX(k+1)==0
        y=cosd(315)+j*sind(315);
    elseif bitsTX(k)==1 && bitsTX(k+1)==1
        y=cosd(45)+j*sind(45);
    end
    symbolTX=[symbolTX y];
end
    SNR=10^(SNRdb(i)/10);
    sigma=sqrt(SNR);
    noise = (randn(size(symbolTX)) + 1i*randn(size(symbolTX)))/sqrt(2);
    symbolRX = sigma*symbolTX + noise;
    I=(real(symbolRX)>0);
    Q=(imag(symbolRX)>0);
    bitsRX=[];
    for i=1:length(symbolTX)
        bitsRX=[bitsRX I(i) Q(i)];
    end
    NOE=sum(bitsTX~=bitsRX);
    BER1=NOE/N;
    BER=[BER BER1];
end


semilogy(SNRdb,ber_BPSK,'r*-',SNRdb,BER,'bo-');
xlabel('SNR');
ylabel('BER');
legend('BPSK','QPSK');
grid on;
