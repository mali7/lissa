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


print 'Training done' 
green_time = np.zeros([4])
while(1):
	newest_json = sorted(glob.iglob('C:/inetpub/wwwroot/RocSpeakRafayet/data/audio-video-features-*.js'), key=os.path.getctime)[-1]
	newest_open_face = sorted(glob.iglob('C:/inetpub/wwwroot/RocSpeakRafayet/uploads/*.webm_out.txt'), key=os.path.getctime)[-1]
	writefile = newest_json.strip('C:/inetpub/wwwroot/RocSpeakRafayet/data/audio-video-features-').strip('.js')[22:]
	
	fileopened = 0
	try: 
		f = open(newest_json,'r')
		print newest_json
		fileopened = 1			
	except IOError as e:
		print(os.strerror(13))
	if fileopened==1:
		line = f.readline()
		line = line[34:len(line)-1]
		data = json.loads(line)
		# print len(data)
		if (len(data)>0):
			for i in xrange(len(data)):
				X_from_shore_queue[queue_head][0] += data[i]["soundIntensity_DB"]
				X_from_shore_queue[queue_head][1] += data[i]["pitch_Hz"] 
				X_from_shore_queue[queue_head][2] += data[i]["smile_cubicSpline"]
				X_from_shore_queue[queue_head][3] += data[i]["movement_cubicSpline"]
			X_from_shore_queue[queue_head] = X_from_shore_queue[queue_head]/len(data)
		X = (X_from_shore_queue[queue_head] - np.mean(X_from_shore_queue))/np.std(X_from_shore_queue)
		print('body',X_from_shore_queue[queue_head][3])
		print('smile',X_from_shore_queue[queue_head][2])
		#################For Fun####################
		if X_from_shore_queue[queue_head][3] < 1.14:
			bodyLabel = 1
		else:
			bodyLabel = -1
		time.sleep(1)
		############################################
		# continue
		# bodyLabel = bodyclf.predict(X[3])
		volumeLabel = volumeclf.predict(X[0:1])
		smileLabel = smileclf.predict(X[0:4])
		queue_head = (queue_head+1)% len(X_from_shore_queue)
	fileopened = 0
	try: 
		f = open(newest_open_face,'r')
		print newest_open_face
		fileopened = 1			
	except IOError as e:
		print(os.strerror(13))
	if fileopened==1:
		readableIndex = [4,5,6,7,8,9,10,11]
		n_line = file_len(newest_open_face)
		f.readline()
		X = np.zeros([7])
		for i in xrange(n_line-1):
			line = f.readline().split(',')
			for j in xrange(7):
				try:
					X[j] = X[j] + float(line[readableIndex[j]])
				except ValueError:
					X[j] = X[j] + 0
		if n_line > 1:
			X = X/(n_line-1)
		eyeLabel = eyeclf.predict(X)
	file_path = "C:/inetpub/wwwroot/RocSpeakRafayet/"
	feedbackFileNames = ["wizozbody.txt","wizozeye.txt","wizozvolume.txt","wizozsmile.txt"]
	Labels = [bodyLabel,eyeLabel,volumeLabel,smileLabel]
	
	str = ""
	for i in xrange(4):
		path = file_path+feedbackFileNames[i]
		if(Labels[i]>0 and green_time[i]>2):
			green_time[i]=0
			str = str+ "1"
			if(os.path.exists(path) == False):
				wizozfile = open(path, 'w+')
				wizozfile.close()
		else:
			str = str+ "0"
			green_time[i] += 1
			if(os.path.exists(path)):
				os.remove(path)
	writefile = "C:/inetpub/wwwroot/RocSpeakRafayet/predictResult/"+writefile+".txt";
	f_write = open(writefile,'w+');
	
	f_write.write(str);
	f_write.close()
	time.sleep(1)
	print bodyLabel,eyeLabel,volumeLabel,smileLabel