-- Database dump simplified to work with MySQL and SQLite
BEGIN TRANSACTION;

-- --------------------------------------------------------

--
-- Structure for table `commands`
--

CREATE TABLE `commands` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `name` varchar(80) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `examples` text DEFAULT NULL,
  `tool` int(11) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  `command` text DEFAULT NULL,
  `value` text DEFAULT NULL,
  `example` varchar(150) DEFAULT NULL,
  `sudo` int(1) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL
);

--
-- Populate data for `commands`
--

--
-- Populate data for `commands`: nmap
--
INSERT INTO `commands` (`name`, `description`, `examples`, `tool`, `type`, `command`, `example`, `sudo`, `category`) VALUES
('Scan specific ports', NULL, 'nmap -p 80,443 8.8.8.8', 1, 'input', '-p', 'Specific: 80,443 OR Range: 1-65536', NULL, 'PORT SPECIFICATION AND SCAN ORDER'),
('Ping Scan - disable port scan', NULL, NULL, 1, 'checkbox', '-sL', NULL, NULL, 'HOST DISCOVERY'),
('Skip host discovery', NULL, NULL, 1, 'checkbox', '-Pn', NULL, NULL, 'HOST DISCOVERY'),
('Trace hop path to each host', NULL, NULL, 1, 'checkbox', '--traceroute', NULL, NULL, 'HOST DISCOVERY'),
('Use OSs DNS resolver', NULL, NULL, 1, 'checkbox', '--system-dns', NULL, NULL, 'HOST DISCOVERY'),
('Exclude hosts/networks', NULL, NULL, 1, 'input', '--exclude', 'Example: 192.168.0.1', NULL, 'TARGET SPECIFICATION'),
('Enable OS detection', NULL, NULL, 1, 'checkbox', '-O', NULL, NULL, 'OS DETECTION'),
('IP protocol scan', NULL, NULL, 1, 'checkbox', '-sO', NULL, NULL, 'SCAN TECHNIQUES'),
('FTP bounce scan', NULL, NULL, 1, 'checkbox', '-b', NULL, NULL, 'SCAN TECHNIQUES'),
('Exclude the specified ports from scanning', NULL, NULL, 1, 'input', '--exclude-ports', 'Specific: 80,443 OR Range: 1-65536', NULL, 'PORT SPECIFICATION AND SCAN ORDER'),
('Scan 100 most common ports', NULL, NULL, 1, 'checkbox', '-F', NULL, NULL, 'PORT SPECIFICATION AND SCAN ORDER'),
('Service detection (Standard)', NULL, NULL, 1, 'checkbox', '-sV', NULL, NULL, 'SERVICE/VERSION DETECTION'),
('OS detection, version, script scanning, and traceroute', NULL, NULL, 1, 'checkbox', '-A', NULL, NULL, 'MISC'),
('Print version number', NULL, NULL, 1, 'show', '-V', NULL, NULL, 'MISC'),
('Print this help summary page.', NULL, NULL, 1, 'show', '-h', NULL, NULL, 'MISC'),
('Enable IPv6 scanning', NULL, NULL, 1, 'checkbox', '-6', NULL, NULL, 'MISC'),
('Scan using UDP', NULL, NULL, 1, 'checkbox', '-sU', NULL, NULL, 'SCAN TECHNIQUES'),
('Scan for vulnerabilities', NULL, NULL, 1, 'checkbox', '-sS -sC -Pn --script vuln', 'nmap -sS -sC -Pn --script vuln scanme.nmap.org ', NULL, NULL),
('Scan for exploits', NULL, NULL, 1, 'checkbox', '-Pn -sS -sC --script exploit', 'nmap -Pn -sS -sC --script exploit scanme.nmap.org  ', NULL, NULL),
('Scan to test DoS attack vulnerability', NULL, NULL, 1, 'checkbox', '-Pn -sS -sC --script dos', 'nmap -Pn -sS -sC --script dos scanme.nmap.org ', NULL, NULL),
('Perform DoS attacks with a simulator', NULL, NULL, 1, 'checkbox', '--max-parallelism 750 -Pn --script http-slowloris --script-args http-slowloris.runforever=true', 'nmap --max-parallelism 750 -Pn --script http-slowloris --script-args http-slowloris.runforever=true scanme.nmap.org', NULL, NULL),
('Find subdomains', NULL, NULL, 1, 'checkbox', '-p 80 --script dns-brute.nse', 'nmap -p 80 --script dns-brute.nse vulnweb.com', NULL, NULL),
('Scan all 65535 ports', NULL, NULL, 1, 'checkbox', '-p-', NULL, NULL, NULL),
('Scan using TCP connect', NULL, NULL, 1, 'checkbox', '-sT', NULL, NULL, 'SCAN TECHNIQUES'),
('Scan common UDP ports', NULL, NULL, 1, 'checkbox', '-sU -p 53,123,138,161,162,68,69,500,4500,5600', NULL, NULL, NULL),
('Service detection (Agressive)', NULL, NULL, 1, 'checkbox', '--version-intensity 5', NULL, NULL, 'SERVICE/VERSION DETECTION'),
('Service detection (Lighter)', NULL, NULL, 1, 'checkbox', '-sV --version-intensity 0', NULL, NULL, 'SERVICE/VERSION DETECTION'),
('Scan using default safe scripts', NULL, NULL, 1, 'checkbox', '-sV -sC', NULL, NULL, NULL),
('Scan for UDP DDOS reflectors', NULL, NULL, 1, 'checkbox', '–sU –A –PN –n –pU:19,53,123,161 –script=ntp-monlist,dns-recursion,snmp-sysdescr', NULL, NULL, NULL),
('Gather page titles from HTTP services', NULL, NULL, 1, 'checkbox', '--script=http-title', NULL, NULL, 'HTTP Service Information'),
('Get HTTP headers of web services', NULL, NULL, 1, 'checkbox', '--script=http-headers', NULL, NULL, 'HTTP Service Information'),
('Find web apps from known paths', NULL, NULL, 1, 'checkbox', '--script=http-enum', NULL, NULL, NULL),
('Only show open (or possibly open) ports', NULL, NULL, 1, 'checkbox', '--open', NULL, NULL, NULL),
('Show host interfaces and routes', NULL, NULL, 1, 'checkbox', '--iflist', NULL, NULL, NULL),
('Scan using IP protocol ping', NULL, NULL, 1, 'checkbox', '-PO', NULL, NULL, NULL),
('Scan using UDP ping', NULL, NULL, 1, 'checkbox', '-PU', NULL, NULL, NULL),
('TCP Fin scan to check firewall', NULL, NULL, 1, 'checkbox', '-sF', NULL, NULL, 'Scan a firewall for security weakness'),
('TCP Xmas scan to check firewall', NULL, NULL, 1, 'checkbox', '-sX', NULL, NULL, 'Scan a firewall for security weakness'),
('TCP Null Scan to fool a firewall to generate a response', NULL, NULL, 1, 'checkbox', '-sN', NULL, NULL, 'Scan a firewall for security weakness'),
('Interfaces', NULL, NULL, 1, 'input', '-e', 'eth0', NULL, 'INTERFACE'),
('Timing template', 'Set timing template (higher is faster)', NULL, 1, 'input', '-T', '1-5', NULL, 'TIMING'),
('Host timeout', 'Give up on target after this long', NULL, 1, 'input', '--host-timeout', NULL, NULL, 'TIMING'),
('Scan delay', 'Adjust delay between probes', NULL, 1, 'input', '--scan-delay', NULL, NULL, 'TIMING'),
('Min rate', 'Send packets no slower than <number> per second', NULL, 1, 'input', '--min-rate', '10', NULL, 'TIMING'),
('Max rate', 'Send packets no faster than <number> per second', NULL, 1, 'input', '--max-rate', '100', NULL, 'TIMING'),
('Script', 'Comma separated list of directories, script-files or script-categories', NULL, 1, 'input', '--script', 'default', NULL, 'SCRIPTING'),
('Script args', 'Provide arguments to scripts', NULL, 1, 'input', '--script-args', NULL, NULL, 'SCRIPTING'),
('Script trace', 'Show all data sent and received', NULL, 1, 'checkbox', '--script-trace', NULL, NULL, 'SCRIPTING');

