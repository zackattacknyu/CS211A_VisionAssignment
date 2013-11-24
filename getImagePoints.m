function [imagePoints] = getImagePoints(imagename,colorValues,range)
%gets the imagePoints for each of the colors

fileID = fopen(colorValues, 'r');
dataPoints = fscanf(fileID, '%d');

color1 = [];
color2 = [];
color3 = [];
color4 = [];
color5 = [];
color6 = [];
colors = {color1,color2,color3,color4,color5,color6};



index = 1;
for i = 1:3:16
    colors{index} = [dataPoints(i), dataPoints(i+1), dataPoints(i+2)];
    index = index + 1;
end

image = imread(imagename);
imageSize = size(image);
matchingPoints = cell(1,6);
imagePoints = cell(1,6);


for row = 1:imageSize(1)
    if mod(row,500) == 0
        row
    end
    for col = 1:imageSize(2)
        for color = 1:6
            
            matchingLayers = 0;
            for layer = 1:3
                
                if (image(row,col,layer) >= (colors{color}(layer) - range)) && ...
                        (image(row,col,layer) <= (colors{color}(layer) + range))
                    
                    %it is in the range!
                    matchingLayers = matchingLayers + 1;
                    
                end
            end
            
            if matchingLayers == 3     
                matchingPoints{color} = [matchingPoints{color}; [row,col]];                
            end
            
        end
    end
end


for color=1:length(matchingPoints)
    % Reversing the order of the columns to achieve output
    % in x,y form instead of y,x form
    imagePoints{color} = [median(matchingPoints{color}(1:end,2)),...
        median(matchingPoints{color}(1:end,1))];
end

