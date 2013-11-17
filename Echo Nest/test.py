from pyechonest import config
from pyechonest import track
import time

config.ECHO_NEST_API_KEY="PRBY7CGH85BBU69NJ"

INCR = 0.5
myTime = 0
curIndex = 0

def checkBeat(beatList):
    global curIndex
    global myTime
    (start, end) = (0,0)
    while curIndex < len(beatList) and myTime < start:
        (start, end) = beatList[curIndex]
        curIndex += 1
    
    if myTime < end:
        print "BOOM"
    #otherwise, beat hasn't started yet
    else:
        print "0"

    myTime += INCR

def main():
    f = open("sonata.mp3")
    t = track.track_from_file(f, "mp3")
    print t.key
    print t.title
    t.get_analysis()
    #t.sections is a list of dicts which describes the larger sections of a song
    #print dir(t)
    print t.sections

    beatList = [(x['start'], x['start']+x['duration']) for x in t.beats]
    print beatList
    while myTime < 212:
      time.sleep(0.05)
      checkBeat(beatList)
      #Timer(1.0, checkBeat, args=[beatList]).start()
    
    #while myTime < 212:
    #  time.sleep(

if __name__ == "__main__":
    main()