--
-- Populate data for `commands`: theHarvester
--
INSERT INTO `commands` (`name`, `description`, `examples`, `tool`, `type`, `command`, `example`, `sudo`, `category`) VALUES
('Perform a DNS TLD expansion', NULL, NULL, 3, 'checkbox', '-t', NULL, NULL, NULL),
('Perform a DNS brute force', NULL, NULL, 3, 'checkbox', '-c', NULL, NULL, NULL),
('Perform a DNS reverse query', NULL, NULL, 3, 'checkbox', '-n', NULL, NULL, NULL),
('Use this DNS server', NULL, NULL, 3, 'input', '-e', 'Set a DNS server', NULL, NULL),
('Limit the number of results to work with', NULL, NULL, 3, 'input', '-l', 'Google goes from 100 to 100', NULL, NULL),
('Start in result number', NULL, NULL, 3, 'input', '-s', 'Default 0', NULL, NULL),
('Data source', NULL, NULL, 3, 'input', '-b', 'Ex.: google,bing,linkedin', NULL, NULL),
('Verify host name and search for virtual hosts', NULL, NULL, 3, 'checkbox', '-v', NULL, NULL, NULL);

--
-- Populate data for `commands`: dnstracer
--
INSERT INTO `commands` (`name`, `description`, `examples`, `tool`, `type`, `command`, `example`, `sudo`, `category`) VALUES
('Use this source address', NULL, NULL, 8, 'input', '-S', NULL, NULL, NULL),
('Limit time to wait per try', NULL, NULL, 8, 'input', '-t', NULL, NULL, NULL),
('Don''t query IPv6 servers', NULL, NULL, 8, 'checkbox', '-4', NULL, NULL, NULL),
('Show all details and informations', NULL, NULL, 8, 'checkbox', '-v', NULL, NULL, NULL),
('Retry limit', NULL, NULL, 8, 'input', '-r', 'Ex: 1', NULL, NULL),
('Specific the register type', NULL, NULL, 8, 'input', '-q', 'Ex: A, AAA, MX, NS, TXT', NULL, NULL),
('Enable overview of received answers', NULL, NULL, 8, 'checkbox', '-o', NULL, NULL, NULL),
('Enable negative cache', NULL, NULL, 8, 'checkbox', '-C', NULL, NULL, NULL),
('Disable local caching', NULL, NULL, 8, 'checkbox', '-c', NULL, NULL, NULL);

--
-- Populate data for `commands`: dnstracer
--
INSERT INTO `commands` (`name`, `description`, `examples`, `tool`, `type`, `command`, `example`, `sudo`, `category`) VALUES
('Search', NULL, NULL, 15, 'input', 'search', 'To use this, clean target''s field.', NULL, NULL),
('Search emails with the local-part', NULL, NULL, 15, 'checkbox', '--local-part', NULL, NULL, NULL),
('Search emails with the password', NULL, NULL, 15, 'checkbox', '--password', NULL, NULL, NULL),
('Search emails with the domain', NULL, NULL, 15, 'checkbox', '--domain', NULL, NULL, NULL);

--
-- Populate data for `commands`: dnstracer
--
INSERT INTO `commands` (`name`, `description`, `examples`, `tool`, `type`, `command`, `example`, `sudo`, `category`) VALUES
('Traffic profile', NULL, NULL, 16, 'select', '-f astf/sfr_full_hackinsdn.py --astf#EMIX - Enterprise MIX traffic (customized by HackInSDN);-f cap2/dns.yaml#Simple DNS traffic;-f cap2/http_simple.yaml#Simple HTTP traffic;-f cap2/imix_hackinsdn_64_594_1518.yaml#IMIX - Internet MIX traffic (customized by HackInSDN)', NULL, NULL, NULL),
('Multiplier', NULL, NULL, 16, 'input', '-m', NULL, NULL, NULL),
('Duration', NULL, NULL, 16, 'input', '-d', NULL, NULL, NULL),
('Source addresses (list separated by +)', NULL, NULL, 16, 'input', '-t source', 'Example: 203.0.113.0/24+198.51.100.0/24', NULL, NULL),
('Destination addresses (list separated by +)', NULL, NULL, 16, 'input', '-t destination', 'Example: 192.0.2.0/24+198.18.0.0/15', NULL, NULL);

--
-- Populate data for `commands`: hping3
--
INSERT INTO `commands` (`name`, `description`, `examples`, `tool`, `type`, `command`, `value`, `example`, `sudo`, `category`) VALUES
('Packet count', 'Number of packages to send', 'hping3 --count 100', 18, 'input', '--count', '100', '100', NULL, 'COUNTER'),
('Interval', 'Wait X microseconds', 'hping3 --interval u1000', 18, 'input', '--interval', NULL, 'u10000', NULL, 'TIMER'),
('Debug', 'Debbuging info', 'hping3 --debug', 18, 'checkbox', '--debug', NULL, NULL, NULL, 'DEBUG'),
('Data size', NULL, 'hping3 --data 100', 18, 'input', '--data', NULL, '0', NULL, 'SIZE'),
('Verbose', 'Verbose mode', 'hping3 --verbose', 18, 'checkbox', '--verbose', NULL, NULL, NULL, 'DEBUG'),
('Fast', '10 packets for second (alias for --interval u10000)', 'hping3 --fast', 18, 'checkbox', '--fast', NULL, NULL, NULL, 'FLOOD'),
('Faster', '100 packets for second (alias for --interval u1000)', 'hping3 --faster', 18, 'checkbox', '--faster', NULL, NULL, NULL, 'FLOOD'),
('Flood', 'Send packets as fast as possible', 'hping3 --flood', 18, 'checkbox', '--flood', NULL, NULL, NULL, 'FLOOD'),
('Numeric output', 'No attempt will be made to lookup symbolic names for host addresses', 'hping3 --numeric', 18, 'checkbox', '--numeric', NULL, NULL, NULL, 'OUTPUT'),
('Quiet output', 'Nothing is displayed except the summary lines at startup time and when finished', 'hping3 --quiet', 18, 'checkbox', '--quiet', NULL, NULL, NULL, 'OUTPUT'),
('Mode', 'Default mode is TCP', 'hping3 --udp', 18, 'select', '#TCP Mode;--icmp #ICMP Mode; --udp #UDP Mode; --rawip #RawIP Mode; --scan #Scan Mode; --listen #Listen Mode', NULL, 'Yes', NULL, 'OUTPUT'),
('Destination port', 'UDP or TCP mode only', 'hping3 --destport 53', 18, 'input', '--destport', NULL, '53', 'Yes', NULL),
('Set do not fragment IP flag', 'IP mode only', 'hping3 --dontfrag', 18, 'checkbox', '--dontfrag', NULL, NULL, 'Yes', NULL),
('Split packets in more frag', 'IP mode only', 'hping3 --frag', 18, 'checkbox', '--frag', NULL, NULL, 'Yes', NULL),
('Spoof source address', 'IP mode only', 'hping3 --spoof IP_Addr', 18, 'input', '--spoof', NULL, '192.168.0.1', 'Yes', NULL),
('Random source address', 'IP mode only', 'hping3 --rand-source', 18, 'checkbox', '--rand-source', NULL, NULL, 'Yes', NULL),
('TTL', 'IP mode only', 'hping3 --ttl 64', 18, 'input', '--ttl', NULL, '64', 'Yes', NULL),
('MTU', 'IP mode only', 'hping3 --mtu MTU_Value', 18, 'input', '--mtu', NULL, NULL, 'Yes', NULL),
('ICMP Type', 'ICMP mode only', 'hping3 --icmptype ICMP_TYPE', 18, 'input', '--icmptype', NULL, '8', 'Yes', NULL),
('ICMP Code', 'ICMP mode only', 'hping3 --icmpcode ICMP_CODE', 18, 'input', '--icmpcode', NULL, '0', 'Yes', NULL),
('Source port', 'UDP or TCP mode only', 'hping3 --baseport 80', 18, 'input', '--baseport', NULL, '80', 'Yes', NULL),
('Set TCP ACK flag', 'TCP mode only', 'hping3 --ack', 18, 'checkbox', '--ack', NULL, NULL, 'Yes', NULL),
('Set TCP FIN flag', 'TCP mode only', 'hping3 --fin', 18, 'checkbox', '--fin', NULL, NULL, 'Yes', NULL),
('Set TCP SYN flag', 'TCP mode only', 'hping3 --syn', 18, 'checkbox', '--syn', NULL, NULL, 'Yes', NULL),
('Set TCP RST flag', 'TCP mode only', 'hping3 --rst', 18, 'checkbox', '--rst', NULL, NULL, 'Yes', NULL),
('Set TCP PUSH flag', 'TCP mode only', 'hping3 --push', 18, 'checkbox', '--push', NULL, NULL, 'Yes', NULL),
('Set TCP URG flag', 'TCP mode only', 'hping3 --urg', 18, 'checkbox', '--urg', NULL, NULL, 'Yes', NULL),
('Set interface', NULL, 'hping3 --interface', 18, 'input', '--interface', NULL, 'eth0', 'Yes', NULL);

