#!/usr/bin/python

import re
from nltk.stem import PorterStemmer
ps = PorterStemmer()

#%------------------
#% BuildOwnVocabList
#%------------------


# Read file list
files = []
word_bank = []
with open("emailsForVocabulary.list") as file_list:
    for line in file_list:
        files.append(line.rstrip())

for i in range(0, len(files)):
    with open(files[i]) as file: 
        email = file.read()

    # clean up email
    hdrstart = email.find("\n\n")
    email = email[hdrstart+2:]
    email = re.sub('<[^<]+?>', '', email)
    email = re.sub('&nbsp;', '', email)
    email = re.sub('&#149;', '', email)
    email = re.sub('&#183;', '', email)
    email = re.sub('[0-9]+', ' number ', email)
    email = re.sub('(http|https)://[^\s]*', 'httpaddr', email)
    email = re.sub('\S*@\S*\s', 'emailaddr', email)
    email = re.sub('[$]', ' dollar ', email)
    email = re.sub('[%]', ' percent ', email)
    email = re.sub('[&]', ' and ', email)
    email = re.sub('[|]', ' ', email)
    email = re.sub('[@/#.-:*+=?!(){},''">_<;]', '', email)
    email = re.sub('[^a-zA-Z0-9 ]', '', email)
    email = email.lower()

    # extract individual words (tokenize email)
    words = email.split()

    for word in words:
        word = ps.stem(word)
        word_bank.append(word) 

    

