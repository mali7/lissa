#!/usr/bin/python
import numpy as np
from numpy import linalg
#from fileRead import readData
from ctypes import c_longlong as ll
from decimal import *
# import matplotlib.pyplot as plt
import math
import sys
import random
import json
import glob
import os
import time

def file_len(fname):
    with open(fname) as f:
        for i, l in enumerate(f):
            pass
    return i + 1


if __name__ == '__main__':
	
	old = ""
	newest = ""
	timecount =0
	timecountbody = 0
	timecounteye = 0 
	timecountsmile = 0 
	timecountvolume = 0 	
	newfile = ""
	type = ["eye","smile", "volume","body"]
	while(1):
		
		newest = sorted(glob.iglob('C:/inetpub/wwwroot/RocSpeakRafayet/data/*.js'), key=os.path.getctime)
		#files = sorted(os.listdir('C:/inetpub/wwwroot/RocSpeakRafayet/data/'),key = os.path.getmtime,reverse = True)
		newest = newest[-8:]
		for x in xrange(8):
			if( "audio-video-features-"  in newest[x]):
				newfile = newest[x]
				#print newfile
				break
		if(newfile!=old and "audio-video-features-"  in newfile):
			print newfile
			writeFile = newfile.strip('C:/inetpub/wwwroot/RocSpeakRafayet/data')
			writeFile = writeFile.strip('.js');
			writeFile = writeFile[22:]
			writeFile = "C:/inetpub/wwwroot/RocSpeakRafayet/predictResult/"+writeFile+".txt";
			print writeFile;
			f_write = open(writeFile,'w+');
			f = open(newfile,'r')
			#print f.readline()
			#print os.listdir('E:/LISSA- Videos/HMM/*.txt')
			#file = sys.argv[1]
			#f = open(file, 'r')
			line = f.readline()
			#print line
			line = line[34:len(line)-1]
			#print line[0:10], line[len(line)-10:len(line)]
			data = json.loads(line)
			f_param = open("BodySmileVolumeTrain.txt",'r')
			A = np.zeros([16,2])
			B = np.zeros([16,11])
			for i in xrange(file_len("BodySmileVolumeTrain.txt")):
				line = f_param.readline().split()
				if (i%4)<2:
					index = int(i/2) + i%2
					A[index,0] = line[0]
					A[index,1] = line[1]
				else:
					index = int((i-2)/2) + i%2
					for j in xrange(11):
						#print index
						B[index,j] = line[j]
			B = B+0.0001
			volume = []
			smile = []
			body = []
			
			print len(data)
			if (len(data)>0):
				for i in xrange(len(data)):
					volume.append(data[i]["soundIntensity_DB"])
					smile.append(data[i]["smile_cubicSpline"])
					body.append(data[i]["movement_cubicSpline"])
				
				print len(body)
				if max(body)>0 :
					body = np.array(body)/ max(body)
				else: body = np.array(body)
				if max(smile)>0 :
					smile = np.array(smile)/ max(smile)
				else: smile = np.array(smile)
				if max(volume)>0 :
					volume = np.array(volume)/ max(volume)
				else: volume = np.array(volume)
				body = body*10 + 0.0001
				body = body.astype(int)
				smile = smile*10
				smile = smile.astype(int)
				volume = volume*10
				volume = volume.astype(int)
				n = len(body)
				# Body Prediction
				alpha = np.zeros([2,n])
				for i in xrange(2):
					alpha[i][0] = B[i][body[0]]
				for k in xrange(1,n):
					for j in xrange(2):
						#alpha[j][k] = ?
						sum = 0
						for i in xrange(2):
							sum += alpha[i][k-1]*A[i][j]*10
						sum = sum * B[j][body[k]]
						alpha[j][k] = sum 
				body0 = alpha[0][n-1]+alpha[1][n-1] 
				
				alpha = np.zeros([2,n])
				for i in xrange(2):
					alpha[i][0] = B[i+2][body[0]]
				for k in xrange(1,n):
					for j in xrange(2):
						#alpha[j][k] = ?
						sum = 0
						for i in xrange(2):
							sum += alpha[i][k-1]*A[i+2][j]*10
						sum = sum * B[j+2][body[k]]
						alpha[j][k] = sum
					#print alpha[1][k]			
				body1 = alpha[0][n-1]+alpha[1][n-1] 
				#print alpha[1]
				print body0,body1
				
				#smile Prediction
				
				alpha = np.zeros([2,n])
				for i in xrange(2):
					alpha[i][0] = B[i+4][smile[0]]
				for k in xrange(1,n):
					for j in xrange(2):
						#alpha[j][k] = ?
						sum = 0
						for i in xrange(2):
							sum += alpha[i][k-1]*A[i+4][j]*10
						sum = sum * B[j+4][smile[k]]
						alpha[j][k] = sum 
				smile0 = alpha[0][n-1]+alpha[1][n-1] 
				smile0 = smile0*100
				
				alpha = np.zeros([2,n])
				for i in xrange(2):
					alpha[i][0] = B[i+6][smile[0]]
				for k in xrange(1,n):
					for j in xrange(2):
						#alpha[j][k] = ?
						sum = 0
						for i in xrange(2):
							sum += alpha[i][k-1]*A[i+6][j]*10
						sum = sum * B[j+6][smile[k]]
						alpha[j][k] = sum 
				smile1 = alpha[0][n-1]+alpha[1][n-1] 
				print "smile0 ",smile0,smile1
				
				#Volume Prediction
				
				alpha = np.zeros([2,n])
				for i in xrange(2):
					alpha[i][0] = B[i+8][volume[0]]
				for k in xrange(1,n):
					for j in xrange(2):
						#alpha[j][k] = ?
						sum = 0
						for i in xrange(2):
							sum += alpha[i][k-1]*A[i+8][j]*10
						sum = sum * B[j+8][volume[k]]
						alpha[j][k] = sum 
				volume0 = alpha[0][n-1]+alpha[1][n-1] 
				
				alpha = np.zeros([2,n])
				for i in xrange(2):
					alpha[i][0] = B[i+10][volume[0]]
				for k in xrange(1,n):
					for j in xrange(2):
						#alpha[j][k] = ?
						sum = 0
						for i in xrange(2):
							sum += alpha[i][k-1]*A[i+10][j]*10
						sum = sum * B[j+10][volume[k]]
						alpha[j][k] = sum 
				volume1 = alpha[0][n-1]+alpha[1][n-1] 
				print volume0,volume1
				
				#Eye Prediction
				alpha = np.zeros([2,n])
				for i in xrange(2):
					alpha[i][0] = B[i+12][smile[0]]
				for k in xrange(1,n):
					for j in xrange(2):
						#alpha[j][k] = ?
						sum = 0
						for i in xrange(2):
							sum += alpha[i][k-1]*A[i+12][j]*10
						sum = sum * B[j+12][smile[k]]
						alpha[j][k] = sum 
				eye0 = alpha[0][n-1]+alpha[1][n-1] 
				
				alpha = np.zeros([2,n])
				for i in xrange(2):
					alpha[i][0] = B[i+14][smile[0]]
				for k in xrange(1,n):
					for j in xrange(2):
						#alpha[j][k] = ?
						sum = 0
						for i in xrange(2):
							sum += alpha[i][k-1]*A[i+14][j]*10
						sum = sum * B[j+14][smile[k]]
						alpha[j][k] = sum 
				eye1 = alpha[0][n-1]+alpha[1][n-1]
				eye0 = eye1*10
				print eye0,eye1
				
				#Print files 
				str = "";
				file_path = "C:/inetpub/wwwroot/RocSpeakRafayet/"
				path = file_path+"wizozbody.txt"
				if (body1>body0):
					str = "1"
					if(os.path.exists(path) == False):
						wizozfile = open(path, 'w+')
						wizozfile.close()
						timecountbody = 0	
						
				else:
					str = "0"
					if(os.path.exists(path) and timecountbody > 2):
						os.remove(path)
						
						
				path = file_path+"wizozsmile.txt"
				if (smile1>smile0):
					str = str+"1"
					if(os.path.exists(path) == False):
						wizozfile = open(path, 'w+')
						wizozfile.close()
						timecountsmile = 0
						
				else:
					str = str+"0"
					if(os.path.exists(path) and timecountsmile > 2):
						os.remove(path)	
						
				path = file_path+"wizozvolume.txt"
				if (volume1>volume0):
					str = str+"1"
					if(os.path.exists(path) == False):
						wizozfile = open(path, 'w+')
						wizozfile.close()
						timecountvolume = 0
						
						
				else:
					str = str+"0"
					if(os.path.exists(path) and timecountvolume > 2):
						os.remove(path)
						
				path = file_path+"wizozeye.txt"
				if (eye1>eye0):
					str = str+"1"
					if(os.path.exists(path) == False):
						wizozfile = open(path, 'w+')
						wizozfile.close()
						timecounteye = 0
						
						
				else:
					str = str+"0"
					if(os.path.exists(path) and timecounteye > 2):
						os.remove(path)
						
				old = newfile
				#delete one file randomly
				f_write.write(str);
				f_write.close()
				
		else: 
			timecountbody += 1
			timecounteye +=1
			timecountsmile +=1
			timecountvolume +=1
			file_path = "C:/inetpub/wwwroot/RocSpeakRafayet/"
			path = file_path+"wizozbody.txt"
			if timecountbody > 3 and os.path.exists(path)  :
				os.remove(path)
			path = file_path+"wizozsmile.txt"
			if timecountsmile > 3 and os.path.exists(path)  :
				os.remove(path)
			path = file_path+"wizozvolume.txt"
			if timecountvolume > 3 and os.path.exists(path) :
				os.remove(path)
			path = file_path+"wizozeye.txt"
			if timecounteye > 3 and os.path.exists(path) :
				os.remove(path)
		
		#delete excess files
		file_count = 0;
		file_index = []
		for i in xrange(4):
			path = "C:/inetpub/wwwroot/RocSpeakRafayet/wizoz"+type[i]+".txt"
			if  os.path.exists(path) :
				file_index.append(i)
				file_count+=1;
		if file_count >= 3:
			i = int(random.random()*file_count)
			type_index = file_index[i] 
			path = "C:/inetpub/wwwroot/RocSpeakRafayet/wizoz"+type[type_index]+".txt"
			if  os.path.exists(path) :
				print path
				os.remove(path)
		time.sleep(1)