cite about-plugin
about-plugin 'ssh helper functions'

function add_ssh() {
  about 'add entry to ssh config'
  param '1: host'
  param '2: hostname'
  param '3: user'
  group 'ssh'

  echo -en "\n\nHost $1\n  HostName $2\n  User $3\n  ServerAliveInterval 30\n  ServerAliveCountMax 120" >> ~/.ssh/config
}

function sshlist() {
  about 'list hosts defined in ssh config'
  group 'ssh'

  awk '$1 ~ /Host$/ { print $2 }' ~/.ssh/config
}

function pubkey(){
	# file /usr/bin/pubkey: Pubkey, kopieer je public key naar een opgegeven server
	if [[ $1 = "" ]]; then
	    echo "Usage: $0 <hostname> [pub_key_file]"
    elif [[ $2 = "" ]]; then
        2="~/.ssh/id_rsa.pub"
  	else
    	ssh $1 'if [ ! -d ~/.ssh ]; then mkdir ~/.ssh; chmod 750 ~/.ssh; fi'
    	cat $2 | ssh $1 "cat >> ~/.ssh/authorized_keys; chmod 0600 ~/.ssh/authorized_keys"
    	echo "Done"
    fi
}
