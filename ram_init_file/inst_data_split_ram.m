clear

% 读取并转换第一份 .pat 文件
filename1 = 'inst.pat'; % 第一份 .pat 文件名
data1 = readPatFile(filename1);

% 读取并转换第二份 .pat 文件
filename2 = 'data.pat'; % 第二份 .pat 文件名
data2 = readPatFile(filename2);

% 初始化16个RAM的内存文件内容，每个RAM文件预留2倍16384的空间（32KB）
ramFiles = cell(16, 1);
for i = 1:16
    ramFiles{i} = repmat({'00'}, 16384 * 2, 1); % 初始化为32KB，填充为'00'
end

% 将第一份 .pat 文件的数据写入RAM文件，起始位置为0
for i = 1:length(data1)
    hexValue = data1{i};
    byte0 = hexValue(1:2);
    byte1 = hexValue(3:4);
    byte2 = hexValue(5:6);
    byte3 = hexValue(7:8);
    
    % 计算RAM的地址索引
    ramIndex = floor((i-1) / 4) + 1;
    
    % 分配数据到RAM
    ramFiles{1 + mod(i-1, 4) * 4}{ramIndex} = byte0;
    ramFiles{2 + mod(i-1, 4) * 4}{ramIndex} = byte1;
    ramFiles{3 + mod(i-1, 4) * 4}{ramIndex} = byte2;
    ramFiles{4 + mod(i-1, 4) * 4}{ramIndex} = byte3;
end

% 将第二份 .pat 文件的数据写入RAM文件，起始位置为16384（0x4000）
for i = 1:length(data2)
    hexValue = data2{i};
    byte0 = hexValue(1:2);
    byte1 = hexValue(3:4);
    byte2 = hexValue(5:6);
    byte3 = hexValue(7:8);
    
    % 计算RAM的地址索引
    ramIndex = floor((i-1) / 4) + 1 + 16384;
    
    % 分配数据到RAM
    ramFiles{1 + mod(i-1, 4) * 4}{ramIndex} = byte0;
    ramFiles{2 + mod(i-1, 4) * 4}{ramIndex} = byte1;
    ramFiles{3 + mod(i-1, 4) * 4}{ramIndex} = byte2;
    ramFiles{4 + mod(i-1, 4) * 4}{ramIndex} = byte3;
end

% 将结果写入到16个RAM的初始化文件
for i = 1:16
    outputFilename = sprintf('ram%d_init.txt', i-1);
    outputID = fopen(outputFilename, 'w');
    
    % 写入数据
    for j = 1:length(ramFiles{i})
        fprintf(outputID, '%s\n', ramFiles{i}{j});
    end
    
    fclose(outputID);
end

disp('RAM 初始化文件已生成，包括两份 .pat 文件的合并内容');

% 辅助函数：读取 .pat 文件
function data = readPatFile(filename)
    fileID = fopen(filename, 'r');
    data = {};
    
    % 逐行读取 .pat 文件
    while ~feof(fileID)
        line = fgetl(fileID);
        
        % 检查是否是有效的行（行首是 @ 符号）
        if startsWith(line, '@')
            % 分割每行的数据
            parts = strsplit(line);
            
            % 从第二部分开始是数据
            for i = 2:length(parts)
                if ~isempty(parts{i})
                    data{end+1} = parts{i};
                end
            end
        end
    end
    
    fclose(fileID);
end
