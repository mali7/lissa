import java.util.Random;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.File;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.StringTokenizer;
class VideoInfo{
    public String Datakey;
    ArrayList<Double> time =  new ArrayList<Double>();
    ArrayList<Double> soundIntensity_DB =  new ArrayList<Double>();
    ArrayList<Double> smile_cubicSpline =  new ArrayList<Double>();
    ArrayList<Double> movement_cubicSpline =  new ArrayList<Double>();
    ArrayList<Double> pitch_Hz =  new ArrayList<Double>();
    
    
    public void VideoInfo(){
        Datakey = "";

    }
    public void setValues(String datakey, double t, double p, double i, double f1, double f2, double f3, double b1, double b2, double b3){
        this.Datakey = datakey;
        time.add(t);
    }
    public void setValueFromSmile( double sound , double pitch, double smile, double move){
        soundIntensity_DB.add(sound);
        pitch_Hz.add(pitch);
        smile_cubicSpline.add(smile);
        movement_cubicSpline.add(move);
    }
    public void addTime(double t){
        time.add(t);
    }
}

public class proc{
    public static void main (String args[]) throws FileNotFoundException, IOException, InterruptedException{
        Random rand = new Random();
        int range = 0, i = 0;
        range = Integer.decode(args[1]);
        VideoInfo vi = new VideoInfo();
        for(i=0;i<=range;i++){
            File f = new File("C:\\inetpub\\wwwroot\\RocSpeakRafayet\\data\\average-features-"+args[0]+"split"+i+".js");
            if (f.exists()){
                FileReader fr = new FileReader("C:\\inetpub\\wwwroot\\RocSpeakRafayet\\data\\average-features-"+args[0]+"split"+i+".js");
                //System.out.println(args[0]+"split"+i);
                BufferedReader br = new BufferedReader(fr);
                String s = br.readLine();
                StringTokenizer st = new StringTokenizer(s,":,[{]}");
                int k = 0;
                double sound = 0,pitch = 0,smile = 0,movement = 0;
                while(st.hasMoreTokens()){
                    String Token = st.nextToken();
                    if(Token.matches("[0-9.]+")){
                        //k++;
                        if(k==0){
                            k++;
                        }
                        else if(k==1){
                            k++;
                            sound = Double.parseDouble(Token);
                        }
                        else if(k==2){
                            k++;
                            pitch = Double.parseDouble(Token);

                        }
                        else if(k==3){
                            k++;
                            smile = Double.parseDouble(Token);

                        }
                        else if(k==4){
                            k=0;
                            movement = Double.parseDouble(Token);
                            vi.setValueFromSmile(sound, pitch, smile, movement);
                        }
                    }
                }
            }
        }
        
        double avgmovement=0, avgsmile=0, avgpitch=0, avgsound = 0;
        vi.movement_cubicSpline.sort(null);
        vi.smile_cubicSpline.sort(null);
        vi.pitch_Hz.sort(null);
        vi.soundIntensity_DB.sort(null);
        int last = vi.movement_cubicSpline.size()-1;
        for(i=0;i<vi.movement_cubicSpline.size();i++){
            //System.out.println(vi.movement_cubicSpline.get(i));
            avgmovement += vi.movement_cubicSpline.get(i)/vi.movement_cubicSpline.get(last);
            avgsmile += vi.smile_cubicSpline.get(i)/vi.smile_cubicSpline.get(last);
            avgpitch += vi.pitch_Hz.get(i)/vi.pitch_Hz.get(last);
            avgsound += vi.soundIntensity_DB.get(i)/vi.soundIntensity_DB.get(last);
            
        }
        avgmovement = avgmovement / i;
        avgsmile = avgsmile/ i;
        avgpitch = avgpitch / i;
        avgsound = avgsound /i;
        System.out.println(avgmovement + " "+ avgsmile+" "+ avgpitch+" "+avgsound);
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
            if(avgpitch>0.4 || avgsound>0.4){
                procvolume = 2;
            }
            if(avgsmile>0.4){
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