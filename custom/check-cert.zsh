function check-cert {
	openssl s_client -connect $1:443 </dev/null 2>/dev/null | openssl x509 -inform pem -text
}
