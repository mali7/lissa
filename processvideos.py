#!/usr/bin/python
import numpy as np
from numpy import linalg

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
import thread
from subprocess import call

def file_len(fname):
    with open(fname) as f:
        for i, l in enumerate(f):
            pass
    return i + 1

def process(command):
	print (command)
	ret = os.system(command)
	print "From ret "+str(ret)

if __name__ == '__main__':
	old = ""
	newest = ""
	old_merge_webm = ""
	open_face_dir = "D:/OpenFace_0.2.3_win_x86/OpenFace_0.2.3_win_x86/"
	while(1):
		newest = max(glob.iglob('C:/inetpub/wwwroot/RocSpeakRafayet/uploads/*.wav'), key=os.path.getctime)
		newest_webm = sorted(glob.iglob('C:/inetpub/wwwroot/RocSpeakRafayet/uploads/*.webm'), key=os.path.getctime)
		newest_webm = newest_webm[-8:]
		if newest!=old :
			for i in xrange(8):
				#print newest_webm[i]+" Check"
				if newest[:-4] == newest_webm[i][:-5]:
					old = newest
					audioExeDir = "C:/inetpub/wwwroot/NonverbalAnalysis/AVProcessor_2015_mar/AVProcessor/bin/Release/";
					command = "cd "+ audioExeDir + " & AVProcessor.exe "+newest+" "+ newest_webm[i]+ " 2>&1"
					#"cd $audioExeDir & AVProcessor.exe $audioVideoDir$dataKey4.wav $audioVideoDir$dataKey4.webm 2>&1");
					#ret = os.system(command) 
					try:
					   thread.start_new_thread( process, (command, ) )
					except:
					   print "Error: unable to start thread"
					
					break 
				else:
					print "not_found " 
		# if newest_webm!= old_merge_webm:
			# old_merge_webm = newest_webm
			# command = "cd "+open_face_dir+" & FeatureExtraction.exe -f "+newest_webm[0]+" -of "+ newest_webm[0]+"_out.txt"+ "2>&1"
			# try:
			   # thread.start_new_thread( process, (command, ) )
			# except:
			   # print "Error: unable to start thread"
			
				