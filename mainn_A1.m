%%%%%Main Program%%%%%%%
% % clear all;close all;clc

% % % inseq = {'AF008216.1','AF348525.1','NM_016346.3','NM_005732.3','AF348515.1','NM_012403.1','AF083883','AF186607.1','AF186613.1','AF007546'};
% % % code = [4453,5157,1,1302,1191,2108,402,4340,1,2145,1,705,1322,1450,1210,1301,1209,1300,1475,1603];

t = readtable('retina_input.xls');
inseq = t{1:1075,{'Sequence'}};
ini_code = t{1:1075,{'Initial'}};
fin_code = t{1:1075,{'Final'}};

fprintf('SlNo\tSequence\t\t\tMean_amp\t\tMean_freq\t\tRatio\t\tResult\t\tsplitTime\t\tnewffttime\t\tspeed_eff\t\tSpeed_imp\n');

j=1;k=2;
Table = cell(1076, 10); %cells are more versatile than matrix as tables
for i = 1:1075

% % % initial = code(j);
% % % final = code(k);
initial = ini_code(i);
final = fin_code(i);
    [my_max,myfreq_max,ratio,time_DIT_FFT_split,time_new_FFT,eff_DIT_FFT,a_improvement] = seqfunc_a1(inseq(i),initial,final);
    if (ratio < 1 )
        result(i) = 0;
    else
        result(i) = 1;
    end
    Table(i, :) = {i  char(inseq(i)) my_max myfreq_max ratio result(i) time_DIT_FFT_split time_new_FFT eff_DIT_FFT  a_improvement};
    fprintf('%d\t\t%s\t\t\t%f\t\t%f\t\t%f\t\t\t%d\t\t%f\t\t %f\t\t%f\t\t\t%f\n', Table{i, :});
    %mytable(i,:) = table(i,char(inseq(i)),mean,freq,ratio,mystd,myfreqstd,ratiostd,diff,addi);
% % %     j= j+2;
% % %     k=k+2;
end
T=cell2table(Table);
writetable(T,'retina_output_my.xls');
Tp = readtable('retina_output_my','Range','F2:F1075','ReadVariableNames',false);
Tpredict = Tp{:,:};
T1 = readtable('retina_ref.xls','Range','E2:E1075','ReadVariableNames',false);
Tactual = T1{:,:};
Cf = cfmatrix2(Tpredict, Tactual, [0 1], 0, 1);
%%%%%End of main Program%%%%%%