--
-- Populate data for `commands`: slowloris
--
INSERT INTO `commands` (`name`, `description`, `examples`, `tool`, `type`, `command`, `value`, `example`, `sudo`, `category`) VALUES
('Port', 'Port of webserver, usually 80', NULL, 21, 'input', '--port', NULL, '80', NULL, NULL),
('Sockets', 'Number of sockets to use in the test', NULL, 21, 'input', '--sockets', NULL, '4', NULL, NULL),
('Verbose', 'Increases logging', NULL, 21, 'checkbox', '--verbose', NULL, NULL, NULL, NULL),
('User-agents', 'Randomizes user-agents with each request', NULL, 21, 'checkbox', '--randuseragents', NULL, NULL, NULL, NULL),
('HTTPS', 'Use HTTPS for the requests', NULL, 21, 'checkbox', '--https', NULL, NULL, NULL, NULL),
('Sleep time', 'Time to sleep between each header sent', NULL, 21, 'input', '--sleeptime', NULL, '5', NULL, NULL);

--
-- Populate data for `commands`: ping
--
INSERT INTO `commands` (`name`, `description`, `examples`, `tool`, `type`, `command`, `value`, `example`, `sudo`) VALUES
('IPv4', 'Use IPv4 only', 'ping -4', 22, 'checkbox', '-4', NULL, NULL, NULL),
('IPv6', 'Use IPv6 only', 'ping -6', 22, 'checkbox', '-6', NULL, NULL, NULL),
('Broadcast', 'Allow pinging a broadcast address', 'ping -b', 22, 'checkbox', '-b', NULL, NULL, NULL),
('Count', 'Stop after sending count ECHO_REQUEST packets', 'ping -c 4', 22, 'input', '-c', '4', '4', NULL),
('Print timestamp', 'Print timestamp (unix time + microseconds as in gettimeofday) before each line', 'ping -D', 22, 'checkbox', '-D', NULL, NULL, NULL),
('Interval', 'Wait interval seconds between sending each packet', 'ping -i 5', 22, 'input', '-i', NULL, '5', NULL),
('Interface', 'interface is either an address, an interface name or a VRF name', 'ping -I eth0', 22, 'input', '-I', NULL, 'eth0', NULL),
('Fragmentation', 'Path MTU discovery strategy', 'ping -M do', 22, 'select', '#Set DF flag but subject to PMTU checks by kernel, packets too large will be rejected;-M do #Do PMTU discovery, fragment locally when packet size is large;-M want #Do not set DF flag;-M dont', NULL, NULL, NULL),
('Numeric output', 'Numeric output only. No attempt will be made to lookup symbolic names for host addresses', 'ping -n', 22, 'checkbox', '-n', NULL, NULL, NULL),
('Missing answers', 'Report outstanding ICMP ECHO reply before sending next packet', 'ping -O', 22, 'checkbox', '-O', NULL, NULL, NULL),
('Quiet output', 'Nothing is displayed except the summary lines at startup time and when finished', 'ping -q', 22, 'checkbox', '-q', NULL, NULL, NULL),
('Quality of Service', 'Set Quality of Service -related bits in ICMP datagrams', 'ping -Q 10', 22, 'input', '-Q', NULL, '10', NULL),
('Record route', 'Bypass the normal routing tables and send directly to a host on an attached interface', 'ping -r', 22, 'checkbox', '-r', NULL, NULL, NULL),
('Packet size', 'Specifies the number of data bytes to be sent', 'ping -s 56', 22, 'input', '-s', NULL, '56', NULL),
('TTL', 'Set the IP Time to Live', 'ping -t 15', 22, 'input', '-t', NULL, '15', NULL),
('Verbose', 'Verbose output', 'ping -v', 22, 'checkbox', '-v', NULL, NULL, NULL),
('Deadline', 'Specify a timeout, in seconds, before ping exits regardless of how many packets have been sent or received', 'ping -w 3', 22, 'input', '-w', NULL, '5', NULL),
('Timeout', 'Time to wait for a response, in seconds', 'ping -W 1', 22, 'input', '-W', NULL, '1', NULL);

--
-- Populate data for `commands`: nikto
--
INSERT INTO `commands` (`name`, `description`, `examples`, `tool`, `type`, `command`, `value`, `example`) VALUES
('CGI dirs', 'Scan these CGI dirs: "none", "all", or values like "/cgi/ /cgi-a/"', 'nikto -C all', 4, 'input', '-C', NULL, 'all'),
('Display output', 'Turn on display output: (1) redirects, (2) cookies received, (3) 200 responses, (4) URLs which require authentication, (D) Debug, (E) All HTTP errors, (P) Print progress to STDOUT, (S) Scrub output of IPs and hostnames, (V) Verbose', 'nikto -Display 1VD', 4, 'input', '-Display', NULL, '1234E'),
('Evasion', 'Encoding technique: (1) Random URI encoding (non-UTF8), (2) Directory self-reference (/./), (3) Premature URL ending, (4) Prepend long random string, (5) Fake parameter, (6) TAB as request spacer, (7) Change the case of the URL, (8) Use Windows directory separator (\), (A) Use a carriage return (0x0d) as a request spacer, (B) Use binary value 0x0b as a request spacer', 'nikto -evasion 123', 4, 'input', '-evasion', NULL, '12345'),
('Follow redirects', 'Follow 3xx redirects to new location', 'nikto -followredirects', 4, 'checkbox', '-followredirects', NULL, NULL), 
('Authentication', 'format is id:pass or id:pass:realm', 'nikto -id user:pass', 4, 'input', '-id', NULL, 'user:pass:realm'),
('IPv4', 'IPv4 only', 'nikto -ipv4', 4, 'checkbox', '-ipv4', NULL, NULL),
('IPv6', 'IPv6 only', 'nikto -ipv6', 4, 'checkbox', '-ipv6', NULL, NULL),
('Max test time', 'Maximum testing time per host (e.g., 1h, 60m, 3600s)', 'nikto -maxtime 1h', 4, 'input', '-maxtime', NULL, '1h'),
('Mutate', 'Guess additional file names:(1) Test all files with all root directories, (2) Guess for password file names, (3) Enumerate user names via Apache (/~user type requests), (4) Enumerate user names via cgiwrap (/cgi-bin/cgiwrap/~user type requests), (5) Attempt to brute force sub-domain names, assume that the host name is the parent domain, (6) Attempt to guess directory names from the supplied dictionary file', 'nikto -mutate 123', 4, 'input', '-mutate', NULL, '123'),
('Disables DNS lookup', 'Disables DNS lookups', 'nikto -nolookup', 4, 'checkbox', '-nolookup', NULL, NULL),
('Disables the use of SSL', 'Disables the use of SSL', 'nikto -nossl', 4, 'checkbox', '-nossl', NULL, NULL),
('Strip trailing slash from URL', 'e.g., "/admin/" to "/admin"', 'nikto -noslash', 4, 'checkbox', '-noslash', NULL, NULL),
('No 404', 'Disables nikto attempting to guess a 404 page', 'nikto -no404', 4, 'checkbox', '-no404', NULL, NULL),
('Pause', 'Pause between tests (seconds)', 'nikto -Pause 30', 4, 'input', '-Pause', NULL, '10'),
('Port', 'Port to use (default 80)', 'nikto -Port 8080', 4, 'input', '-Port', NULL, '80'),
('Root', 'Prepend root value to all requests, format is /directory', 'nikto -root /dashboard', 4, 'input', '-root', NULL, '/directory'),
('SSL', 'Force SSL mode on port', 'nikto -ssl', 4, 'checkbox', '-ssl', NULL, NULL),
('Tuning', 'Scan tuning: (1) Interesting File / Seen in logs, (2) Misconfiguration / Default File, (3) Information Disclosure, (4) Injection (XSS/Script/HTML), (5) Remote File Retrieval - Inside Web Root, (6) Denial of Service, (7) Remote File Retrieval - Server Wide, (8) Command Execution / Remote Shell, (9) SQL Injection, (0) File Upload, (a) Authentication Bypass, (b) Software Identification, (c) Remote Source Inclusion, (d) WebService, (e) Administrative Console, (x) Reverse Tuning Options (i.e., include all except specified)', 'nikto -Tuning 123', 4, 'input', '-Tuning', NULL, '123'),
('Timeout', 'Timeout for requests', 'nikto -timeout 10', 4, 'input', '-timeout', NULL, '10'),
('User-agent', 'Over-rides the default useragent', 'nikto -useragent "test"', 4, 'input', '-useragent', NULL, 'User-Agent Test'),
('Use cookies', 'Use cookies from responses in future requests', 'nikto -usecookies', 4, 'checkbox', '-usecookies', NULL, NULL),
('Proxy', 'Use proxy', 'nikto -useproxy http://server:port', 4, 'input', '-useproxy', NULL, 'http://server:port'),
('Virtualhost', 'Virtual host for Host header', 'nikto -vhost example.com', 4, 'input', '-vhost', NULL, 'example.com'),
('Ignore HTTP codes', 'Ignore these HTTP codes as negative responses (always). Format is "302,301"', 'nikto -404code 302,301', 4, 'input', '-404code', NULL, '302,301'),
('Ignore string responses', 'Ignore this string in response body content as negative response (always). Can be a regular expression', 'nikto -404string Error', 4, 'input', '-404string', NULL, 'Error string');

