# Send Log4j payload.

This script sends all header payload to the server.
It supports single URL check as well as list of domains to test.

## Features
- Use your own permanent token.
  Get your free canary token from http://canarytokens.org/generate and replace the payload in log4jTest.sh file.
- Supports single url for test.
- Supports list of URLs.

## Usage:
```sh
Usage:
  -h   Show basic help message and exit
  -u   Target URL (e.g. 'http://www.site.com/')
  -l   Target URL list file.

eg: ./log4jTest.sh -u https://example.com
eg: ./log4jTest.sh -l ./path/URLlist.txt
```

## Demo:

```Single URL Test```

![](https://raw.githubusercontent.com/abhiunix/log4j-test/master/resources/singleURL.png)

```List of URLs```

![](https://raw.githubusercontent.com/abhiunix/log4j-test/master/resources/working.gif)

```Request Format```

![](https://raw.githubusercontent.com/abhiunix/log4j-test/master/resources/RequestFormat.png)

#### Connect @ [![Twitter](https://img.shields.io/badge/-abhiunix-1DA1F2?style=flat-square&logo=Twitter&logoColor=white&link=https://twitter.com/abhiunix/)](https://twitter.com/abhiunix/)