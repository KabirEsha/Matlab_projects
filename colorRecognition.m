function colorRecognition()
    [filename, pathname] = uigetfile({'*.jpg;*.png;*.jpeg', 'Image Files (*.jpg, *.png, *.jpeg)'}, 'Select an image');
    if isequal(filename, 0) || isequal(pathname, 0)
        disp('User canceled the operation');
        return;
    end
    
    fullPath = fullfile(pathname, filename);
    img = imread(fullPath);
    
    img = im2double(img);
    
    pixel = reshape(img, [], 3);
    
    colors = {
        'Red'     [0.5 0 0; 1 0.2 0.2];
        'Green'   [0 0.5 0; 0.2 1 0.2];
        'Blue'    [0 0 0.5; 0.2 0.2 1];
        'Yellow'  [0.5 0.5 0; 1 1 0.2];
        'Cyan'    [0 0.5 0.5; 0.2 1 1];
        'White'   [0.8 0.8 0.8; 1 1 1];
        'Black'   [0 0 0; 0.2 0.2 0.2];
    };
    
    colorCounts = zeros(size(colors, 1), 1);
    
    for i = 1:size(colors, 1)
        colorRange = colors{i, 2};
        colorMask = all(pixel >= colorRange(1,:) & pixel <= colorRange(2,:), 2);
        colorCounts(i) = sum(colorMask);
    end
    
    totalPixel = size(pixel, 1);
    colorPercentages = (colorCounts / totalPixel) * 100;
    
    figure('Name', 'Color Recognition Results', 'NumberTitle', 'off');
    
  
    subplot(1, 2, 1);
    imshow(img);
    title('Original Image');
    
    subplot(1, 2, 2);
    barh(colorPercentages);
    yticks(1:length(colors));
    yticklabels(colors(:,1));
    xlabel('Percentage');
    title('Color Distribution');
    
  
    for i = 1:length(colorPercentages)
        if colorPercentages(i) > 0
            text(colorPercentages(i), i, sprintf('%.1f%%', colorPercentages(i)), ...
                'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle');
        end
    end
    
  