--
-- Populate data for `commands`: traceroute
--
INSERT INTO `commands` (`name`, `description`, `examples`, `tool`, `type`, `command`, `value`, `example`) VALUES
('Source port', 'Use source port num for outgoing packets', 'traceroute --sport=80', 23, 'input', '--sport=', NULL, '80'),
('IPv4', 'Use IPv4', 'traceroute -4', 23, 'checkbox', '-4', NULL, NULL),
('IPv6', 'Use IPv6', 'traceroute -6', 23, 'checkbox', '-6', NULL, NULL),
('Debug', 'Socket level debugging', 'traceroute -d', 23, 'checkbox', '-d', NULL, NULL),
('No fragmentation', 'Do not fragment packets', 'traceroute -F', 23, 'checkbox', '-F', NULL, NULL),
('First TTL', 'Start from the first_ttl hop, instead from 1', 'traceroute -f 10', 23, 'input', '-f', NULL, '10'),
('ICMP', 'Use ICMP ECHO for tracerouting', 'traceroute -I', 23, 'checkbox', '-I', NULL, NULL),
('TCP', 'Use TCP SYN for tracerouting', 'traceroute -T', 23, 'checkbox', '-T', NULL, NULL),
('Interface', 'Network interface to operate with', 'traceroute -i eth0', 23, 'input', '-i', NULL, 'eth0'),
('Max TTL', 'Max number of hops', 'traceroute -m 10', 23, 'input', '-m', NULL, '10'),
('Queries', 'Set the number of probes to be tried simultaneously', 'traceroute -N 16', 23, 'input', '-N', NULL, '16'),
('No resolve', 'Do not resolve IP addresses', 'traceroute -n', 23, 'checkbox', '-n', NULL, NULL),
('TOS', 'Set IPv4 Type of Service or IPv6 Traffic class', 'traceroute -t 8', 23, 'input', '-t', NULL, '8'),
('Flow label', 'Use specified flow_label for IPv6 packets', 'traceroute -l 16', 23, 'input', '-l', NULL, '16'),
('Hop queries', 'Set the number of probes per each hop', 'traceroute -q 3', 23, 'input', '-q', NULL, '3'),
('Route', 'Bypass the normal routing and send directly to a host on a attached network', 'traceroute -r', 23, 'checkbox', '-r', NULL, NULL),
('Source address', 'Use source src_addr for outgoing packets', 'traceroute -s 127.0.0.1', 23, 'input', '-s', NULL, '127.0.0.1'),
('Send wait', 'Minimal time interval between probes (If the value is more than 10, then it specifies a number in milliseconds, else it is a number of seconds)', 'traceroute -z 3', 23, 'input', '-z', NULL, '3'),
('UDP port', 'Use UDP to particular port for tracerouting (instead of increasing the port per each probe)', 'traceroute -U 53', 23, 'input', '-U', NULL, '53'),
('MTU', 'Discover MTU along the path being traced', 'traceroute --mtu', 23, 'checkbox', '--mtu', NULL, NULL);

--
-- Populate data for `commands`: h2t
--
INSERT INTO `commands` (`name`, `description`, `examples`, `tool`, `type`, `command`, `example`) VALUES
('Verbose', 'Verbose output', 'h2t scan', 24, 'checkbox', '-v', NULL),
('Verboser', 'More verbose output', 'h2t scan', 24, 'checkbox', '-vv', NULL),
('Good headers', 'Scan good headers only', 'h2t scan', 24, 'checkbox', '-g', NULL),
('Bad headers', 'Scan bad headers only', 'h2t scan', 24, 'checkbox', '-b', NULL),
('No banner', 'Do not print h2t banner', 'h2t scan', 24, 'checkbox', '--no-banner', NULL),
('No explanation', 'Do not print h2t output explanation', 'h2t scan', 24, 'checkbox', '--no-explanation', NULL),
('No redirect', 'Do not follow http redirects', 'h2t scan', 24, 'checkbox', '--no-redirect', NULL),
('Insecure', 'Do not verify SSL certificate', 'h2t scan', 24, 'checkbox', '--insercure', NULL),
('Status output', 'output actual status (eg: existent headers only)', 'h2t scan', 24, 'checkbox', '--status', NULL),
('User-Agent', 'Set user-agent', 'h2t scan', 24, 'input', '--user-agent', 'h2t user-agent'),
('Headers', 'Scan only these headers', 'h2t scan', 24, 'input', '--headers', 'X-Frame-Options Server'),
('Print output', 'A list of additional information about the headers to print (description and/or refs)', 'h2t scan', 24, 'input', '--print', 'description refs'),
('Ignore headers', 'A list of headers to ignore in the results', 'h2t scan', 24, 'input', '--ignore-headers', 'Server X-Frame-Options');

--
-- Populate data for `commands`: arjun
--
INSERT INTO `commands` (`name`, `description`, `examples`, `tool`, `type`, `command`, `example`) VALUES
('Quiet', 'Quiet mode, no output', 'arjun -q', 25, 'checkbox', '-q', NULL),
('Stable', 'Prefer stability over speed', 'arjun --stable', 25, 'checkbox', '--stable', NULL),
('No redirects', 'Disable redirects', 'arjun --disable-redirects', 25, 'checkbox', '--disable-redirects', NULL),
('Delay', 'Delay between requests in seconds', 'arjun -d 0', 25, 'input', '-d', '0'),
('Threads', 'Number of concurrent threads', 'arjun -t 5', 25, 'input', '-t', '5'),
('Timeout', 'HTTP request timeout in seconds', 'arjun -T 15', 25, 'input', '-T', '15'),
('Chunk size', 'The number of parameters to be sent at once', 'arjun -c 10', 25, 'input', '-c', '10'),
('Include data', 'Include this data in every request', 'arjun --include TEST', 25, 'input', '--include', 'TESTE'),
('Headers', 'Add headers. Separate multiple headers with a new line', "arjun --headers 'H1: 1\nH2: 2'", 25, 'input', '--headers', "'H1: 1\nH2: 2'"),
('Method', 'Request method to use', 'arjun -m GET', 25, 'select', '-m GET#GET; -m POST#POST; -m XML#XML; -m JSON #JSON; -m HEADERS #HEADERS', NULL);

