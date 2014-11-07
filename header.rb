class Header
  USER_AGENTS = [
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0",
    "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:21.0) Gecko/20130331 Firefox/21.0",
    "Mozilla/5.0 (Windows NT 6.2; WOW64; rv:21.0) Gecko/20100101 Firefox/21.0",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.93 Safari/537.36",
    "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.11 (KHTML, like Gecko) Ubuntu/11.10 Chromium/27.0.1453.93 Chrome/27.0.1453.93 Safari/537.36",
    "Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.94 Safari/537.36",
    "Mozilla/5.0 (compatible; WOW64; MSIE 10.0; Windows NT 6.2)",
    "Mozilla/4.0 (Windows; MSIE 6.0; Windows NT 5.2)",
    "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)",
    "Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0)",
    "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)",
    "Opera/9.80 (Macintosh; Intel Mac OS X 10.6.8; U; en) Presto/2.9.168 Version/11.52",
    "Opera/9.80 (Windows NT 6.1; WOW64; U; en) Presto/2.10.229 Version/11.62",
    "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; en-US) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27",
    "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27"
  ]

  MOBILE_AGENTS = [
    "Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_0 like Mac OS X; en-us) AppleWebKit/532.9 (KHTML, like Gecko) Version/4.0.5 Mobile/8A293 Safari/6531.22.7",
    "Mozilla/5.0 (Linux; U; Android 2.2; en-us; DROID2 GLOBAL Build/S273) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1",
    "Mozilla/5.0 (Linux; U; Android 2.2; en-gb; GT-P1000 Build/FROYO) AppleWebKit/533.1 (KHTML, like Gecko) Version/4.0 Mobile Safari/533.1"
  ]

  HEADER = {
    'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.94 Safari/537.36',
    'Accept' => 'text/html',
    'Accept-Language' => 'zh-CN',
    'Cache-Control' => 'no-cache',
    'Referer' => 'http://www.tripadvisor.com/',
    'X-Forwarded-For' => '127.0.0.1'
  }

  def self.random
    HEADER.merge('User-Agent' => USER_AGENTS.sample)
  end

  def self.mac
    HEADER.merge('User-Agent' => USER_AGENTS.sample, 'Cookie' => '__cfduid=d31240dda25381242271842faaf36297a1415099580816; yuv=RE_af8AqusnpTtpxKxtKvHJ-GV_NH7SN7tXiyo-pnTtXectz2jP9Ju_AdRJZv2YJHaAXLsGITqCBaJ74-vUSM6RGTJId6doi; bse=0fc7a74ce43fb055af71bf14a4053762; hl=en_US; fd=0; __qca=P0-140921449-1415099582319; dm=%7B%22rfb%22%3Atrue%7D; recentlocations=San+Francisco%2C+CA%2C+USA; location=%7B%22city%22%3A+%22New+York%22%2C+%22zip%22%3A+%22%22%2C+%22address1%22%3A+%22%22%2C+%22address2%22%3A+%22%22%2C+%22address3%22%3A+%22%22%2C+%22state%22%3A+%22NY%22%2C+%22country%22%3A+%22US%22%2C+%22unformatted%22%3A+%22New+York%2C+NY%22%7D; qntcst=D; _gat_www=1; ds=vOALk0qP9Ummbsmizj7vVQ; __utmt=1; __utmt_domainTracker=1; __utma=165223479.158126379.1415099582.1415108180.1415166970.3; __utmb=165223479.13.10.1415166970; __utmc=165223479; __utmz=165223479.1415099582.1.1.utmcsr=google|utmccn=(organic)|utmcmd=organic|utmctr=(not%20provided); __utmv=165223479.|2=integration=%22%22=1^4=account%20level=anon=1; _ga=GA1.2.57072CFD7DF0B3CC')
  end

  def self.mobile
    HEADER.merge('User-Agent' => MOBILE_AGENTS.sample)
  end  
    
end