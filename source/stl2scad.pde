
String glines[];
int totallines;
int vertexcount; 
int facecount = 0;
String gcodeone[]; 


float ax[] = {};   
float ay[] = {}; 
float az[] = {};
String outstl[] = {}; 

void setup() {
  selectInput("Select a file to process:", "fileSelected");
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
      glines = loadStrings(selection);
          totallines = glines.length;        
            println("totallines: " + totallines); 
  }
}
  
void draw(){
  



  if (glines != null){
   

   for (int i=0; i<totallines-1; i++){
       String glinebody = trim(glines[i]);
      String[] gcodeone = glinebody.split(" ");
 
    
      
     if (gcodeone[0].equals("facet")) { 
      facecount++; 
      }
     
      if (gcodeone[0].equals("vertex")) { 
       
      ax = (float[])append(ax, float(gcodeone[1]));
      ay = (float[])append(ay, float(gcodeone[2]));
      az = (float[])append(az, float(gcodeone[3]));
      vertexcount++;
    }
       
   }
  
   
 
      println("Faces:"+facecount);       
      println("vertexs:"+vertexcount); 
      
  outstl = (String[])append(outstl,"polyhedron ");
  outstl = (String[])append(outstl,"(points = [ ");
   

      for (int i=0; i<vertexcount-2; i++){
        
       
      outstl = (String[])append(outstl,"[" + ax[i] + "," + ay[i] + "," +az[i]+"],"); 
        
      }
      
       outstl = (String[])append(outstl, "[" + ax[vertexcount-1] + "," + ay[vertexcount-1] + "," +az[vertexcount-1]+"]"); 
       outstl = (String[])append(outstl,"],"); 
       

       
       outstl = (String[])append(outstl, "faces = [");
     
     vertexcount = 0;
       for (int i=0; i<facecount-2; i++){
        
        
      outstl = (String[])append(outstl, "[" + nf(vertexcount) + "," + nf(vertexcount+1) + "," +  nf(vertexcount+2)  + "],"); 
  
        vertexcount = vertexcount + 3; 
        
      }
         outstl = (String[])append(outstl, "[" + nf(vertexcount) + "," + nf(vertexcount+1) + "," +  nf(vertexcount+2)  + "]"); 
  
         outstl = (String[])append(outstl, "]"); 
        outstl = (String[])append(outstl,  ");"); 
      
       println("facecount: "+facecount);
 

        saveStrings("openscad"+year()+month()+day()+hour()+minute()+second()+".txt", outstl);
        println("done.");
        exit();
        
  }
  


}