--
-- Populate data for `commands`: sqlmap
--
INSERT INTO `commands` (`name`, `description`, `examples`, `tool`, `type`, `command`, `example`) VALUES
('Random user-agent', 'Use randomly selected HTTP User-Agent header value', 'sqlmap --random-agent', 26, 'checkbox', '--random-agent', NULL),
('Retrieve all', 'Retrieve everything', 'sqlmap --all', 26, 'checkbox', '--all', NULL),
('DBMS banner', 'Retrieve DBMS banner', 'sqlmap --banner', 26, 'checkbox', '--banner', NULL),
('Current user', 'Retrieve DBMS current user', 'sqlmap --current-user', 26, 'checkbox', '--current-user', NULL),
('Current database', 'Retrieve DBMS current database', 'sqlmap --current-db', 26, 'checkbox', '--current-db', NULL),
('Hostname', 'Retrieve DBMS server hostname', 'sqlmap --hostname', 26, 'checkbox', '--hostname', NULL),
('Is DBA?', 'Detect if the DBMS current user is DBA', 'sqlmap --is-dba', 26, 'checkbox', '--is-dba', NULL),
('Passwords', 'Enumerate DBMS users password hashes', 'sqlmap --passwords', 26, 'checkbox', '--passwords', NULL),
('Users', 'Enumerate DBMS users', 'sqlmap --users', 26, 'checkbox', '--users', NULL),
('Privileges', 'Enumerate DBMS users privileges', 'sqlmap --privileges', 26, 'checkbox', '--privileges', NULL),
('Roles', 'Enumerate DBMS users roles', 'sqlmap --roles', 26, 'checkbox', '--roles', NULL),
('Databases', 'Enumerate DBMS databases', 'sqlmap --dbs', 26, 'checkbox', '--dbs', NULL),
('Tables', 'Enumerate DBMS database tables', 'sqlmap --tables', 26, 'checkbox', '--tables', NULL),
('Columns', 'Enumerate DBMS database table columns', 'sqlmap --columns', 26, 'checkbox', '--columns', NULL),
('Schema', 'Enumerate DBMS schema', 'sqlmap --schema', 26, 'checkbox', '--schema', NULL),
('Dump', 'Dump DBMS database table entries', 'sqlmap --dump', 26, 'checkbox', '--dump', NULL),
('Dump all', 'Dump all DBMS databases tables entries', 'sqlmap --dump-all', 26, 'checkbox', '--dump-all', NULL),
('Flush session', 'Flush session files for current target', 'sqlmap --flush-session', 26, 'checkbox', '--flush-session', NULL),
('Disable colors', 'Disable console output coloring', 'sqlmap --disable-coloring', 26, 'checkbox', '--disable-coloring', NULL),
('Fingerprint', 'Perform an extensive DBMS version fingerprint', 'sqlmap --fingerprint', 26, 'checkbox', '--fingerprint', NULL),
('Database', 'DBMS database to enumerate', 'sqlmap -D database', 26, 'input', '-D', 'database'),
('Table', 'DBMS database table(s) to enumerate', 'sqlmap -T table', 26, 'input', '-T', 'table'),
('Column', 'DBMS database table column(s) to enumerate', 'sqlmap -C column', 26, 'input', '-C', 'column'),
('Verbosity', 'Verbosity level: from 0 to 6', 'sqlmap -v 3', 26, 'input', '-v', '3'),
('Level', 'Level of tests to perform: from 1 to 5', 'sqlmap --level 5', 26, 'input', '--level', '5'),
('Risk', 'Risk of tests to perform: from 1 to 3', 'sqlmap --risk 3', 26, 'input', '--risk', '3'),
('Cookie', 'HTTP Cookie header value', 'sqlmap --cookie "PHPSESSID=a8d127e..."', 26, 'input', '--cookie', '"PHPSESSID=a8d127e"'),
('Data', 'Data string to be sent through POST', 'sqlmap --data "id=1"', 26, 'input', '--data', '"id=1"'),
('Parameter', 'Testable parameter(s)', 'sqlmap -p id', 26, 'input', '-p', 'id'),
('DBMS', 'Force back-end DBMS to provided value', 'sqlmap --dbms MySQL', 26, 'input', '--dbms', 'MySQL'),
('True detection string', 'String to match when query is evaluated to True', 'sqlmap --string "STR"', 26, 'input', '--string', '"STR"'),
('False detection string', 'String to match when query is evaluated to False', 'sqlmap --no-string "NOSTR"', 26, 'input', '--no-string', '"NOSTR"'),
('Regex detection', 'Regexp to match when query is evaluated to True', 'sqlmap --regexp "REGEX"', 26, 'input', '--regexp', '"REGEX"'),
('HTTP Code', 'HTTP code to match when query is evaluated to True', 'sqlmap --code 200', 26, 'input', '--code', '200'),
('Optmization', 'Turn on all optimization switches', 'sqlmap -o', 26, 'checkbox', '-o', NULL),
('Predict output', 'Predict common queries output', 'sqlmap --predict-output', 26, 'checkbox', '--predict-output', NULL),
('HTTP keep alive', 'Use persistent HTTP(s) connections', 'sqlmap --keep-alive', 26, 'checkbox', '--keep-alive', NULL),
('Threads', 'Max number of concurrent HTTP(s) requests', 'sqlmap --threads 1', 26, 'input', '--threads', '1'),
('Skip parameters', 'Skip testing for given parameter(s)', 'sqlmap --skip "name"', 26, 'input', '--name', '"name"'),
('Forms', 'Parse and test forms on target URL', 'sqlmap --forms', 26, 'checkbox', '--forms', NULL),
('Web root dir', 'Web server document root directory', 'sqlmap --web-root /var/www', 26, 'input', '--web-root', '/var/www'),
('Force SSL', 'Force usage of SSL/HTTPS', 'sqlmap --force-ssl', 26, 'checkbox', '--force-ssl', NULL),
('No redirects', 'Ignore redirection attempts', 'sqlmap --ignore-redirects', 26, 'checkbox', '--ignore-redirects', NULL),
('Ignore timeouts', 'Ignore connection timeouts', 'sqlmap --ignore-timeouts', 26, 'checkbox', '--ignore-timeouts', NULL),
('No URL encode', 'Skip URL encoding of payload data', 'sqlmap --skip-urlencode', 26, 'checkbox', '--skip-urlencode', NULL),
('User-agent', 'HTTP User-Agent header value', 'sqlmap -A "Mozilla"', 26, 'input', '-A', '"Mozilla"'),
('Headers', 'Extra headers', 'sqlmap --headers "X-Forwarded-For: 127.0.0.1"', 26, 'input', '--headers', '"X-Forwarded-For: 127.0.0.1"'),
('Method', 'Force usage of given HTTP method', 'sqlmap --method PUT', 26, 'input', '--method', 'PUT'),
('Timeout', 'Seconds to wait before timeout connection', 'sqlmap --timeout 5', 26, 'input', '--timeout', '5'),
('Retries', 'Retries when the connection timeouts', 'sqlmap --retries 3', 26, 'input', '--retries', '3'),
('CSRF token', 'Parameter used to hold anti-CSRF token', 'sqlmap --csrf-token CSRF', 26, 'input', '--csrf-token', 'CSRF'),
('CSRF url', 'URL address to visit for extraction of anti-CSRF token', 'sqlmap --csrf-url http://...', 26, 'input', '--csrf-url', 'http://...'),
('CSRF method', 'HTTP method to use during anti-CSRF token page visit', 'sqlmap --csrf-method GET', 26, 'input', '--csrf-method', 'GET'),
('CSRF data', 'POST data to send during anti-CSRF token page visit', 'sqlmap --csrf-data DATA', 26, 'input', '--csrf-data', 'DATA'),
('CSRF retries', 'Retries for anti-CSRF token retrieval', 'sqlmap --csrf-retries', 26, 'input', '--csrf-retries', '3'),
('Time sec', 'Seconds to delay the DBMS response', 'sqlmap --time-sec 5', 26, 'input', '--time-sec', '5'),
('Techniques', 'SQL injection techniques to use', 'sqlmap --technique BEUSTQ', 26, 'input', '--technique', 'BEUSTQ');

--
-- Populate data for `commands`: iperf
--
INSERT INTO `commands` (`name`, `description`, `examples`, `tool`, `type`, `command`, `example`) VALUES
('Port', 'Set server port to listen on/connect to', 'iperf3 --port 5201', 19, 'input', '--port', '5201'),
('Output format', 'format to report: Kbits/Mbits/Gbits/Tbits: kmgtKMGT', 'iperf3 --format M', 19, 'input', '--format', 'M'),
('Interval', 'pause n seconds between periodic throughput reports', 'iperf3 --interval 1', 19, 'input', '--interval', '1'),
('Verbose', 'Verbose output', 'iperf3 --verbose', 19, 'checkbox', '--verbose', NULL),
('Debug', 'Debug output', 'iperf3 --debug', 19, 'checkbox', '--debug', NULL),
('Mode', 'Server or client mode', 'iperf3 -s', 19, 'select', '--server #Server mode;--client #Client mode', NULL),
('Use SCTP', '(client only) use SCTP rather than TCP', 'iperf3 --sctp', 19, 'checkbox', '--sctp', NULL),
('Use UDP', '(client only) use UDP rather than TCP', 'iperf3 --udp', 19, 'checkbox', '--udp', NULL),
('Timeout', '(client only) set timeout for establishing the initial control connection to the server in milliseconds', 'iperf3 --connect-timeout 10000', 19, 'input', '--connect-timeout', '10000'),
('Time to transmit', '(client only) time in seconds to transmit for', 'iperf3 --time 10', 19, 'input', '--time', '10'),
('Client port', '(client only) bind data streams to a specific client port', 'iperf3 --cport 8000', 19, 'input', '--cport', '8000'),
('Parallel', '(client only) number of parallel client streams to run', 'iperf3 --parallel 2', 19, 'input', '--parallel', '2'),
('Reverse direction', '(client only) the server sends data to the client', 'iperf3 --reverse', 19, 'checkbox', '--reverse', NULL),
('Both direction', '(client only) test in both directions (normal and reverse), with both the client and server sending and receiving data simultaneously', 'iperf3 --bidir', 19, 'checkbox', '--bidir', NULL),
('IPv4', '(client only) only use IPv4', 'iperf3 -4', 19, 'checkbox', '-4', NULL),
('IPv6', '(client only) only use IPv6', 'iperf3 -6', 19, 'checkbox', '-6', NULL),
('Flowlabel', '(client only) set the IPv6 flow label', 'iperf3 --flowlabel 0', 19, 'input', '--flolabel', '0'),
('Zerocopy', '(client only) Use a "zero copy" method of sending data', 'iperf3 --zerocopy', 19, 'checkbox', '--zerocopy', NULL),
('Dont fragment', '(client only) Set the IPv4 Dont Fragment (DF) bit on outgoing packets', 'iperf3', 19, 'checkbox', '--dont-fragment', NULL);

