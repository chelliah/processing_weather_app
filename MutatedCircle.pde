class MutatedCircle {
  float windSpeed = 0.0;
  float temperature = 273.00;
  int cloudCoverage = 0;
  color fillColor;
  int vertexPoints = 100;
  int defaultCircleSize = 250;
  PShape circle;
  PVector[] vertices = new PVector[vertexPoints];
  
  MutatedCircle(float w){
    windSpeed = w;
    for (int i = 0; i < vertexPoints; i += 1) {
      float d = float(i)/vertexPoints * TWO_PI;
      float n1 = noise(windSpeed, d);
      float vertexDisplacement = pow(windSpeed, 1.5);
      vertices[i] = new PVector(
        (sin(d) * defaultCircleSize*n1*vertexDisplacement), 
        (cos(d) * defaultCircleSize*n1*vertexDisplacement)
      );
    }
  }
  
  void display(){
    
    colorMode(HSB, 100);
    fill(fillColor);
    noStroke();
    beginShape();
    
    for (int i = 0; i < vertexPoints; i += 1) {
      //PVector existingVertex = circle.getVertex(i);
      curveVertex(vertices[i].x + width/2., vertices[i].y + width/2.);
    }
    endShape();
  }
  
  void setWindSpeed(float w) {
      //normalizes it for display
      windSpeed = map(w, 0, 30., 0., 2.);
      this.setVertices();
  }
  
  void setTemperature(float t, boolean shouldUpdateDisplayProps) {
    temperature = t;
    
    if (shouldUpdateDisplayProps) {
      this.setFillColor();
    }
  }
  
  void setCloudCoverage(int c, boolean shouldUpdateDisplayProps) {
    cloudCoverage = c;
    
    if (shouldUpdateDisplayProps) {
      this.setFillColor();
    }
  }
 
  
  void setFillColor() {
    colorMode(HSB, 100);
    float zeroF = 255.372;
    float seventyF = 294.261;
    float hundredF = 310.928;
    float brightness = 75 - cloudCoverage/4.;
    color blue = color(map(210, 0, 360, 0, 100), 70, brightness);
    color green = color(map(153.9, 0, 360, 0, 100), 80, brightness);
    color red = color(map(15.9, 0, 360, 0, 100), 80, brightness);
    
    if (temperature < seventyF) {
      fillColor = lerpColor(blue, green, map(temperature, zeroF, seventyF, 0., 1.));
      //fillColor = blue;
    } else {
      fillColor = lerpColor(green, red, map(temperature, seventyF, hundredF, 0., 1.));
      //fillColor = green;
    }
  }
  
  void setVertices() {
    for (int i = 0; i < vertexPoints; i += 1) {
      float d = float(i)/vertexPoints * TWO_PI;
      
      float n1 = noise(windSpeed, i/40. * windSpeed * 20) * windSpeed;
      
      float vertexDisplacement = 500;
      
      vertices[i] = new PVector(
        sin(d) * (defaultCircleSize + n1*vertexDisplacement), 
        cos(d) * (defaultCircleSize + n1*vertexDisplacement)
      );
    }
  }
}
