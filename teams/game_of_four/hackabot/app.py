import json
import time
from slackclient import SlackClient

token = "xoxb-737962968400-745826889808-hUeaqIYDhWoKWkGekpWTxdbR"
sc = SlackClient(token)

sc.api_call("api.test")
sc.api_call("channels.info", channel="CMCF9C719")
sc.api_call("chat.postMessage", channel="#hackathon", text="Hello from HackaBot")
