from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service

import time 

class videoCommentScrapper():
    def __init__(self,video_url: str):
        self.video_url = video_url
    
    def set_up(self):
        chromeOptions = webdriver.ChromeOptions()
        driver_path = r'/usr/local/bin/chromedriver'
        service = Service(executable_path=driver_path)
        chromeOptions.add_argument('--headless')
        chromeOptions.add_argument('--disable-gpu')
        chromeOptions.add_argument('--no-sandbox')
        self.driver = webdriver.Chrome(service=service, options=chromeOptions)

    def scrapp_comment(self):
        self.driver.get(self.video_url)
        time.sleep(5)
        
        # Find and print the comments
        comments = self.driver.find_elements(By.XPATH, '//div[@id="comment"]')  # Update with the correct XPath
        for comment in comments:
            print(comment.text)


if __name__ == "__main__":
    url = "https://www.youtube.com/watch?v=ilgWZr9HqkY"
    scrapper = videoCommentScrapper(url)
    scrapper.set_up()
    scrapper.scrapp_comment()