#!/usr/bin/env python

from mmpy_bot import Plugin, listen_to
from mmpy_bot import Message

class MyPlugin(Plugin):

    @listen_to("wake up")
    async def wake_up(self, message: Message):
        self.driver.reply_to(message, "I'm awake!")