-- --------------------------------------------------------

--
-- Structure for table `reports`
--

CREATE TABLE `reports` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `tools` varchar(100) DEFAULT NULL,
  `command` varchar(500) DEFAULT NULL,
  `output` text DEFAULT NULL,
  `solution` text DEFAULT NULL,
  `dataHour` datetime DEFAULT NULL
);

--
-- Populate data `reports`
--

INSERT INTO `reports` (`id`, `name`, `tools`, `command`, `output`, `solution`, `dataHour`) VALUES
(23, 'Teste', 'Nmap: the Network Mapper', 'nmap  -A localhost', '[sudo] senha para kali: Starting Nmap 7.70 ( https://nmap.org ) at 2019-06-28 16:26 -03\nNmap scan report for localhost (127.0.0.1)\nHost is up (0.000060s latency).\nOther addresses for localhost (not scanned): ::1\nNot shown: 998 closed ports\nPORT   STATE SERVICE VERSION\n22/tcp open  ssh     OpenSSH 7.9p1 Debian 10 (protocol 2.0)\n| ssh-hostkey: \n|   2048 93:c0:bd:e9:89:88:14:ba:0c:a0:a6:52:cb:a8:2e:0e (RSA)\n|   256 6c:81:1c:f9:e4:c0:7d:98:ea:8b:f4:41:58:ad:0e:75 (ECDSA)\n|_  256 55:08:ac:7c:6f:8f:0d:9c:c1:bf:e7:ae:1f:f8:eb:81 (ED25519)\n80/tcp open  http    nginx 1.14.2\n|_http-server-header: nginx/1.14.2\n|_http-title: Welcome to nginx!\nDevice type: general purpose\nRunning: Linux 3.X\nOS CPE: cpe:/o:linux:linux_kernel:3\nOS details: Linux 3.7 - 3.10\nNetwork Distance: 0 hops\nService Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel\n\nOS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .\nNmap done: 1 IP address (1 host up) scanned in 11.97 seconds\n', 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using ''Content here, content here'', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for ''lorem ipsum'' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).\r\n\r\n', '2019-06-28 16:27:13'),
(60, 'theHarvester', 'Gmail - Pesquisa de e-mails', 'python /home/kali/Downloads/theHarvester/theHarvester.py  -b google -l 50 -d gmail.com', '[-] Searching in Google:\n	Searching 0 results...\n\n[+] Emails found:\n------------------\nexample@gmail.com\nexamp1e@gmail.com\nfolha.campinas@gmail.com\nprodutividade.coop.rj@gmail.com\npereirabarbosa.joao@gmail.com\nhello@gmail.com\nhumoristarudy@gmail.com\naugustolessa.rj@gmail.com\nmaria.nazareth.52@gmail.com\nedilson@gmail.com\nselecaoll2017@gmail.com\nusername@gmail.com\nquermesse.restaurante@gmail.com\npickalimentos@gmail.com\nsucuricleanups2@gmail.com\nflaviag.neide@gmail.com\nAmazonasautomoveis@gmail.com\nAmazonasautomoveis@gmail.com\nilankriger@gmail.com\n2606iolanda@gmail.com\npousadatocadosursos@gmail.com\nadrientwu@gmail.com\nsniprosperidadevilasonia@gmail.com\nbeechamanda@gmail.com\njohn.doe@gmail.com\njohndoe@gmail.com\nmagi.tonis@gmail.com\ngustavo.brafman@gmail.com\nmfatima.silva22@gmail.com\nlmgrh1@gmail.com\nmarliquantica@gmail.com\npatimezzomo@gmail.com\nrefrig.ar.nilson@gmail.com\nneedessentials1@gmail.com\nneeraj.knit06@gmail.com\nJennyseomarketing010@gmail.com\njennyseomarketing010@gmail.com\njeanhtorres@gmail.com\nGuerillaClick@gmail.com\nguerillaclick@gmail.com\npousadacasadasfontes@gmail.com\nlucasgiovanny@gmail.com\nyourname@gmail.com\nyour.name@gmail.com\ny.o.u.r.n.a.m.e.@gmail.com\n11wcc.rio@gmail.com\nvfcadettes@gmail.com\nconveniadagremioviamao@gmail.com\nvovoanitagramado@gmail.com\nhotelkamomil@gmail.com\nchansookchoi@gmail.com\nxyz@mail.gmail.com\ncojacre@gmail.com\nrafabastos.1999@gmail.com\nggloriassousa@gmail.com\ninstitutoibrae@gmail.com\niaupe.carnaiba2019@gmail.com\nyourusername@gmail.com\n\n[+] Hosts found in search engines:\n------------------------------------\n172.217.30.5:www.gmail.com\n64.233.186.108:smtp.gmail.com\n64.233.190.108:imap.gmail.com\n', '<b>theHarvester</b> is a great tool for collecting information from a particular host, with it it is possible to get a list of emails, subdomains, hosts, employee names, open ports, banners from different public sources, PGP keys and mapped information by SHODAN.\r\n\r\n<h2 style=''color: white''>FIX THIS</h2>\r\n<p>\r\nThe information found by theHarvester is indexed in Internet pages. If you want to hide this content you need to identify in the source of this information.\r\nFor this, one can be applied techniques like Google Hacking to refine the search in search engines users by theHarvester.\r\n\r\nOnce the data source is identified, you can hide or delete the data, for example, from a social network. If it is a content of your own, such as a personal blog, just create a robots.txt file and hide the pages that have the information.\r\n</p>\r\n\r\n\r\n<h2 style=''color: white''>USEFUL LINKS</h2>\r\n<strong>\r\n  <a href=\"https://securitytrails.com/blog/google-hacking-techniques\" class=\"text-warning\">• Google Hacking Techniques</a><br>\r\n  <a href=\"https://www.searchenginejournal.com/best-practices-setting-meta-robots-tags-robots-txt/188655/\" class=\"text-warning\">• Best Practices robots.txt</a>\r\n\r\n</strong>', '2019-07-01 22:17:46'),
(62, 'Karma', 'Varredura example@gmail.com', 'karma  target example@gmail.com', '[sudo] password for kali: [32m[+] starting search [00m\n[32m[+] 1/1 request email: example@gmail.com [00m\n[32m[+] analyzing results: [00m\n[32m[+] 60 results found in 2.80s [00m\n\n\n	A J V T B Y 0 T 5\n	C U F I N 1 Q G V\n	P H R K A J C X M\n	I G F 4 T G E M K\n	T H J S U 2 G 1 9\n	8 B S B F W 0 R M\n	0 Z [1mK A R M A [0mA X\n	W 2 V T A C L 1 Z\n	Y 6 W G I V S 3 Z\n	X S E 6 E C S V D\n	G Q 7 B X N P U T\n	A 1 L X F W V Y 5\n\n	decoxviii\n	1.2.1\n\n+-------------------+----------------------------------+\n|       Email       |             Password             |\n+===================+==================================+\n| example@gmail.com | pokelion                         |\n| example@gmail.com | 89151321781                      |\n| example@gmail.com | 123qwe321Ewq                     |\n| example@gmail.com | buzzman                          |\n| example@gmail.com | 123qwe321Ewq                     |\n| example@gmail.com | santiago                         |\n| example@gmail.com | cynthia                          |\n| example@gmail.com | bob                              |\n| Example@gmail.com | eclips1                          |\n| example@gmail.com | 0987654321                       |\n| example@gmail.com | abc123458                        |\n| example@gmail.com | 790223                           |\n| example@gmail.com | ep8c4600                         |\n| example@gmail.com | 15032000                         |\n| example@gmail.com | 20101997                         |\n| example@gmail.com | sushi                            |\n| example@gmail.com | password                         |\n| example@gmail.com | ff6sadfa4325342235233243dsffds   |\n| example@gmail.com | gandjubasik_91                   |\n| example@gmail.com | kaylateam23                      |\n| example@gmail.com | andreev                          |\n| example@gmail.com | 1234560                          |\n| example@gmail.com | 15108302012                      |\n| example@gmail.com | 593555                           |\n| example@gmail.com | 12345                            |\n| example@gmail.com | gandjubasik_91                   |\n| example@gmail.com | asdfghjk                         |\n| example@gmail.com | 89506752655                      |\n| example@gmail.com | bagrat                           |\n| example@gmail.com | December                         |\n| example@gmail.com | Squid                            |\n| example@gmail.com | ekawebop                         |\n| example@gmail.com | lol                              |\n| example@gmail.com | stormy                           |\n| example@gmail.com | Example213                       |\n| example@gmail.com | 123123123                        |\n| Example@gmail.com | 1234567                          |\n| example@gmail.com | Connor12                         |\n| example@gmail.com | hi                               |\n| example@gmail.com | 08amy                            |\n| example@gmail.com | mastergamer12                    |\n| example@gmail.com | 1234567890                       |\n| example@gmail.com | 01012243                         |\n| example@gmail.com | loulou17                         |\n| example@gmail.com | hiseth                           |\n| example@gmail.com | elementqaz                       |\n| example@gmail.com | Volution                         |\n| example@gmail.com | 45165153                         |\n| example@gmail.com | 2346689512513                    |\n| example@gmail.com | fcea920f7412b5da7be0cf42b8c93759 |\n| example@gmail.com | hiltonlover77                    |\n| example@gmail.com | aak2002dn                        |\n| example@gmail.com | 1234567                          |\n| example@gmail.com | westpark1                        |\n| example@gmail.com | 123456                           |\n| example@gmail.com | pic                              |\n| example@gmail.com | example@gmail.com                |\n| example@gmail.com | scorpian7887                     |\n| example@gmail.com | 89506752655                      |\n| example@gmail.com | brantford1                       |\n+-------------------+----------------------------------+\n', '<b>Karma</b> find leaked emails with your passwords. If you have located a known password linked to your email, you MUST change it immediately.\r\n\r\n<h2 style=''color: white''>FIX THIS</h2>\r\n<p>It is recommended to <b>change the password of your email and all the services you use</b> (Facebook, Twitter, Snapchat, Instagram, Netflix, Spotify, etc). To do so, go to the official website or service app and change your password in SETTINGS.</p>\r\n\r\n<p><b>Create a strong password</b> that is totally different from the current one and avoid using personal data such as date of birth, name, cpf, etc. Combining letters, numbers and special characters will only increase your security.</p>\r\n\r\n<h2 style=''color: white''>PROTECTION</h2>\r\n<p>To increase your security, it is recommended that you <b>enable two-factor authentication</b>.</p>', '2019-07-05 09:09:55');

