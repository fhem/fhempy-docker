import asyncio
import websockets


def test_url(url, data=""):
    async def inner():
        async with websockets.connect(url) as websocket:
            await websocket.send(data)
    return asyncio.get_event_loop().run_until_complete(inner())

waitingForId = int(random()*100000000);

testdata = { 
   "id": waitingForId ,
   "msgtype" : "function",
   "NAME" : "healthCheck",
   "PYTHONTYPE": "dockerhealthCheck",
   "FHEMPYTYPE": "dockerhealthCheck",
   "args": [],
   "argsh": {},
   "defargs": [],
   "defargsh": {}
}

  
test_url("ws://127.0.0.1:15733/",json.dumps(testdata))
