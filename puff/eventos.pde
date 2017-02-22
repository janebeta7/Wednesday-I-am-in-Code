void keyPressed()
{
  // If the key is between 'A'(65) to 'Z' and 'a' to 'z'(122)
  int keyIndex;
    if (key == 'i') {
      iniciar();
    } 
    if (key == 'c') {
      setupColors();
    } 
    
    if (key == 'm') {
      isMouse =! isMouse;
    } 
    if (key == 'v') {
        recording = !recording;
        if (recording) initVideo();
        println("Recording is " + (recording ? "ON" : "OFF"));
       // println("recording:"+recording);

        //presets[20].listener();
    }
    if (key == 'q') {
       endVideo();
     }
    
    if (key == '+') {
     
  
      XRAD = XRAD +1;
    } 
    if (key == 'b') {
       background(list.getLightest().toARGB());
    } 
   
     if (key == '-') {
      
      XRAD = XRAD -1;
    } 
}