rng(547)

%run the fitting before this.

blk=[10,10,10]/256;

n=4
figure(1); clf; 
set(gcf, 'position',[2000 100  468   800])
% set(gcf, 'position',[440   504   468   400])
% ax = easy_gridOfEqualFigures([0.1 0.1,.1,.1,.1], [.1 0.1]);
ax = easy_gridOfEqualFigures([.08,.08,.08,.08,.08], [.1 0.1]);
%  ax = easy_gridOfEqualFigures([0.11 0.19 0.07], [0.12 0.16 0.04]);

axes(ax(1)); hold on;
%plot parameters
texlabel= {"$m_{t=0}$" "$m_{t=1}$" "$m_{t=2}$" "$\\alpha$" "$A$"};
colorspec  = {[AZblue*0.2+0.5] [AZblue*0.3+0.3] [AZblue] [AZred]};
x = [0:.1:10];
m=[2 4 6 8];
sigma=[.5 .75 1 .4];

for i =1:n
    y = normpdf(x,m(i),sigma(i));
    plot(x,y, 'Color',colorspec{i},'linewidth', 2)
    text(m(i)-.2, max(y)+.15, sprintf(texlabel{i}),'FontSize',16, 'interpreter', 'latex','margin', 1,'color',colorspec{i})     
    mxy(i,:)=[m(i) max(y)+.35]
    if (texlabel{i} == '$\\alpha$')
        foo=randsample(y,1)
        idx=find(abs(y - foo)<=10^-5)
        A= [0 foo]
        plot([x(idx(2)) x(idx(2))],A, 'Color',colorspec{i},'linewidth', 3)
        text(x(idx(2)), max(A)+.1, sprintf(texlabel{i+1}),'FontSize',16, 'interpreter', 'latex','margin', 1,'color',colorspec{i} )   
    end
end


X = {[.30 .38] [.45 .53]};
Y = {[.898  .898] [.87  .87]};
vlabel= {"$d_{0}$" "$d_{1}$"}
for i =1:2
    annotation('arrow',X{i},Y{i},'Color', colorspec{i})
    text((m(i)-.5 +m(i+1)-.5)/2, mxy(i,2)+.15, sprintf(vlabel{i}),'FontSize',16, 'interpreter', 'latex','margin', 1,'color', colorspec{i}) 
end

set(gca,'xtick',[])
set(gca,'ytick',[])
% fancy_xlabel_v1({'Degrees Rotated ' ' '},2,14)
fancy_ylabel_v1({'Probability' ''}, 2, 14)
set(title('No Feedback'), 'fontsize', 16, 'fontweight', 'normal')
set(ax, 'fontsize', 11, 'ylim', [0 1.4])

%%
axes(ax(2)); hold on;
%plot parameters
texlabel= {"$m_{t_f}$" "$f$" "$m_{t_f+1}$" "$\\alpha$" "$A$"};
colorspec  = {[AZblue] [AZcactus] [blk] [AZred]};
x = [0:.1:10];

sigma_mf=.5;
sigma_f=.5;
mf=2;
f=5;

X = [1 1 1 0 .25 1 1 sigma_f .9];
[mf1 sigma_mf1]=compute_pureKalmanFilter_v1( X, 6, f, mf )
mf1=mf1+mf
m=[mf f mf1 8];
sigma=[sigma_mf sigma_f sqrt(sigma_mf1) .4];

for i =1:n
    y = normpdf(x,m(i),sigma(i));
    plot(x,y, 'Color',colorspec{i},'linewidth', 2)
    text(m(i)-.2, max(y)+.15, sprintf(texlabel{i}),'FontSize',16, 'interpreter', 'latex','margin', 1,'color',colorspec{i} )   
    mxy(i,:)=[m(i) max(y)+.35]
    if (texlabel{i} == "$\\alpha$")
%         foo=randsample(y,1)
%         idx=find(abs(y - foo)<=10^-5)
%         y= [0 foo]
        plot([x(idx(2)) x(idx(2))],A, 'Color',colorspec{i},'linewidth', 3)
        text(x(idx(2)), max(foo)+.1, sprintf(texlabel{i+1}),'FontSize',16, 'interpreter', 'latex','margin', 1,'color',colorspec{i} )   
    end
end


X = [.37 .45];
Y = [.665  .665];
annotation('arrow',X,Y,'Color', colorspec{1})
text((m(1)-.5 +m(2+1)-.5)/2, mxy(3,2)+.15, sprintf("$d_{f}$"),'FontSize',16, 'interpreter', 'latex','margin', 1,'color', colorspec{1}) 


set(gca,'xtick',[])
set(gca,'ytick',[])
% fancy_xlabel_v1({'Degrees Rotated ' ' '},2,14)
fancy_ylabel_v1({'Probability' ''}, 2, 14)
set(title('Pure Kalman Filter'), 'fontsize', 16, 'fontweight', 'normal')

%%
n=6
axes(ax(3)); hold on;
%plot parameters
texlabel= {"$m_{t_f}$" "${f}$" "" "" "" "$\\alpha$" "$A$"};
colorspec  = {[AZblue] [AZcactus] [blk/0.1] [blk/0.2] [blk] [AZred]};
x = [0:.1:10];



m=[mf f];
sigma=[sigma_mf sigma_f];
prob=[.1 .5 1];
for j= 1:3
 
X = [1 1 1 0 .25  1 1 sigma_f prob(j)];
[m(j+2) sigma(j+2)]=compute_averaging_v1( X, 6,1, f, mf )
sigma(j+2)=sqrt(sigma(j+2))
m(j+2)=m(j+2)+mf
end
m(length(m)+1)=8;
sigma(length(sigma)+1)=.4;

