MutatedCircle circ;
JSONObject hourlyData;
JSONArray list;
int numberOfEntries;
int currentEntryIndex = 0;

void setup() {
  size(1000, 1000);
  colorMode(HSB, 100);
  
  loadAndSetDataPoints();
  initShapes();
}

void draw() {
  background(color(map(36.429, 0, 360, 0, 100), 10.8, 100.2));
  currentEntryIndex = floor(map(mouseX, 0, 1000, 0, numberOfEntries));
  setShapePropsAndDisplayShapes();
}

void initShapes() {
  circ = new MutatedCircle(50.);
}

void setShapePropsAndDisplayShapes() {
  JSONObject hourlyEntry = list.getJSONObject(currentEntryIndex);
  JSONObject mainData = hourlyEntry.getJSONObject("main"); //<>//
  JSONObject windData = hourlyEntry.getJSONObject("wind");
  JSONObject cloudData = hourlyEntry.getJSONObject("clouds");
  
  //set display props for the circle
  circ.setWindSpeed(windData.getFloat("speed"));
  circ.setTemperature(mainData.getFloat("temp"), false);
  circ.setCloudCoverage(cloudData.getInt("all"), true);
  
  circ.display();
}

void loadAndSetDataPoints() {
  hourlyData = loadJSONObject("hourly.json");
  list = hourlyData.getJSONArray("list");
  numberOfEntries = list.size();
}
