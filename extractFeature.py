import sys
import os
dir = "D:/Lissa-video/"
# dir = "C:/inetpub/wwwroot/RocSpeakRafayet/uploads/"
dir_list = os.listdir(dir)
vidNumArr = [1846,1847,1848]
for file in vidNumArr:
	f = "C:/inetpub/wwwroot/RocSpeakRafayet/"+str(file)+".mp4"
	print f
	audioExeDir = "C:/inetpub/wwwroot/NonverbalAnalysis/AVProcessor_2015_mar/AVProcessor/bin/Release/";
	# command = "FeatureExtraction.exe -f "+dir+""+file+" -of "+ dir+""+file+"_out.txt"
	command = "cd "+ audioExeDir + " & AVProcessor.exe "+f+" 2>&1"
	print command
	out = os.system(command)
	print out