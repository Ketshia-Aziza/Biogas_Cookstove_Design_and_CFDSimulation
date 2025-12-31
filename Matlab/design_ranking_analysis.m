% MATLAB Code to Rank Burner Designs Using Combustion Simulation Data

% Step 1: Load the combustion simulation data
filename = 'biogasreBurnerResult Ansys22.xlsx';
sheetName = 'COMBUSTIONS RESULTS';

% Use 'VariableNamingRule','preserve' to keep original headers
data = readtable(filename, 'Sheet', sheetName, 'VariableNamingRule', 'preserve');

% Display the original variable names (stored in data.Properties.VariableNames)
disp('Original Variable Names:');
disp(data.Properties.VariableNames);

% For ease of use, rename the columns to valid MATLAB identifiers
% (Modify these names based on the actual headers in your file)
data = renamevars(data, ...
    {'name', 'Tzone (K)', 'Tmax (K)', 'combustion efficiency', 'Unburnt Ch4 (kg)'}, ...
    {'DesignID', 'Tzone', 'Tmax', 'Efficiency', 'Unburnt_CH4'});

% Step 2: Group data by design (DesignID) and average the performance metrics.
% If multiple simulation runs exist for a given design, groupsummary will compute the mean.
grouped = groupsummary(data, 'DesignID', 'mean', {'Tzone', 'Tmax', 'Efficiency', 'Unburnt_CH4'});

% Display the aggregated data
disp('Aggregated Data:');
disp(grouped);

% Step 3: Rank each design for each predictor
% For Tzone, Tmax, and Efficiency, higher values are better.
% Use -value with tiedrank so the highest value gets rank 1.
rank_Tzone = tiedrank(-grouped.mean_Tzone);
rank_Tmax = tiedrank(-grouped.mean_Tmax);
rank_Efficiency = tiedrank(-grouped.mean_Efficiency);

% For Unburnt_CH4, lower values are better (rank in ascending order)
rank_Unburnt = tiedrank(grouped.mean_Unburnt_CH4);

% Add the individual ranks to the table
grouped.Rank_Tzone = rank_Tzone;
grouped.Rank_Tmax = rank_Tmax;
grouped.Rank_Efficiency = rank_Efficiency;
grouped.Rank_Unburnt = rank_Unburnt;

% Step 4: Compute the Total Rank (lower total rank means better overall performance)
grouped.Total_Rank = rank_Tzone + rank_Tmax + rank_Efficiency + rank_Unburnt;

% Step 5: Sort the table by Total Rank (ascending order) and display the results
sorted_designs = sortrows(grouped, 'Total_Rank');

% Display the important columns
disp('Ranked Burner Designs:');
disp(sorted_designs(:, {'DesignID', 'mean_Tzone', 'mean_Tmax', 'mean_Efficiency', 'mean_Unburnt_CH4', 'Total_Rank'}));

