% make_co2_figure.m
% Adaptation of a figure created originally by the Foster Lab (National Oceanography Centre Southampton)
%
% Original figure here: http://www.thefosterlab.org/blog/2015/11/11/is-this-the-last-year-below-400-ppm
% Data from here: http://www.thefosterlab.org/blog/2015/11/17/data-and-r-script-for-plotting-400-ppm-figure
%
% adapted for MATLAB by Kevin Anchukaitis, University of Arizona (http://www.u.arizona.edu/~kanchukaitis/)

% clear the workspace and close any figures
clear; close all; clc;

%% read in the data
% ice core data from Bereiter et al., (2015), Geophysical Research Letters, doi:10.1002/2014GL061957
epica = textread('EPICA_1.txt','','headerlines',1);

% Pliocene boron data from Martinez-Boti et al. (2015), Nature, doi:10.1038/nature14145
pliocene = textread('Pliocene.txt','','headerlines',1);

% Pleistocene boron data from Hoenisch et al. (2009), Science, DOI: 10.1126/science.1171477, uncertainty from Foster Lab code
hoenisch = textread('Hoenisch.txt','','headerlines',1);

% Annual mean Mauna Loa (not part of the original figure) from: ftp://aftp.cmdl.noaa.gov/products/trends/co2/co2_annmean_mlo.txt
mlo = textread('co2_annmean_mlo.txt','','headerlines',57);

% some plotting defaults
set(0, 'DefaultAxesFontName', 'Helvetica'); %,'DefaultAxesFontWeight','bold')
set(0, 'DefaultTextFontName', 'Helvetica'); % ,'DefaultTextFontWeight','bold')  
set(0,'defaultaxesfontsize',14); set(0,'defaulttextfontsize',14);

% first, as plotted by the Foster Lab ...
figure(1); clf;
set(gcf,'units','normalized','position',[0.30 0.50 0.64 0.40]); hold on
plot((1950-mlo(:,1))./1000,mlo(:,2),'color',[1 0.2 0.2]); hold on;
fill([pliocene(:,1); flipud(pliocene(:,1))],[pliocene(:,3);flipud(pliocene(:,6))],[0.80 0.80 1],'linestyle','none')
plot([-100 3300],[400 400],'r-','linewidth',2)
errorbar(hoenisch(:,1),hoenisch(:,2),repmat(30,size(hoenisch(:,1))),'bo','markerfacecolor',[0 .01 .96],'markersize',12,'linewidth',1.25); hold on;
plot(hoenisch(:,1),hoenisch(:,2),'ko','markersize',12,'linewidth',1.5)
plot(epica(:,1),epica(:,2),'r','linewidth',1.5);
scatter(pliocene(:,1),pliocene(:,2),180,'wo','markerfacecolor',[0 .01 .96]);
text(-50,425,'400 ppm','color','r','fontsize',18,'fontangle','italic')

% draw the Pleistocene-Pliocene boundary at 2.58Ma and end the Pleistocene at 0.0117Ma (http://www.stratigraphy.org/index.php/ics-chart-timescale)
rectangle('position',[-100 500 2580+100 50],'FaceColor','white','linewidth',1.5)
rectangle('position',[2580 500 3300-(2580) 50],'FaceColor','white','linewidth',1.5)

% text and arrows for Pleistocene-Pliocene
text(2075,525,'PLEISTOCENE')
quiver(2050,525,-150,0,'color','k')
text(2645,525,'PLIOCENE')
quiver(3000,525,150,0,'color','k')

% label the data series
text(150,375,'Bereiter et al. (2015)','color','r')
text(1200,345,'Hönisch et al. (2009)','color','b')
text(2400,185,'Martinez-Botí et al. (2015)','color',[0.20 0.20 1])

xlim([-100 3300]); ylim([150 550])
set(gca,'ytick',[150:50:500],'xminortick','on','yminortick','on','box','on')
xlabel('AGE (thousands of years before present)')
ylabel('ATMOSPHERIC CO_{2} (ppm)')

% printeps('co2.eps',1) % local function, use commands below for distribution
set(1, 'PaperPositionMode', 'auto');
print('-depsc2', '-noui', '-painters', ['-f' num2str(1)], '-r864', ['co2.eps']);

% second, with the present on the righthand side of the graph 
figure(2); clf;
set(gca,'xdir','reverse')
set(gcf,'units','normalized','position',[0.30 0.50 0.64 0.40]); hold on
plot((1950-mlo(:,1))./1000,mlo(:,2),'color',[1 0.2 0.2]); hold on;
fill([pliocene(:,1); flipud(pliocene(:,1))],[pliocene(:,3);flipud(pliocene(:,6))],[0.80 0.80 1],'linestyle','none')
plot([-100 3300],[400 400],'r-','linewidth',2)
errorbar(hoenisch(:,1),hoenisch(:,2),repmat(30,size(hoenisch(:,1))),'bo','markerfacecolor',[0 .01 .96],'markersize',12,'linewidth',1.25); hold on;
plot(hoenisch(:,1),hoenisch(:,2),'ko','markersize',12,'linewidth',1.5)
plot(epica(:,1),epica(:,2),'r','linewidth',1.5);
scatter(pliocene(:,1),pliocene(:,2),180,'wo','markerfacecolor',[0 .01 .96]);
text(-50,425,'400 ppm','color','r','fontsize',18,'fontangle','italic','horizontalalignment','right')

% draw the Pleistocene-Pliocene boundary at 2.58Ma and end the Pleistocene at 0.0117Ma (http://www.stratigraphy.org/index.php/ics-chart-timescale)
rectangle('position',[0.0117 500 2580+0.0117 50],'FaceColor','white','linewidth',1.5)
rectangle('position',[2580 500 3300-(2580) 50],'FaceColor','white','linewidth',1.5)

text(2050,525,'PLEISTOCENE','horizontalalignment','right')
quiver(2030,525,-150,0,'color','k')
text(2625,525,'PLIOCENE','horizontalalignment','right')
quiver(3000,525,150,0,'color','k')

% label the data series
text(150,375,'Bereiter et al. (2015)','color','r','horizontalalignment','right')
text(1200,345,'Hönisch et al. (2009)','color','b','horizontalalignment','right')
text(2400,185,'Martinez-Botí et al. (2015)','color',[0.20 0.20 1],'horizontalalignment','right')

xlim([-100 3300]); ylim([150 550])
set(gca,'ytick',[150:50:500],'xminortick','on','yminortick','on','box','on')
xlabel('AGE (thousands of years before present)')
ylabel('ATMOSPHERIC CO_{2} (ppm)')

% printeps('co2r.eps',2) % local function, use commands below for distribution
set(2, 'PaperPositionMode', 'auto');
print('-depsc2', '-noui', '-painters', ['-f' num2str(2)], '-r864', ['co2r.eps']);