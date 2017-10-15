#!/usr/bin/python
import numpy as np
from numpy import linalg

from ctypes import c_longlong as ll
from decimal import *
import matplotlib.pyplot as plt
import math
import sys
import random
import json
import glob
import os
import time
from subprocess import call

def file_len(fname):
    with open(fname) as f:
        for i, l in enumerate(f):
            pass
    return i + 1


if __name__ == '__main__':
	old = ""
	newest = ""
	while(1):
		newest = max(glob.iglob('C:/inetpub/wwwroot/RocSpeakRafayet/uploads/*.wav'), key=os.path.getctime)
		print newest[:-4]
		newest_webm = sorted(glob.iglob('C:/inetpub/wwwroot/RocSpeakRafayet/uploads/*.webm'), key=os.path.getctime)
		newest_webm = newest_webm[-8:]
		if newest!=old :
			for i in xrange(8):
				#print newest_webm[i]+" Check"
				if newest[:-4] == newest_webm[i][:-5]:
					old = newest
					audioExeDir = "C:/inetpub/wwwroot/NonverbalAnalysis/AVProcessor_2015_feb/AVProcessor/bin/Release/";
					command = "cd "+ audioExeDir + " & AVProcessor.exe "+newest+" "+ newest_webm[i]+ " 2>&1"
					#"cd $audioExeDir & AVProcessor.exe $audioVideoDir$dataKey4.wav $audioVideoDir$dataKey4.webm 2>&1");
					ret = os.system(command) 
					print "From ret "+str(ret)
					break 
				else:
					print "not_found " 
				