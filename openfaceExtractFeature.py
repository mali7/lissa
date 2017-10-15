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
	open_face_dir = "D:/OpenFace_0.2.3_win_x86/OpenFace_0.2.3_win_x86/FeatureExtraction.exe -f "
	while(1):
		newest_webm = sorted(glob.iglob('C:/inetpub/wwwroot/RocSpeakRafayet/uploads/*.webm'), key=os.path.getctime)[-1]
		# print newest_webm
		# newest_webm = newest_webm[-8:]
		if newest_webm!= old_merge_webm and 'merge' not in newest_webm:
			old_merge_webm = newest_webm
			command = open_face_dir+newest_webm+" -of "+ newest_webm+"_out.txt"+ " 2>&1"
			try:
			   thread.start_new_thread( process, (command, ) )
			except:
			   print "Error: unable to start thread"
			
				