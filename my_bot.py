#!/usr/bin/env python

from mmpy_bot import Bot, Settings
from my_plugin import MyPlugin

bot = Bot(
    settings=Settings(
        MATTERMOST_URL = "http://localhost",
        MATTERMOST_PORT = 8065,
        BOT_TOKEN = "dtydgwteajb43ehj63o7ex197r",
        BOT_TEAM = "BJB Prototype",
        SSL_VERIFY = False,
    ),  # Either specify your settings here or as environment variables.
    plugins=[MyPlugin()],  # Add your own plugins here.
)
bot.run()
