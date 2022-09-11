%%短音频特征矩阵增长,使所有特征矩阵维数相同
maxLength=length(TrainingFeatures{1});
for i=1:length(TrainingFeatures)
    if length(TrainingFeatures{i})>maxLength
        maxLength=length(TrainingFeatures{i});
    end;
end;
for n=1:length(TrainingFeatures)
    originLength=length(TrainingFeatures{n});
    originFeatures=TrainingFeatures{n};
    originLabels=TrainingLabels{n};
    for i=originLength+1:originLength:maxLength-originLength
        TrainingFeatures{n}=[TrainingFeatures{n};originFeatures];
        TrainingLabels{n}=[TrainingLabels{n};originLabels];
    end; %将特征矩阵增长到至少最长音频的1/2
end;

minLength=length(TrainingFeatures{1});
for i=1:length(TrainingFeatures)
    if length(TrainingFeatures{i})<minLength
        minLength=length(TrainingFeatures{i});
    end;
end;
for n=1:length(TrainingFeatures)
    TrainingFeatures{n}=TrainingFeatures{n}(1:minLength,:);
    TrainingLabels{n}=TrainingLabels{n}(1:minLength,:);
end; %将特征矩阵长度统一

save pre_input.mat;

