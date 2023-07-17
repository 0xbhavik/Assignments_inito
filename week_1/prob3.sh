#! /bin/bash

echo "Enter Password"
read pass

hasLowerCase=0
hasUpperCase=0
hasSpecialChar=0
hasNumber=false
str_len=${#pass}
echo "str_len ${str_len} "


for ((i=0;i<${#pass};i++)); do
 char=${pass:i:1}
 if [[ $char == [A-Z]  ]];
 then hasUpperCase=1
 elif [[ $char == [a-z] ]]; 
 then hasLowerCase=1
 elif [[ $char == [1-9] ]];
 then hasNumber=1
 else 
      hasSpecialChar=1
 fi 
done


if [[ str_len -ge "10" ]]  && [[ hasUpperCase -eq 1 ]] && [[ hasLowerCase -eq 1 ]] && [[ hasSpecialChar -eq 1 ]]; 
then echo "strong password"
elif [[ str_len -ge "8" ]] && [[ hasUpperCase -eq 1 ]] && [[ hasLowerCase -eq 1 ]]; 
then echo "high password"
elif [[ str_len -ge "6" ]] && [[ hasUpperCase -eq 1 ]] && [[ hasLowerCase -eq 1 ]] ;
then echo "medium password"
else 
echo "low password" 
fi 


