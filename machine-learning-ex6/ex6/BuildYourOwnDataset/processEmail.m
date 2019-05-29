function processEmail(email_contents)
%PROCESSEMAIL preprocesses a the body of an email and

% ========================== Preprocess Email ===========================

% Find the Headers ( \n\n and remove )
% Uncomment the following lines if you are working with raw emails with the
% full headers

hdrstart = strfind(email_contents, ([char(10) char(10)]));
email_contents = email_contents(hdrstart(1):end);

% Lower case
email_contents = lower(email_contents);

% Strip all HTML
email_contents = regexprep(email_contents, '<[^<>]+>', ' ');

% Handle Numbers
email_contents = regexprep(email_contents, '[0-9]+', 'number');

% Handle URLS
email_contents = regexprep(email_contents, ...
                           '(http|https)://[^\s]*', 'httpaddr');

% Handle Email Addresses
email_contents = regexprep(email_contents, '[^\s]+@[^\s]+', 'emailaddr');

% Handle $ sign
email_contents = regexprep(email_contents, '[$]+', 'dollar');


% ========================== Tokenize Email ===========================

% Output the email to screen as well
fprintf('\n==== Processed Email ====\n\n');

% Process file
l = 0;

n = 4010000;
words = cell(n, 1);
i = 1;
while ~isempty(email_contents)

    % Tokenize and also get rid of any punctuation
    [str, email_contents] = ...
       strtok(email_contents, ...
              [' @$/#.-:&*+=[]?!(){},''">_<;%' char(10) char(13)]);
   
    % Remove any non alphanumeric characters
    str = regexprep(str, '[^a-zA-Z0-9]', '');

    % Stem the word 
    % (the porterStemmer sometimes has issues, so we use a try catch block)
    try str = porterStemmer(strtrim(str)); 
    catch str = ''; continue;
    end;

    % Skip the word if it is too short
    if length(str) < 1
       continue;
    end
   
		% Save the word in a cell array
		if mod(i, 100) == 0
			fprintf('Processed event %d', i);
			fflush(stdout);
		end
    words(i, 1) = str;
		i = i + 1;
		%for i =1:length(vocabList)
		%	if strcmp(str, vocabList{i}) == 1
		%		word_indices = [word_indices; i];
		%	  break;
		%end

    % =============================================================


    % Print to screen, ensuring that the output lines are not too long
    %if (l + length(str) + 1) > 78
    %    %fprintf('\n');
    %    l = 0;
    %end
    %%fprintf('%s ', str);
    %l = l + length(str) + 1;

end

i
words(10,1)
words(100,1)
% Print footer
fprintf('\n\n=========================\n');

end
