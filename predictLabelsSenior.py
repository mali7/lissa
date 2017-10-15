#!/usr/bin/python
import numpy as np
from numpy import linalg
#from fileRead import readData
from ctypes import c_longlong as ll
from decimal import *
import math
import sys
import random
import json
import glob
import os
import time
import sys
import numpy as np
import os.path
import os
from sklearn import linear_model
from sklearn.metrics import f1_score
from sklearn.metrics import precision_recall_fscore_support
import sklearn.metrics
from sklearn import svm
from sklearn import metrics
from sklearn.externals import joblib
from sklearn.ensemble import AdaBoostClassifier
from sklearn import linear_model
from sklearn.ensemble import GradientBoostingClassifier
from sklearn import neighbors, datasets
from nltk.sentiment.vader import SentimentIntensityAnalyzer

def file_len(fname):
    with open(fname) as f:
        for t, l in enumerate(f):
            pass
    return t + 1
def load_data():
	file = "D:/SVM/normalizedData.txt"
	print(file)
	n_line = file_len(file)
	f = open(file, 'r')
	feat_size = 51
	X = np.zeros([n_line,feat_size])
	Y = np.zeros([n_line,4])
	for i in range(n_line):
		line = f.readline()
		line = line.split()
		for j in range(feat_size):
			X[i,j] = float(line[j])
		for j in range (4):
			Y[i,j] = float(line[feat_size+j])
			if Y[i][j] == 0:
				Y[i][j] = -1
	print("Data Loading Done")
	return X,Y
	
X_from_shore_queue = np.zeros([50,4])
queue_head = 0
X_from_open_face = np.zeros([50])

# X, Y = load_data()

# bodyclf = AdaBoostClassifier(n_estimators=200).fit(X[:,3:4],Y[:,0])
# eyeclf = svm.SVC(kernel='rbf',max_iter = 3000,C=1).fit(X[:,4:11], Y[:,1])
# volumeclf =  neighbors.KNeighborsClassifier(1, weights='distance').fit(X[:,0:1], Y[:,2]) 
# smileclf =  svm.SVC(kernel='rbf',max_iter = 25000,C=.10).fit(X[:,0:4], Y[:,3])

# joblib.dump(bodyclf, 'BodyMovement.pkl',protocol=2)
# joblib.dump(eyeclf, 'Eye.pkl',protocol=2)
# joblib.dump(volumeclf, 'Volume.pkl',protocol=2)
# joblib.dump(smileclf, 'Smile.pkl',protocol=2)

# exit()

bodyclf = joblib.load('BodyMovement.pkl')
eyeclf = joblib.load('Eye.pkl') 
volumeclf =  joblib.load('Volume.pkl') 
smileclf =  joblib.load('Smile.pkl') 


# print 'Training done' 
green_time = np.zeros([4])
# 186e5699832b35977301f6e0815d62f7_1

newest_json = 'C:/inetpub/wwwroot/RocSpeakRafayet/data/audio-video-features-'+sys.argv[1]+"split1.js"
newest_json = 'C:/inetpub/wwwroot/RocSpeakRafayet/data/audio-video-features-73e4934aa20373475db0ca3e08a16131_1split1.js'
newest_open_face = 'C:/inetpub/wwwroot/RocSpeakRafayet/uploads/'+sys.argv[1]+"split1.webm_out.txt"
count = 0
file_wont_come = False
while True:
	if count > 300:
		file_wont_come = True
		break
	if os.path.isfile(newest_json) and os.path.isfile(newest_open_face):
		break
	else: 
		count+=1
		time.sleep(1)
		print ('waiting for files',os.path.isfile(newest_json),os.path.isfile(newest_open_face))

if file_wont_come == False:
	fileopened = 0
	try: 
		f = open(newest_json,'r')
		# print newest_json
		fileopened = 1			
	except IOError as e:
		print(os.strerror(13))
	if fileopened==1:
		line = f.readline()
		line = line[34:len(line)-1]
		data = json.loads(line)
		# print len(data)
		X_from_shore = np.zeros([len(data),4])
		
		if (len(data)>0):
			for i in xrange(len(data)):
				X_from_shore[i][0] = data[i]["soundIntensity_DB"]
				X_from_shore[i][1] = data[i]["pitch_Hz"]
				X_from_shore[i][2] = data[i]["smile_cubicSpline"]
				X_from_shore[i][3] = data[i]["movement_cubicSpline"]

		X = (X_from_shore - np.mean(X_from_shore))/np.std(X_from_shore)
		# print (X.shape)

		
		#################For Fun####################
		bodyLabel = 0
		# for i in xrange(len(data)):
			# if X_from_shore[i][3] < 1.14:
				# bodyLabel += 1
			# else:
				# bodyLabel += -1
		# # time.sleep(1)
		# ############################################
		# # continue
		# # bodyLabel = bodyclf.predict(X[3])
		volumeLabel = np.sum(volumeclf.predict(X[:,0:1]))/len(data)
		smileLabel = np.sum(smileclf.predict(X[0:4]))/len(data)
		# bodyLabel = bodyLabel/len(data)
		# # queue_head = (queue_head+1)% len(X_from_shore_queue)
		# Label = -ve means green flash. 
	fileopened = 0
	try: 
		f = open(newest_open_face,'r')
		# print newest_open_face
		fileopened = 1			
	except IOError as e:
		print(os.strerror(13))
	if fileopened==1:
		readableIndex = [4,5,6,7,8,9,10,11]
		n_line = file_len(newest_open_face)
		f.readline()
		X = np.zeros([n_line-1,7])
		
		for i in xrange(n_line-1):
			line = f.readline().split(',')
			for j in xrange(7):
				try:
					X[i,j] =  float(line[readableIndex[j]])
				except ValueError:
					X[i,j] = 0
		# if n_line > 1:
			# X = X/(n_line-1)
		eyeLabel = np.sum(eyeclf.predict(X))/(n_line-1)
else:
	eyeLabel = -1
	volumeLabel = -1
	smileLabel = -1
	bodyLabel = -1
	
file = 'C:/inetpub/wwwroot/RocSpeakRafayet/seniorParticipantSpeech/lispDialogue'+sys.argv[1]+'.txt'

if os.path.isfile(file):
	n_line = file_len(file)
	f = open(file, 'r')
	sid = SentimentIntensityAnalyzer()
	for i in range(n_line):
		sentence = f.readline()
		ss = sid.polarity_scores(sentence)
		content = 0
		for k in sorted(ss):
			content += ss['compound']
			# print( k, " ",ss[k],"\t")
		# print()
		content = content/n_line
		if content < -0.2:
			content = 1 #red flash
		else:
			content = -1
else:
	content = -1
	
smileLabel = -1 #cheat
Labels = np.sign([eyeLabel, volumeLabel, smileLabel, content])
# print (eyeLabel,volumeLabel,smileLabel, content, Labels)
str = ' '
for i in Labels:
	if i<0:
		str +="1"
	else:
		str +='0'

writefile = "C:/inetpub/wwwroot/RocSpeakRafayet/feedback/"+sys.argv[2]+".txt"
f_write = open(writefile,'a+')
f_write.write(str)
f_write.close()
# time.sleep(1)
indicatorWriteFile = "C:/inetpub/wwwroot/RocSpeakRafayet/feedback/Done"+sys.argv[2]+".txt"
f_write = open(indicatorWriteFile,'a+')
f_write.write(str[1:])
f_write.close()
print str
# print bodyLabel,eyeLabel,volumeLabel,smileLabel