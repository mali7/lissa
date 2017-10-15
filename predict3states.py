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
        for t, l in enumerate(f):
            pass
    return t + 1

def read_permissions(filepath):
    '''Checks the read permissions of the specified file'''
    try:
        os.access(filepath, os.R_OK) # Find the permissions using os.access
    except IOError:
        return False

    return True

if __name__ == '__main__':
	
	old = ""
	newest = ""
	old_gaze_out = ""
	timecount =0
	timecountbody = 0
	timecounteye = 0 
	timecountsmile = 0 
	timecountvolume = 0
	timegreenbody = 0
	timegreensmile = 0
	timegreenvolume = 0
	eye0=1
	eye1=1
	newfile = ""
	type = ["eye","smile", "volume","body"]
	discritize = 5
	discritizeEye = 6
	rangeEye = discritizeEye*discritizeEye
	states = 3;
	range = discritize*discritize
	map = np.zeros([discritize,discritize])
	mapEye = np.zeros([discritizeEye,discritizeEye])
	for i in xrange(discritize):
		for j in xrange(discritize):
			map[i][j]=(i*discritize) +j
	for i in xrange(discritizeEye):
		for j in xrange(discritizeEye):
			mapEye[i][j]=(i*discritizeEye) +j
	while(1):
		newest = sorted(glob.iglob('C:/inetpub/wwwroot/RocSpeakRafayet/data/*.js'), key=os.path.getctime)
		newest_gaze_out = max(glob.iglob('C:/inetpub/wwwroot/RocSpeakRafayet/uploads/*.webm_gaze.out'), key=os.path.getctime)
		#files = sorted(os.listdir('C:/inetpub/wwwroot/RocSpeakRafayet/data/'),key = os.path.getmtime,reverse = True)
		newest = newest[-8:]
		print newest_gaze_out
		fileopened = 0
		try: 
			f = open(newest_gaze_out,'r')
			fileopened = 1			
		except IOError as e:
			print(os.strerror(13)) # Print the error message from errno as a string
			
		for x in xrange(8):
			if( "audio-video-features-"  in newest[x]):
				newfile = newest[x]
				# print newfile
				break
		if(newest_gaze_out!=old_gaze_out and os.path.getsize(newest_gaze_out)>0 and fileopened == 1):
			
			
			n_line = file_len(newest_gaze_out)
			
			print n_line, newest_gaze_out
			line = f.readline()
			x = []
			y = []
			eye =[]
			for i in xrange(n_line-1):
				line = f.readline()
				line = line.split()
				x.append(float(line[0]))
				y.append(float(line[1]))
			x = np.array(x)
			y = np.array(y)
			x = (((x +1)/2)*discritizeEye)
			y = ((y+1)/2)*discritizeEye
			x = x.astype(int)
			y = y.astype(int)
			for i in xrange(n_line-1):
				eye.append(mapEye[x[i]][y[i]])
			eye = np.array(eye).astype(int)
			f_param = open("VolumeSmileBodyEyeTrain.txt",'r')
			A = np.zeros([states*8,states])
			B = np.zeros([states*8,rangeEye])
			indexA=0;
			indexB=0;
			for i in xrange(states*4*4):
				line = f_param.readline().split()
				#print line
				if (i%(2*states)<states):
					for j in xrange(states):
						A[indexA,j] = line[j]
					indexA = indexA+1
				else:
					for j in xrange(range):
						B[indexB,j] = line[j]
					indexB = indexB+1
			B = B + 0.00001
			# print A 
			n = len(eye)
			offset = 18;
			alpha = np.zeros([states,n])
			for i in xrange(states):
				alpha[i][0] = B[i+offset][eye[0]]
			for k in xrange(1,n):
				for j in xrange(states):
					sum = 0
					for i in xrange(states):
						sum += alpha[i][k-1]*A[i+offset][j]*100
					sum = sum * B[j+offset][eye[k]]
					alpha[j][k] = sum 
			eye0 = alpha[0][n-1]+alpha[1][n-1] 
			eye0 = eye0*100
			offset = offset+states
			alpha = np.zeros([states,n])
			for i in xrange(states):
				alpha[i][0] = B[i+offset][eye[0]]
			for k in xrange(1,n):
				for j in xrange(states):
					sum = 0
					for i in xrange(states):
						sum += alpha[i][k-1]*A[i+offset][j]*100
					sum = sum * B[j+10][eye[k]]
					alpha[j][k] = sum 
			eye1 = alpha[0][n-1]+alpha[1][n-1] 
			print "eye0 = ",eye0," eye1 = ",eye1
			offset = offset+states
			old_gaze_out = newest_gaze_out
		
		if(newfile!=old and "audio-video-features-"  in newfile):
			print newfile
			writeFile = newfile.strip('C:/inetpub/wwwroot/RocSpeakRafayet/data')
			writeFile = writeFile.strip('.js');
			writeFile = writeFile[22:]
			writeFile = "C:/inetpub/wwwroot/RocSpeakRafayet/predictResult/"+writeFile+".txt";
			print writeFile;
			f_write = open(writeFile,'w+');
			f = open(newfile,'r')
			line = f.readline()
			line = line[34:len(line)-1]
			data = json.loads(line)
			f_param = open("VolumeSmileBodyEyeTrain.txt",'r')
			# A = np.zeros([16,2])
			# B = np.zeros([16,11])
			# for i in xrange(file_len("BodySmileVolumeTrain.txt")):
				# line = f_param.readline().split()
				# if (i%4)<2:
					# index = int(i/2) + i%2
					# A[index,0] = line[0]
					# A[index,1] = line[1]
				# else:
					# index = int((i-2)/2) + i%2
					# for j in xrange(11):
						# #print index
						# B[index,j] = line[j]
			# B = B+0.0001
			A = np.zeros([states*8,states])
			B = np.zeros([states*8,range])
			indexA=0;
			indexB=0;
			for i in xrange(states*4*4):
				line = f_param.readline().split()
				#print line
				if (i%(2*states)<states):
					for j in xrange(states):
						A[indexA,j] = line[j]
					indexA = indexA+1
				else:
					for j in xrange(range):
						B[indexB,j] = line[j]
					indexB = indexB+1
			B = B + 0.00001
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
				
				#smile <- smile,body
				#body <- body,smile
				#volume <- volume,body
				
				body = body*(discritize-1) 
				body = body.astype(int)
				smile = smile*(discritize-1)
				smile = smile.astype(int)
				volume = volume*(discritize-1)
				volume = volume.astype(int)
				
				n=len(body)
				tempBody = np.zeros([n])
				tempSmile = np.zeros([n])
				tempVolume = np.zeros([n])

				print len(tempBody)
				for i in xrange(n):
					tempBody[i] = map[body[i]][smile[i]]
					tempSmile[i] = map[smile[i]][body[i]]
					tempVolume[i] = map[volume[i]][body[i]]
					
				body = tempBody 
				smile = tempSmile 
				volume = tempVolume 
				
				n = len(body)
				offset = 0;
				#Volume Prediction
				alpha = np.zeros([states,n])
				for i in xrange(states):
					alpha[i][0] = B[i+offset][volume[0]]
				for k in xrange(1,n):
					for j in xrange(states):
						sum = 0
						for i in xrange(states):
							sum += alpha[i][k-1]*A[i+offset][j]*100
						sum = sum * B[j+offset][volume[k]]
						alpha[j][k] = sum 
				volume0 = alpha[0][n-1]+alpha[1][n-1] 
				offset = offset+states
				alpha = np.zeros([states,n])
				for i in xrange(states):
					alpha[i][0] = B[i+offset][volume[0]]
				for k in xrange(1,n):
					for j in xrange(states):
						sum = 0
						for i in xrange(states):
							sum += alpha[i][k-1]*A[i+offset][j]*100
						sum = sum * B[j+10][volume[k]]
						alpha[j][k] = sum 
				volume1 = alpha[0][n-1]+alpha[1][n-1] 
				print "volume0 = ",volume0," volume1 = ",volume1
				offset = offset+states
				
				
				#smile Prediction
				
				alpha = np.zeros([states,n])
				for i in xrange(states):
					alpha[i][0] = B[i+offset][smile[0]]
				for k in xrange(1,n):
					for j in xrange(states):
						sum = 0
						for i in xrange(states):
							sum += alpha[i][k-1]*A[i+offset][j]*100
						sum = sum * B[j+4][smile[k]]
						alpha[j][k] = sum 
				smile0 = alpha[0][n-1]+alpha[1][n-1] 
				smile0 = smile0*100
				offset = offset+states
				alpha = np.zeros([2,n])
				for i in xrange(2):
					alpha[i][0] = B[i+offset][smile[0]]
				for k in xrange(1,n):
					for j in xrange(2):
						#alpha[j][k] = ?
						sum = 0
						for i in xrange(2):
							sum += alpha[i][k-1]*A[i+offset][j]*100
						sum = sum * B[j+offset][smile[k]]
						alpha[j][k] = sum 
				smile1 = alpha[0][n-1]+alpha[1][n-1] 
				print "smile0 = ",smile0," smile1 = ", smile1
				offset = offset + states
				
				
				# Body Prediction
				alpha = np.zeros([states,n])
				for i in xrange(states):
					alpha[i][0] = B[i+offset][body[0]]
				for k in xrange(1,n):
					for j in xrange(states):
						sum = 0
						for i in xrange(states):
							sum += alpha[i][k-1]*A[i+offset][j]*10
						sum = sum * B[j+offset][body[k]]
						alpha[j][k] = sum 
				body0 = alpha[0][n-1]+alpha[1][n-1] 
				offset = offset + states
				
				alpha = np.zeros([states,n])
				for i in xrange(states):
					alpha[i][0] = B[i+offset][body[0]]
				for k in xrange(1,n):
					for j in xrange(states):
						#alpha[j][k] = ?
						sum = 0
						for i in xrange(states):
							sum += alpha[i][k-1]*A[i+offset][j]*10
						sum = sum * B[j+offset][body[k]]
						alpha[j][k] = sum		
				body1 = alpha[0][n-1]+alpha[1][n-1] 
				print "body0 = ", body0," body1 = ",body1
				offset = offset + states
				
				
				#Eye Prediction
				# alpha = np.zeros([2,n])
				# for i in xrange(2):
					# alpha[i][0] = B[i+12][smile[0]]
				# for k in xrange(1,n):
					# for j in xrange(2):
						# #alpha[j][k] = ?
						# sum = 0
						# for i in xrange(2):
							# sum += alpha[i][k-1]*A[i+12][j]*10
						# sum = sum * B[j+12][smile[k]]
						# alpha[j][k] = sum 
				# eye0 = alpha[0][n-1]+alpha[1][n-1] 
				
				# alpha = np.zeros([2,n])
				# for i in xrange(2):
					# alpha[i][0] = B[i+14][smile[0]]
				# for k in xrange(1,n):
					# for j in xrange(2):
						# #alpha[j][k] = ?
						# sum = 0
						# for i in xrange(2):
							# sum += alpha[i][k-1]*A[i+14][j]*10
						# sum = sum * B[j+14][smile[k]]
						# alpha[j][k] = sum 
				# eye1 = alpha[0][n-1]+alpha[1][n-1]
				# eye0 = eye1*10
				# print eye0,eye1
				
				#Print files 
				str = "";
				file_path = "C:/inetpub/wwwroot/RocSpeakRafayet/"
				path = file_path+"wizozbody.txt"
				if (body1>body0 and timegreenbody > 4):
					str = "1"
					if(os.path.exists(path) == False):
						wizozfile = open(path, 'w+')
						wizozfile.close()
						timecountbody = 0	
					else:
						timecountbody +=1
				else:
					str = "0"
					if(os.path.exists(path) and timecountbody > 2):
						os.remove(path)
						timegreenbody = 0
					else:
						timegreenbody +=1 
						
				path = file_path+"wizozsmile.txt"
				if (smile1>smile0 and timegreensmile > 4):
					str = str+"1"
					if(os.path.exists(path) == False):
						wizozfile = open(path, 'w+')
						wizozfile.close()
						timecountsmile = 0
					else:
						timecountsmile +=1
				else:
					str = str+"0"
					if(os.path.exists(path) and timecountsmile >= 0):
						os.remove(path)	
						timegreensmile = 0
					else:
						timegreensmile += 1
				path = file_path+"wizozvolume.txt"
				if (volume1>volume0 and timegreenvolume>4 ):
					str = str+"1"
					if(os.path.exists(path) == False):
						wizozfile = open(path, 'w+')
						wizozfile.close()
						timecountvolume = 0
					else:
						timecountvolume += 1
						
				else:
					str = str+"0"
					if(os.path.exists(path) and timecountvolume > 2):
						os.remove(path)
						timegreenvolume = 0
					else:
						timegreenvolume += 1
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
			if timecountbody > 2 and os.path.exists(path)  :
				os.remove(path)
			path = file_path+"wizozsmile.txt"
			if timecountsmile > 2 and os.path.exists(path)  :
				os.remove(path)
			path = file_path+"wizozvolume.txt"
			if timecountvolume > 2 and os.path.exists(path) :
				os.remove(path)
			path = file_path+"wizozeye.txt"
			if timecounteye > 2 and os.path.exists(path) :
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
		#time.sleep(1)