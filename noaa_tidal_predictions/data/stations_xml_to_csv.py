# This script converts a stations XML result obtained from this URL:
# https://api.tidesandcurrents.noaa.gov/mdapi/prod/webapi/stations.xml?type=currentpredictions&expand=currentpredictionoffsets
# by including only the bin of minimum depth for each station and eliminating weak/variable stations.
# The flood and ebb directions are captured from the metadata also.

# Importing the required libraries 
import xml.etree.ElementTree as Xet 
import pandas as pd
  
cols = [
        'id', 'name', 'bin', 'latitude', 'longitude', 'depth', 'type', 
        'meanFloodDir', 'meanEbbDir',
        # 'refStationId', 'refStationBin',
        # 'mfcTimeAdjMin', 'sbeTimeAdjMin', 'mecTimeAdjMin', 'sbfTimeAdjMin',
        # 'mfcAmpAdj', 'mecAmpAdj'
        ]

rows = [] 
  
# Parse the XML file into a DOM up front
xmlparse = Xet.parse('currentPredictionStations.xml') 

# Pretty-print it
ppfile = open('currentPredictionStations-pretty.xml')
ppfile.write(Xet.tostring(xmlparse, pretty_print=True))
ppfile.close()

# Get the list of stations
root = xmlparse.getroot() 
stations = root.findall('Station')

# Get a map that will track the metadata for the least-depth bin for each station
stationMap = {}

# Loop over all stations finding the minimum depth and eliminating skippable ones.
for s in stations: 
    stationId = s.find('id').text

    # Skip weak/variable type stations
    if s.find('type').text == 'W':
        continue

    # If we find that we already saw this station, check its depth and only update the station map
    # if the newly found bin is shallower

    # TODO: filter out depths > 10
    
    lastStation = stationMap.get(stationId)
    if lastStation and lastStation.find('depth').text and s.find('depth').text:
        lastDepth = float(lastStation.find('depth').text)
        newDepth = float(s.find('depth').text)
        if newDepth >= lastDepth:
            continue

    stationMap[stationId] = s

# Now build the CSV rows for all stations in the map.
for stationId in stationMap:
    s = stationMap[stationId]
    cpo = s.find('currentpredictionoffsets')
    rows.append({
        'id': stationId, 
        'name': s.find('name').text, 
        'bin': s.find('currbin').text, 
        'latitude': s.find('lat').text, 
        'longitude': s.find('lng').text, 
        'type': s.find('type').text, 
        'depth': '-' + s.find('depth').text if s.find('depth').text else None, # turn into a Z coordinate
        'type': s.find('type').text, 
        'meanFloodDir': cpo.find('meanFloodDir').text, 
        'meanEbbDir': cpo.find('meanEbbDir').text, 
        # TODO: add reference station information to allow full interpolation of subordinate stations
        'type': s.find('type').text,
        })
  
df = pd.DataFrame(rows, columns=cols) 
  
# Writing dataframe to csv 
df.to_csv('currentPredictionStations.csv')