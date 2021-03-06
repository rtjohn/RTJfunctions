AFQdata = '/Users/Ryan/Documents/MATLAB/AFQ/APPdata';

% doesn't have FA values but has curve values?
sub_dirs = {[AFQdata '/Preupgrades/105782-100/dti30']...
[AFQdata '/Preupgrades/106802-100/dti30']...
[AFQdata '/Preupgrades/107655-100/dti30']...
[AFQdata '/Preupgrades/107841-100/dti30']...
[AFQdata '/Preupgrades/106972-100/dti30']...
[AFQdata '/Preupgrades/106422-100/dti30']...
[AFQdata '/Preupgrades/106162-100/dti30']...
[AFQdata '/Preupgrades/106431-200/dti30']...
[AFQdata '/Preupgrades/107665-100/dti30']...
[AFQdata '/Preupgrades/107899-200/dti30']...
[AFQdata '/Preupgrades/106971-100/dti30']...
[AFQdata '/Preupgrades/108104-100/dti30']...
[AFQdata '/Preupgrades/108229-100/dti30']...
[AFQdata '/Preupgrades/108070-100/dti30']...
[AFQdata '/Preupgrades/108010-100/dti30']...
[AFQdata '/Preupgrades/106994-100/dti30']...
[AFQdata '/Preupgrades/107694-100/dti30']...
[AFQdata '/Preupgrades/108270-100/dti30']...
[AFQdata '/Preupgrades/107674-201/dti30']...
[AFQdata '/Preupgrades/106826-100/dti30']...
[AFQdata '/Preupgrades/107735-100/dti30']...
[AFQdata '/Preupgrades/107738-100/dti30']...
[AFQdata '/Preupgrades/106947-100/dti30']...
[AFQdata '/Preupgrades/107320-100/dti30']...
[AFQdata '/Preupgrades/107642-100/dti30']...
[AFQdata '/Preupgrades/101939-200/dti30']...
[AFQdata '/Preupgrades/107560-100/dti30']...
[AFQdata '/Preupgrades/108246-100/dti30']...
[AFQdata '/Preupgrades/107691-201/dti30']...
[AFQdata '/Preupgrades/107561-100/dti30']...
[AFQdata '/Preupgrades/107629-100/dti30']...
[AFQdata '/Preupgrades/106032-100/dti30']...
[AFQdata '/Preupgrades/107705-100/dti30']...
[AFQdata '/Preupgrades/108130-100/dti30']...
[AFQdata '/Preupgrades/107406-100/dti30']...
[AFQdata '/Preupgrades/103655-200/dti30']...
[AFQdata '/Preupgrades/107935-100/dti30']...
[AFQdata '/Preupgrades/106648-100/dti30']...
[AFQdata '/Preupgrades/107764-100/dti30']...
[AFQdata '/Preupgrades/107990-100/dti30']...
[AFQdata '/Preupgrades/106579-100/dti30']...
[AFQdata '/Preupgrades/107453-100/dti30']...
[AFQdata '/Preupgrades/107475-100/dti30']...
[AFQdata '/Preupgrades/107472-100/dti30']...
[AFQdata '/Preupgrades/106993-100/dti30']...
[AFQdata '/Preupgrades/105850-100/dti30']...
[AFQdata '/Preupgrades/107753-100/dti30']...
[AFQdata '/Preupgrades/107187-100/dti30']...
[AFQdata '/Preupgrades/101314-200/dti30']...
[AFQdata '/Preupgrades/106845-100/dti30']...
[AFQdata '/Preupgrades/107547-100/dti30']...
[AFQdata '/Preupgrades/107205-100/dti30']...
[AFQdata '/Preupgrades/105843-201/dti30']...
[AFQdata '/Preupgrades/106675-100/dti30']...
[AFQdata '/Preupgrades/106687-200/dti30']...
[AFQdata '/Preupgrades/105966-100/dti30']...
[AFQdata '/Preupgrades/106591-100/dti30']...
[AFQdata '/Preupgrades/107183-100/dti30']...
[AFQdata '/Preupgrades/107004-100/dti30']...
[AFQdata '/Preupgrades/106970-100/dti30']...
[AFQdata '/Preupgrades/106677-100/dti30']...
[AFQdata '/Preupgrades/107671-100/dti30']...
[AFQdata '/Preupgrades/106740-100/dti30']...
[AFQdata '/Preupgrades/104803-100/dti30']...
[AFQdata '/Preupgrades/106420-100/dti30']...
[AFQdata '/Preupgrades/107443-100/dti30']...
[AFQdata '/Preupgrades/107708-100/dti30']...
[AFQdata '/Preupgrades/108297-100/dti30']...
[AFQdata '/Preupgrades/107609-100/dti30']...
[AFQdata '/109632-100/dti30']...
[AFQdata '/109771-100/dti30']...
[AFQdata '/109994-100/dti30']...
[AFQdata '/109775-100/dti30']...
[AFQdata '/109556-100/dti30']...
[AFQdata '/109232-100/dti30']...
[AFQdata '/110198-100/dti30']...
[AFQdata '/109012-100/dti30']...
[AFQdata '/108644-100/dti30']...
[AFQdata '/108471-100/dti30']...
[AFQdata '/109807-100/dti30']...
[AFQdata '/109272-100/dti30']...
[AFQdata '/108703-100/dti30']...
[AFQdata '/109882-100/dti30']...
[AFQdata '/109678-100/dti30']...
[AFQdata '/108681-100/dti30']...
[AFQdata '/109724-100/dti30']...
[AFQdata '/107965-100/dti30']...
[AFQdata '/109507-100/dti30']...
[AFQdata '/109937-100/dti30']...
[AFQdata '/109975-100/dti30']...
[AFQdata '/109868-100/dti30']...
[AFQdata '/109617-100/dti30']...
[AFQdata '/108598-100/dti30']...
[AFQdata '/109543-100/dti30']...
[AFQdata '/108923-100/dti30']...
[AFQdata '/109517-100/dti30']...
[AFQdata '/108370-100/dti30']...
[AFQdata '/108904-100/dti30']...
[AFQdata '/109119-100/dti30']...
[AFQdata '/109920-100/dti30']...
[AFQdata '/108602-100/dti30']...
[AFQdata '/109855-100/dti30']...
[AFQdata '/109693-100/dti30']...
[AFQdata '/108679-100/dti30']...
[AFQdata '/109709-100/dti30']...
[AFQdata '/108567-100/dti30']...
[AFQdata '/108881-100/dti30']...
[AFQdata '/108676-100/dti30']...
[AFQdata '/108500-100/dti30']...
[AFQdata '/108546-100/dti30']...
[AFQdata '/109712-100/dti30']...
[AFQdata '/109600-100/dti30']...
[AFQdata '/109138-100/dti30']...
[AFQdata '/108913-100/dti30']...
[AFQdata '/108965-100/dti30']...
[AFQdata '/108706-100/dti30']...
[AFQdata '/110024-100/dti30']...
[AFQdata '/108670-100/dti30']...
[AFQdata '/109075-100/dti30']...
[AFQdata '/108698-100/dti30']...
[AFQdata '/110116-100/dti30']...
[AFQdata '/109651-100/dti30']...
[AFQdata '/108396-100/dti30']...
[AFQdata '/108738-100/dti30']...
[AFQdata '/109295-100/dti30']...
[AFQdata '/109092-100/dti30']...
[AFQdata '/108570-201/dti30']...
[AFQdata '/110021-100/dti30']...
[AFQdata '/108792-100/dti30']...
[AFQdata '/109470-100/dti30']...
[AFQdata '/109956-100/dti30']...
[AFQdata '/109054-100/dti30']...
[AFQdata '/108990-100/dti30']...
[AFQdata '/108916-100/dti30']...
[AFQdata '/108444-100/dti30']...
[AFQdata '/109166-100/dti30']...
[AFQdata '/109455-100/dti30']...
[AFQdata '/110023-100/dti30']...
[AFQdata '/108910-100/dti30']...
[AFQdata '/108920-100/dti30']...
[AFQdata '/110074-100/dti30']...
[AFQdata '/108369-100/dti30']...
[AFQdata '/108376-100/dti30']...
[AFQdata '/108486-100/dti30']...
[AFQdata '/109921-100/dti30']...
[AFQdata '/109493-100/dti30']...
[AFQdata '/110052-100/dti30']...
[AFQdata '/108846-100/dti30']...
[AFQdata '/109087-100/dti30']...
[AFQdata '/109434-100/dti30']...
[AFQdata '/109568-100/dti30']...
[AFQdata '/108477-100/dti30']...
[AFQdata '/108637-100/dti30']...
[AFQdata '/109703-100/dti30']...
[AFQdata '/109733-100/dti30']...
[AFQdata '/108678-100/dti30']...
[AFQdata '/108243-300/dti30']...
[AFQdata '/108970-100/dti30']...
[AFQdata '/109531-100/dti30']...
[AFQdata '/109810-100/dti30']...
[AFQdata '/108590-100/dti30']...
[AFQdata '/108755-100/dti30']...
[AFQdata '/109441-200/dti30']...
[AFQdata '/108367-100/dti30']};

