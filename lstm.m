load('data.mat')
XTrain_pre=TrainingFeatures(1:4500,:);
XTrain=cell(4500,1);
for i=1:4500
    XTrain{i}=cell2mat(XTrain_pre(i)).';
end
YTrain=label_set(1:4500,:);
XTest_pre=TrainingFeatures(4501:5000,:);
XTest=cell(500,1);
for i=1:500
    XTest{i}=cell2mat(XTest_pre(i)).';
end
YTest=label_set(4501:5000,:);
inputSize = 13;
numHiddenUnits = 384;
numClasses = 5;

layers = [ ...
    sequenceInputLayer(inputSize)
    lstmLayer(numHiddenUnits,'OutputMode','last')
    dropoutLayer(0,"Name","dropout")
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

maxEpochs = 150;
miniBatchSize = 27;

options = trainingOptions('adam', ...
    'ExecutionEnvironment','cpu', ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'GradientThreshold',1, ...
    'Verbose',false, ...
    'Plots','training-progress');
net=trainNetwork(XTrain,YTrain,layers, options);
YPred = classify(net,XTest, ...
    'MiniBatchSize',miniBatchSize, ...
    'SequenceLength','longest');
acc = sum(YPred == YTest)./numel(YTest)