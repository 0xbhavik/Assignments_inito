#! /bin/bash


# Input Arrays with i-th user having ipAddress "ipAddrs[i]", username "userNames[i] and publickey
publicKey[i]

ipAddrs=()
userNames=()
publicKey=()


len=${#ipAddrs[@]}

echo "enter remote server's user name"
read remoteUserNam
echo "enter remote server's ip address"
read remoteIpAddr


for i in $(seq 0 $((len-1))); 
do

ipAddr=${ipAddrs[$i]}
userName=${userNames[$i]}
publicKey=${publicKeys[$i]}


isExist=$(ssh $remoteUserName@$remoteIpAddr "cat ~/.ssh/authorized_keys" | grep "$publicKey" | wc -l)

if [[ $isExist -eq '0' ]]; 
then 
echo "public key is not authorized, adding it to authorized file"
ssh  $remoteUserName@$remoteIpAddr "echo \"$publicKey\" >> ~/.ssh/authorized_keys"  

else
echo "public key is already authorized"
fi

done

