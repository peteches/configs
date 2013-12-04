#!/usr/bin/python

import sys 
import re

phrase="".join(sys.argv[1:])

words=phrase.split('/')

alphabet = { 'a':0, 'b':0, 'c':0, 'd':0, 'e':0, 'f':0, 'g':0, 'h':0, 'i':0, 'j':0, 'k':0, 'l':0, 'm':0, 'n':0, 'o':0, 'p':0, 'q':0, 'r':0, 's':0, 't':0, 'u':0, 'v':0, 'w':0, 'x':0, 'y':0, 'z':0 } 

unguessed ='[abcdefghijklmnopqrstuvwxyz]'

dic_words = open('/usr/share/dict/words').readlines()

for word in words:
        for dic_word in dic_words:
		if re.match(word.replace('_',unguessed) + "$", dic_word, re.IGNORECASE):
			for letter in dic_word[:-1].lower():
				alphabet[letter] += 1

for letter in sorted(alphabet, key=alphabet.get, reverse=True):
        if letter not in phrase.lower():
                print letter, alphabet[letter]