for i =1:n
    y = normpdf(x,m(i),sigma(i));
    if any(i==3:4)
          plot(x,y, 'Color',colorspec{i},'linewidth', 2,'LineStyle','--') 
    else
          plot(x,y, 'Color',colorspec{i},'linewidth', 2) 
    end
    text(m(i)-.2, max(y)+.2, sprintf(texlabel{i}),'FontSize',16, 'interpreter', 'latex','margin', 1,'color',colorspec{i} )   
    mxy(i,:)=[m(i) max(y)+.3]
    if (texlabel{i} == "$\\alpha$")
%         foo=randsample(y,1)
%         idx=find(abs(y - foo)<=10^-5)
%         y= [0 foo]
        plot([x(idx(2)) x(idx(2))],A, 'Color',colorspec{i},'linewidth', 3)
        text(x(idx(2)), max(foo)+.1, sprintf(texlabel{i+1}),'FontSize',16, 'interpreter', 'latex','margin', 1,'color',colorspec{i} )   
    end
end

text(mxy(5,1)-.2,mxy(5,2), sprintf("$m_{t_f+1}$"),'FontSize',16, 'interpreter', 'latex','margin', 1,'color',blk)   
text(mxy(3,1)-.2, mxy(3,2)-.2, sprintf("$.1$"),'FontSize',12, 'interpreter', 'latex','margin', 1,'color',colorspec{3} )
text(mxy(4,1)-.2, mxy(4,2)-.2, sprintf("$.5$"),'FontSize',12, 'interpreter', 'latex','margin', 1,'color',colorspec{4} )
text(mxy(5,1), mxy(5,2)-.2, sprintf("$1$"),'FontSize',12, 'interpreter', 'latex','margin', 1,'color',blk )


X = [.37 .45];
Y = [.44  .44];
annotation('arrow',X,Y,'Color', colorspec{1})
text((m(1)-.5 +m(4+1)-.5)/2, mxy(4,2)+.25, sprintf("$d_{f}$"),'FontSize',16, 'interpreter', 'latex','margin', 1,'color', colorspec{1}) 



set(gca,'xtick',[])
set(gca,'ytick',[])
% fancy_xlabel_v1({'Degrees Rotated ' ' '},2,14)
fancy_ylabel_v1({'Probability' ''}, 2, 14)
set(title('Averaging'), 'fontsize', 16, 'fontweight', 'normal')
set(ax, 'fontsize', 11, 'ylim', [0 1.4])
%%

n=5
axes(ax(4)); hold on;
%plot parameters
texlabel= {"$m_{t_f}$" "$f$" "" "" "$\\alpha$" "$A$"};
colorspec  = {[AZblue] [AZcactus] [blk] [blk] [AZred]};
x = [0:.1:10];



m=[mf f];
sigma=[sigma_mf sigma_f];


 
X = [1 1 1 0 .25 1 1 sigma_f .9];
[m(3:4) sigma(3:4)]=compute_sampling_v1( X, 6,1, f, mf )

sigma(3:4)=sqrt(sigma(3:4))  
m(3:4)=m(3:4)+mf
m(length(m)+1)=8;
sigma(length(sigma)+1)=.4;

for i =1:n
    y = normpdf(x,m(i),sigma(i));
    plot(x,y, 'Color',colorspec{i},'linewidth', 2)
    text(m(i)-.2, max(y)+.15, sprintf(texlabel{i}),'FontSize',16, 'interpreter', 'latex','margin', 1,'color',colorspec{i} ) 
    
    mxy(i,:)=[m(i) max(y)+.25]
    if (texlabel{i} == "$\\alpha$")
%         foo=randsample(y,1)
%         idx=find(abs(y - foo)<=10^-5)
%         y= [0 foo]
        plot([x(idx(2)) x(idx(2))],A, 'Color',colorspec{i},'linewidth', 3)
        text(x(idx(2)), max(foo)+.15, sprintf(texlabel{i+1}),'FontSize',16, 'interpreter', 'latex','margin', 1,'color',colorspec{i} )   
    end
end
% 

text(mxy(3,1)-.2,mxy(3,2)+.05, sprintf("$m_{t_f+1}$"),'FontSize',16, 'interpreter', 'latex','margin', 1,'color',blk)   
text(mxy(3,1)-.3,mxy(3,2)-.15, sprintf("$(false)$"),'FontSize',12, 'interpreter', 'latex','margin', 1,'color',blk)   
text(mxy(4,1)-.2,mxy(4,2)+.05, sprintf("$m_{t_f+1}$"),'FontSize',16, 'interpreter', 'latex','margin', 1,'color',blk)   
text(mxy(4,1)-.3, mxy(4,2)-.15, sprintf("$(true)$"),'FontSize',12, 'interpreter', 'latex','margin', 1,'color',blk )

X = [.37 .45];
Y = [.20  .20];
annotation('arrow',X,Y,'Color', colorspec{1})
text((m(1)-.5 +m(3+1)-.5)/2, mxy(4,2)+.2, sprintf("$d_{f}$"),'FontSize',16, 'interpreter', 'latex','margin', 1,'color', colorspec{1}) 

set(title('Sampling'), 'fontsize', 11, 'fontweight', 'normal')
set(ax, 'fontsize', 16, 'ylim', [0 1.4])
set(gca,'xtick',[])
set(gca,'ytick',[])
fancy_xlabel_v1({'Degrees Rotated ' ' '},2,14)
fancy_ylabel_v1({'Probability' ''}, 2, 14)

addABCs(ax, [-0.06 0.07], 24)

saveFigurePdf(gcf, 'IntroModel3')