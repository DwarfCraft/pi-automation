#!/usr/bin/env python3
import unittest
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
#from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By

class TestGoogleHomepage(unittest.TestCase):
    def setUp(self):
        s = Service('/usr/local/bin/chromedriver')
        options = Options()
        options.headless = True
        self.browser = webdriver.Chrome(service=s, options=options)

    def testTitle(self):
        self.browser.get('https://google.com')
        self.assertIn('Google', self.browser.title)

    def tearDown(self):
        self.browser.quit()

if __name__ == '__main__':
    unittest.main(verbosity=2)
