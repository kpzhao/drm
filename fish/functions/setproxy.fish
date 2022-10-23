function setproxy
  export ALL_proxy=socks5h://127.0.0.1:10800
  export http_proxy=socks5h://127.0.0.1:10800
  export https_proxy=socks5h://127.0.0.1:10800
  echo "====== current socks proxy:"$ALL_proxy"======"
end