-- --------------------------------------------------------

--
-- Structure for table `tools`
--

CREATE TABLE `tools` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `fullname` varchar(150) DEFAULT NULL,
  `categories` varchar(300) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `site` varchar(100) DEFAULT NULL,
  `github` varchar(500) DEFAULT NULL,
  `released` tinytext DEFAULT NULL,
  `avatar` varchar(100) DEFAULT NULL,
  `cmd` varchar(100) DEFAULT NULL,
  `target` varchar(10) DEFAULT NULL,
  `resume` text DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `category2` varchar(100) DEFAULT NULL,
  `solution` text DEFAULT NULL
);

--
-- Populate data `tools`
--

INSERT INTO `tools` (`id`, `name`, `fullname`, `categories`, `description`, `site`, `github`, `released`, `avatar`, `cmd`, `target`, `resume`, `category`, `category2`, `solution`) VALUES
(1, 'Nmap', 'Nmap: the Network Mapper', 'information-gathering  vulnerability -analysis', 'https://tools.kali.org/information-gathering/nmap', 'https://insecure.org/', NULL, 'Yes', 'assets/img/nmap.jpg', 'nmap', NULL, 'Nmap (“Network Mapper”) is a free and open source (license) utility for network discovery and security auditing. Many systems and network administrators also find it useful for tasks such as network inventory, managing service upgrade schedules, and monitoring host or service uptime.', 'Information Gathering', 'Vulnerability Analysis', '<b>Nmap</b> works by checking a network for hosts and services. Once found, the software platform sends information to those hosts and services which then respond.\r\n\r\n<h2 style=''color: white''>FIX THIS</h2>\r\n<p></p>\r\n\r\n\r\n<h2 style=''color: white''>PROTECTION</h2>\r\n<p></p>'),
(2, 'BetterCap', 'bettercap', 'sniffing-spoofing', 'https://tools.kali.org/sniffingspoofing/bettercap', 'https://www.bettercap.org/', NULL, NULL, 'assets/img/bettercap.jpg', 'bettercap', NULL, NULL, 'Sniffing & Spoofing', NULL, NULL),
(3, 'theHarvester', 'theHarvester', 'information-gathering ', 'https://tools.kali.org/information-gathering/theharvester', NULL, 'https://github.com/laramies/theHarvester', NULL, NULL, 'python /home/kali/Downloads/theHarvester/theHarvester.py', '-d', 'The objective of this program is to gather emails, subdomains, hosts, employee names, open ports and banners from different public sources like search engines, PGP key servers and SHODAN computer database.', 'Information Gathering', NULL, '<b>theHarvester</b> is a great tool for collecting information from a particular host, with it it is possible to get a list of emails, subdomains, hosts, employee names, open ports, banners from different public sources, PGP keys and mapped information by SHODAN.\r\n\r\n<h2 style=''color: white''>FIX THIS</h2>\r\n<p>\r\nThe information found by theHarvester is indexed in Internet pages. If you want to hide this content you need to identify in the source of this information.\r\nFor this, one can be applied techniques like Google Hacking to refine the search in search engines users by theHarvester.\r\n\r\nOnce the data source is identified, you can hide or delete the data, for example, from a social network. If it is a content of your own, such as a personal blog, just create a robots.txt file and hide the pages that have the information.\r\n</p>\r\n\r\n\r\n<h2 style=''color: white''>USEFUL LINKS</h2>\r\n<strong>\r\n  <a href=\"https://securitytrails.com/blog/google-hacking-techniques\" class=\"text-warning\">• Google Hacking Techniques</a><br>\r\n  <a href=\"https://www.searchenginejournal.com/best-practices-setting-meta-robots-tags-robots-txt/188655/\" class=\"text-warning\">• Best Practices robots.txt</a>\r\n\r\n</strong>'),
(4, 'Nikto', 'Nikto', 'information-gathering  web-applications', 'https://tools.kali.org/information-gathering/nikto', 'https://www.cirt.net/Nikto2', 'https://github.com/sullo/nikto', 'Yes', 'assets/img/nikto.png', 'nikto', '-h', NULL, 'Information Gathering', 'Web Applications', NULL),
(5, 'Aircrack-ng', 'Airckack-ng', 'wireless- attacks', 'https://tools.kali.org/wireless-attacks/aircrack-ng', 'https://www.aircrack-ng.org/doku.php?id=aircrack-ng', 'https://gitlab.com/kalilinux/packages/aircrack-ng', NULL, NULL, NULL, NULL, NULL, 'Wireless Attacks', NULL, NULL),
(6, 'THC-Hydra', 'THC-Hydra', 'password-attacks', 'https://tools.kali.org/password-attacks/hydra', 'http://freeworld.thc.org/thc-hydra/', NULL, NULL, 'assets/img/hydrathc.jpg', NULL, NULL, NULL, 'Password Attacks', NULL, NULL),
(7, 'WPScan', 'WordPress Vulnerability Scanner', 'web-applications', 'https://tools.kali.org/web-applications/wpscan', 'http://wpscan.org/', 'https://github.com/wpscanteam/wpscan', NULL, 'assets/img/wpscan.png', 'wpscan', '--url', 'WPScan is a black box WordPress vulnerability scanner that can be used to scan remote WordPress installations to find security issues.', 'Web Applications', NULL, NULL),
(8, 'Dnstracer', 'dnstracer', 'information-gathering', 'https://tools.kali.org/information-gathering/dnstracer', 'http://freshmeat.net/projects/dnstracer', NULL, NULL, NULL, 'dnstracer', NULL, 'dnstracer determines where a given Domain Name Server (DNS) gets its information from for a given hostname, and follows the chain of DNS servers back to the authoritative answer.', 'Information Gathering', NULL, NULL),
(10, 'Sqlninja', 'Sqlninja', 'vulnerability-analysis  web-applications', 'https://tools.kali.org/vulnerability-analysis/sqlninja', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Vulnerability Analysis', 'Web Applications', NULL),
(11, 'Powerfuzzer', 'Powerfuzzer', 'vulnerability-analysis  web-applications', 'https://tools.kali.org/vulnerability-analysis/powerfuzzer', 'https://www.powerfuzzer.com/', NULL, NULL, NULL, NULL, NULL, NULL, 'Vulnerability Analysis', 'Web Applications', NULL),
(12, 'ProxyStrike', 'ProxyStrike', 'web-applications', 'https://tools.kali.org/web-applications/proxystrike', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Web Applications', NULL, NULL),
(14, 'Dnsenum', 'Dnsenum', 'information-gathering', 'https://tools.kali.org/information-gathering/dnsenum', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Information Gathering', NULL, NULL),
(15, 'Karma', 'Karma', 'information-gathering', NULL, NULL, 'https://github.com/decoxviii/karma', NULL, 'assets/img/github.jpg', 'karma', 'target', 'Find leaked emails with your passwords.', 'Information Gathering', NULL, '<b>Karma</b> find leaked emails with your passwords. If you have located a known password linked to your email, you MUST change it immediately.\r\n\r\n<h2 style=''color: white''>FIX THIS</h2>\r\n<p>It is recommended to <b>change the password of your email and all the services you use</b> (Facebook, Twitter, Snapchat, Instagram, Netflix, Spotify, etc). To do so, go to the official website or service app and change your password in SETTINGS.</p>\r\n\r\n<p><b>Create a strong password</b> that is totally different from the current one and avoid using personal data such as date of birth, name, cpf, etc. Combining letters, numbers and special characters will only increase your security.</p>\r\n\r\n<h2 style=''color: white''>PROTECTION</h2>\r\n<p>To increase your security, it is recommended that you <b>enable two-factor authentication</b>.</p>'),
(16, 'TRex', 'TRex: Realistic Traffic Generator', 'benign script-driven', 'https://trex-tgn.cisco.com', 'https://trex-tgn.cisco.com', 'https://github.com/cisco-system-traffic-generator', 'Yes', 'assets/img/trex.png', 'trex', NULL, 'TRex is an open source, low cost, stateful and stateless traffic generator fuelled by DPDK. It generates L3-7 traffic, and supports Stateless and Advanced Stateful functionality.', 'Benign', 'Script-driven', '<b>TRex</b> works by generating traffic using a stateless and statefull approach.\r\n\r\n<h2 style=''color: white''>FIX THIS</h2>\r\n<p></p>\r\n\r\n\r\n<h2 style=''color: white''>PROTECTION</h2>\r\n<p></p>'),
(17, 'httperf', 'httperf', 'benign application-level', 'https://github.com/httperf/httperf', 'https://github.com/httperf/httperf', 'https://github.com/httperf/httperf', NULL, NULL, 'httperf', NULL, NULL, 'Benign', 'Application level', '<b>NameTool</b> is aimed at testing the performance of a cybersecurity tools by generating real background network traffic.\r\n\r\n<h2 style=''color: white''>FIX THIS</h2>\r\n<p>TODO change me, <b>change me!</b> (XPTO, Foobar, etc). <p>Testing 123, tool to generate traffic security.</p>\r\n\r\n<h2 style=''color: white''>PROTECTION</h2>\r\n<p>To increase your security, it is recommended that you <b>enable two-factor authentication</b>.</p>'),
(18, 'hping3', 'hping3', 'benign throughput', 'http://www.hping.org', 'https://www.kali.org/tools/hping3/', NULL, 'Yes', 'assets/img/hping.svg', 'hping3', NULL, NULL, 'Benign', 'Throughput', '<b>hping</b> is aimed at testing the performance of a NIDS by replaying real background network traffic in which to hide attacks. Tcpreplay allows you to control the speed at which the traffic is replayed, and can replay arbitrary tcpdump traces.\r\n\r\n<h2 style=''color: white''>FIX THIS</h2>\r\n<p>TODO change me, <b>change me!</b> (XPTO, Foobar, etc). <p>Testing 123, tool to generate traffic security.</p>\r\n\r\n<h2 style=''color: white''>PROTECTION</h2>\r\n<p>To increase your security, it is recommended that you <b>enable two-factor authentication</b>.</p>'),
(19, 'iperf3', 'iperf3', 'benign throughput', 'perform network throughput tests', 'https://iperf.fr', 'https://github.com/esnet/iperf', 'Yes', NULL, 'iperf3', NULL, NULL, 'Benign', 'Throughput', '<b>iperf3</b> is aimed at testing the performance of a NIDS by replaying real background network traffic in which to hide attacks. Tcpreplay allows you to control the speed at which the traffic is replayed, and can replay arbitrary tcpdump traces.\r\n\r\n<h2 style=''color: white''>FIX THIS</h2>\r\n<p>TODO change me, <b>change me!</b> (XPTO, Foobar, etc). <p>Testing 123, tool to generate traffic security.</p>\r\n\r\n<h2 style=''color: white''>PROTECTION</h2>\r\n<p>To increase your security, it is recommended that you <b>enable two-factor authentication</b>.</p>'),
(20, 'd-itg', 'd-itg', 'benign model-based', 'https://traffic.comics.unina.it/software/ITG/', 'https://sources.debian.org/src/d-itg/', NULL, NULL, NULL, 'd-itg', NULL, NULL, 'Benign', 'Model-based', '<b>NameTool</b> is aimed at testing the performance of a cybersecurity tools by generating real background network traffic.\r\n\r\n<h2 style=''color: white''>FIX THIS</h2>\r\n<p>TODO change me, <b>change me!</b> (XPTO, Foobar, etc). <p>Testing 123, tool to generate traffic security.</p>\r\n\r\n<h2 style=''color: white''>PROTECTION</h2>\r\n<p>To increase your security, it is recommended that you <b>enable two-factor authentication</b>.</p>');

INSERT INTO `tools` (`id`, `name`, `fullname`, `categories`, `description`, `site`, `github`, `released`, `avatar`, `cmd`, `target`, `resume`, `category`, `category2`, `solution`) VALUES (21, 'slowloris', 'slowloris', 'denial-of-service', 'Low bandwidth DoS tool', 'https://github.com/gkbrk/slowloris', 'https://github.com/gkbrk/slowloris', 'Yes', NULL, 'slowloris', NULL, NULL, 'Denial of Service', NULL, NULL);
INSERT INTO `tools` (`id`, `name`, `fullname`, `categories`, `description`, `site`, `github`, `released`, `avatar`, `cmd`, `target`, `resume`, `category`, `category2`, `solution`) VALUES (22, 'ping', 'ping', 'benign throughput', 'send ICMP ECHO_REQUEST to network hosts', NULL, NULL, 'Yes', NULL, 'ping', NULL, NULL, 'Benign', 'Throughput', NULL);
INSERT INTO `tools` (`id`, `name`, `fullname`, `categories`, `description`, `site`, `github`, `released`, `avatar`, `cmd`, `target`, `resume`, `category`, `category2`, `solution`) VALUES (23, 'traceroute', 'traceroute', 'benign route', 'tracks the route packets taken from an IP network on their way to a given host', 'https://traceroute.sourceforge.net/', NULL, 'Yes', NULL, 'traceroute', NULL, NULL, 'Benign', 'Route', NULL);
INSERT INTO `tools` (`id`, `name`, `fullname`, `categories`, `description`, `site`, `github`, `released`, `avatar`, `cmd`, `target`, `resume`, `category`, `category2`, `solution`) VALUES (24, 'h2t', 'HTTP Hardening Tool', 'benign vulnerability-analysis', 'h2t (HTTP Hardening Tool) scans a website and suggests security headers to apply', 'https://certbahia.pop-ba.rnp.br/projects/h2t/', 'https://github.com/gildasio/h2t', 'Yes', NULL, 'h2t scan', '-- ', NULL, 'Benign', 'Vulnerability Analysis', NULL);
INSERT INTO `tools` (`id`, `name`, `fullname`, `categories`, `description`, `site`, `github`, `released`, `avatar`, `cmd`, `target`, `resume`, `category`, `category2`, `solution`) VALUES (25, 'arjun', 'arjun', 'information-gathering web-application', 'HTTP parameter discovery suite', NULL, 'https://github.com/s0md3v/Arjun', 'Yes', 'assets/img/arjun.png', 'arjun', '-u', NULL, 'Information-Gathering', 'Web-Application', NULL);
INSERT INTO `tools` (`id`, `name`, `fullname`, `categories`, `description`, `site`, `github`, `released`, `avatar`, `cmd`, `target`, `resume`, `category`, `category2`, `solution`) VALUES (26, 'sqlmap', 'sqlmap', 'web-application vulnerability-analysis', 'Automatic SQL injection and database takeover tool', 'https://sqlmap.org/', 'https://github.com/sqlmapproject/sqlmap', 'Yes', NULL, 'sqlmap --batch', '-u', NULL, 'Web-Application', 'Vulnerability-Analysis', NULL);


COMMIT;
