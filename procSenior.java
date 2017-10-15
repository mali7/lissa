import java.util.Random;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.File;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.StringTokenizer;


public class procSenior{
    public static void main (String args[]) throws FileNotFoundException, IOException, InterruptedException{
        Random rand = new Random();
        int range = 0, i = 0;
        range = Integer.decode(args[1]);
        double fileFound=1;
        double avgsound=0;
        double avgsmile=0;
        for(i=0;i<=range;i++){
            File f = new File("C:\\inetpub\\wwwroot\\RocSpeakRafayet\\predictResult\\"+args[0]+"split"+i+".txt");
            if (f.exists()){
                //System.out.println("Exists = "+f.getName());
                FileReader fr = new FileReader(f);
                fileFound++;
                BufferedReader br = new BufferedReader(fr);
                String s = br.readLine();
                if(s.charAt(1)=='0')avgsmile++;
                if(s.charAt(2)=='0')avgsound++;
                
            }
        }
        avgsmile = avgsmile/fileFound;
        avgsound = avgsound/fileFound;
        //System.out.println(avgsmile+" "+avgsound);
        int eye = 2, volume = 2, smile = 2, content = 2;
        int wizeye = 2, wizvolume = 2, wizsmile = 2, wizcontent = 2;
        int proceye = 0, procvolume = 0, procsmile = 0, proccontent = 0;
        int ifwiz = 1;
        int flag = 0;
        File f = new File("C:\\inetpub\\wwwroot\\RocSpeakRafayet\\seniorfeedback"+args[2]+".txt");
        for(i = 0;i< 2;i++){
           if(f.exists()){
               flag =1;
               break;
           }
           else{
               Thread.sleep(1000);
           }
        }
        if (flag == 1){//////////found wizoz data/////////////////
            FileReader fr = new FileReader(f);
            BufferedReader br = new BufferedReader(fr);
            String s = br.readLine();
            int temp = Integer.parseInt(s);
            wizcontent = temp % 10;
            temp = temp/10;
            wizsmile = temp %10;
            temp = temp /10;
            wizvolume = temp %10;
            temp = temp/10;
            wizeye = temp%10;
            //System.out.println(wizeye+""+wizvolume+""+wizsmile+""+wizcontent);
        }
        else if(flag == 0){
            ifwiz = 0;
            proceye = wizeye;
            proccontent = wizcontent;
            if(avgsound>0.2 || rand.nextInt(2)>=1 ){
                procvolume = 2;
            }
            if(avgsmile>0.2 || rand.nextInt(2)>=1){
                procsmile = 2;
            }
            
        }
        else{
            System.out.print(rand.nextInt(3));
            System.out.print(rand.nextInt(3));
            System.out.print(rand.nextInt(3));
            System.out.print(rand.nextInt(3));
        }
        ////////////////////check if improved/////////////////////////////
        int session = Integer.parseInt(args[3]);
        int keyNumber = 0;
        if(session > 1){/////////////////
            keyNumber = Integer.parseInt(args[2]) - 1;
        }
        f = new File("C:\\inetpub\\wwwroot\\RocSpeakRafayet\\seniorfeedback"+keyNumber+".txt");
        if(f.exists()){
            FileReader fr = new FileReader(f);
            BufferedReader br = new BufferedReader(fr);
            String s = br.readLine();
            int temp = Integer.parseInt(s);
            content = temp % 10;
            temp = temp/10;
            smile = temp %10;
            temp = temp /10;
            volume = temp %10;
            temp = temp/10;
            eye = temp%10;
            //System.out.println(eye+" "+volume+" "+smile+" "+content);
        }
        if(ifwiz==1){
            if(wizeye==2 && eye == 0){
                eye = 1;
            }
            else{
                eye = wizeye;
            }
            if(wizvolume == 2 && volume == 0){
                volume = 1; 
            }
            else{
                volume = wizvolume;
            }
            if(wizsmile == 2 && smile ==0){
                smile =1;
            }
            else{
                smile = wizsmile;
            }
            if(wizcontent ==2 && content==0){
                content = 1;
            }
            else{
                content = wizcontent;
            }
           // System.out.println(eye+""+volume+""+smile+""+content);
        }
        if(ifwiz==0){
            /*
            if(proceye==2 && eye == 0){
                eye = 1;
            }
            else 
                eye = proceye;
            */
            if(procvolume == 2 && volume == 0){
                volume = 1; 
            }
            else volume = procvolume;
            if(procsmile == 2 && smile ==0){
                smile =1;
            }
            else smile = procsmile;
            /*
            if(proccontent ==2 && content==0){
                content = 1;
            }
            else content = proccontent;
            */
        }
        //System.out.println("C:/inetpub/wwwroot/RocSpeakRafayet/outSenior"+keyNumber+".txt");
        File F = new File("C:/inetpub/wwwroot/RocSpeakRafayet/outSenior"+args[2]+".txt");
        //F.createNewFile();
		
		//////////////////////////////////
		if(eye==0 && volume==0 && smile ==0 && content==0){
			int point = rand.nextInt(3);
			switch(point){
				case 0: eye = 2;
					break;
				case 1: volume =2;
					break;
				case 2: smile = 2;
					break;
				case 3: content = 2;
					break;
			}
			
		}
		
        try (FileWriter fr = new FileWriter(F)) {
            System.out.println(eye+""+volume+""+smile+""+content);
            
            fr.append(eye+""+volume+""+smile+""+content);
            fr.close();
        }
    } 

}