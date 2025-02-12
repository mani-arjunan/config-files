read -p "Enter a keyword to search: " keyword

curl -s cht.sh/$1/${keyword} | less 
