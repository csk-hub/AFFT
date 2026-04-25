function[my_max,myfreq_max,ratio,time_DIT_FFT_split,time_new_FFT,eff_DIT_FFT,a_improvement] = seqfunc_a1(inseq,i,j)
inseq = char(inseq);
warning off;
%%%<-------STEP1----->%%%%
sample_dna = getgenbank(inseq,'SequenceOnly',true);
i=1;
j = length(sample_dna);

bin_dna_seq = dna_binary1(sample_dna); 
%%%<-------STEP2----->%%%%

t=  bin_dna_seq;
Afft_split = split(t);
Afft_new_fft = myfft(t);
y = @(t)t;
[time_DIT_FFT_split] = compute_time_FFT_split(y(t));
[time_new_FFT] = compute_time_new_FFT(y(t));
eff_DIT_FFT = (1- (time_new_FFT/time_DIT_FFT_split))*100;
a_improvement = (time_DIT_FFT_split - time_new_FFT)*100;
%sa=sprintf('The NEW_FFT algorithm  is %f percent faster than DIT FFT split radix algorithm for computing SeqA',eff_DIT_FFT)


dna_fft = fft(bin_dna_seq);
dna_fft = dna_fft(i:j);

%dna_fft = Afft_new_fft(i:j);
%%%%<-----STEP3---->%%%%
[pxx,w]= periodogram(dna_fft);


%%%%%neeeded%%%%
% figure(1)
% plot(w,pxx)

myrms = rms(pxx);
%%%%%neeeded%%%%
% figure(2)
% plot(w,pxx/myrms)



%%%%%<----Step4---->>%%%
n = 10;
Wn = 0.3607;
[b,a] = butter(n,Wn);


%%%%<----Step5----->%%%
pxx2 = pxx/myrms;
m1dataOut = filter(b,a,pxx2);

%%%%%neeeded%%%%
% figure(3)
% plot(w,m1dataOut)
% figure(4)
% plot(w,abs(m1dataOut))

[my_max, index] = max(abs(m1dataOut));
myfreq_max = w(index);
ratio = my_max/myfreq_max;

[my_std,indstd]=max(abs(std(m1dataOut)));
myfreq_stdmax = w(indstd);
%myfreq_stdmax = indstd;
ratio_std = my_std/myfreq_stdmax;

diff = my_max - my_std;
addi = my_max + my_std;