numNodes = 100;
numCells = length(sub_dirs);
curvGroup = zeros(numCells,numNodes);
torsGroup = zeros(numCells,numNodes);
FGnotempty = zeros(numCells,numNodes);

for kk = 1:length(sub_dirs);
    fg = dtiReadFibers(fullfile(sub_dirs{kk},'fibers','MoriGroups_clean_D5_L4.mat'));
    FGnotempty(kk) = ~isempty(fg(19).fibers);
end
FGnotempty = find(FGnotempty)';

for xx = 1:length(FGnotempty)
    yy = FGnotempty(xx);
    dt = dtiLoadDt6(fullfile(sub_dirs{yy},'dt6.mat'));
    fg = dtiReadFibers(fullfile(sub_dirs{yy},'fibers','MoriGroups_clean_D5_L4.mat')); 
    [curvWA torsWA TractProfile] = AFQ_ParamaterizeTractShape(fg(19));
    curvSingle = (curvWA)';
    torsSingle = (torsWA)';
    curvGroup(yy,:) = curvSingle;
    torsGroup(yy,:) = torsSingle;
end

% for zz = 1:105(sub_dirs);
%     list1(zz,:) = sub_dirs{zz}(42:51)
% end
% for nn = 106:190(sub_dirs);
%     list2(nn,:) = sub_dirs{nn}(54:63)
% end
%    
% fullist = vertcat(list1,list2);