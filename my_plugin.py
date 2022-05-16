#!/usr/bin/env python
import time

from mmpy_bot import Plugin, listen_to
from mmpy_bot import Message
from datetime import datetime


class MyPlugin(Plugin):
    @listen_to("wake up")
    async def wake_up1(self, message: Message):
        self.driver.reply_to(message, "I'm awake!")
    @listen_to("help")
    async def wake_up2(self, message: Message):
        self.driver.reply_to(message, "on it")
    @listen_to("good afternoon")
    async def wake_up3(self, message: Message):
        self.driver.reply_to(message, "good afternoon")
    @listen_to("good morning")
    async def wake_up4(self, message: Message):
        self.driver.reply_to(message, "good morning to you too")
    @listen_to("good afternoon")
    async def wake_up5(self, message: Message):
        self.driver.reply_to(message, "good afternoon")
    @listen_to("good night")
    async def good_night(self, message: Message):
         self.driver.reply_to(message, "good night sir")
    @listen_to("what time is it")
    async def time(self, message: Message):
         self.driver.reply_to(message, str(datetime.now()))
    @listen_to("sleep")
    async def sleep(self, message: Message):
         self.driver.reply_to(message, "alright, im going to sleep. bye bye")
    @listen_to("confluence")
    async def confluence(self, message: Message):
         self.driver.reply_to(message, "here is the confluence link : www.confluence.sehlat.io")
    @listen_to("jira")
    async def jira(self, message: Message):
         self.driver.reply_to(message, "here is the jira link : www.jira.sehlat.io")
    @listen_to("tasks")
    async def tasks(self, message: Message):
         self.driver.reply_to(message, "you have no tasks")
