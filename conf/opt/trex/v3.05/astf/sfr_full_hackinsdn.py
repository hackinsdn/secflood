import argparse
from itertools import cycle
from trex.astf.api import *
from trex.stl.trex_stl_packet_builder_scapy import ip2int, int2ip
# Execution:
#   ./t-rex-64 --astf -f astf/sfr_full_hackinsdn.py -m 1 -d 30 -t source=192.168.0.0/24,destination=200.128.99.0/24+135.48.0.0/16+47.200.100.0/24+47.200.100.0/24+190.103.184.0/24+170.39.8.0/24+187.111.192.0/24+45.162.92.0/24+67.17.206.0/24


class Prof1():
    def __init__(self):
        # Default values for ip range, they can be overridden by --source and --destination options
        self.ip_gen_src_cycle = [ASTFIPGenDist(ip_range=["16.0.0.0", "16.0.0.255"], distribution="seq")]
        self.ip_gen_dst_cycle = [ASTFIPGenDist(ip_range=["48.0.0.0", "48.0.255.255"], distribution="seq")]

    def next_ip_gen(self):
        ip_gen_c = next(self.ip_gen_src_cycle)
        ip_gen_s = next(self.ip_gen_dst_cycle)
        ip_gen = ASTFIPGen(glob=ASTFIPGenGlobal(ip_offset="1.0.0.0"),
                           dist_client=ip_gen_c,
                           dist_server=ip_gen_s)
        return ip_gen

    def calc_ip_range(self, ip_cidr):
        ip, mask = ip_cidr.split("/")
        num_hosts = 2**(32 - int(mask))
        return int2ip(ip2int(ip) + 1), int2ip(ip2int(ip) + num_hosts - 1)

    def create_profile(self, source, destination):
        # ip generator
        ip_gen_c = []
        for src in source.split("+"):
            start, end = self.calc_ip_range(src)
            ip_gen_c.append(ASTFIPGenDist(ip_range=[start, end], distribution="rand"))
        ip_gen_s = []
        for dst in destination.split("+"):
            start, end = self.calc_ip_range(dst)
            ip_gen_s.append(ASTFIPGenDist(ip_range=[start, end], distribution="rand"))

        if ip_gen_c:
            self.ip_gen_src_cycle = cycle(ip_gen_c)
        if ip_gen_s:
            self.ip_gen_dst_cycle = cycle(ip_gen_s)

        c_glob_info = ASTFGlobalInfo()
        s_glob_info = ASTFGlobalInfo()
        c_glob_info.tcp.blackhole = 0
        s_glob_info.tcp.blackhole = 0

        profile = ASTFProfile(default_ip_gen=self.next_ip_gen(), cap_list=[
            ASTFCapInfo(file="../avl/delay_10_http_get_0.pcap", cps=102.0,port=8080, ip_gen=self.next_ip_gen()),
            ASTFCapInfo(file="../avl/delay_10_http_post_0.pcap", cps=102.0,port=8081, ip_gen=self.next_ip_gen()),
            ASTFCapInfo(file="../avl/delay_10_https_0.pcap", cps=33.0, ip_gen=self.next_ip_gen()),
            ASTFCapInfo(file="../avl/delay_10_http_browsing_0.pcap", cps=179.0, ip_gen=self.next_ip_gen()),

            ASTFCapInfo(file="../avl/delay_10_exchange_0.pcap", cps=64.0, ip_gen=self.next_ip_gen()),

            ASTFCapInfo(file="../avl/delay_10_mail_pop_0.pcap", cps=1.2, ip_gen=self.next_ip_gen()),
            ASTFCapInfo(file="../avl/delay_10_mail_pop_1.pcap", cps=1.2, port=111, ip_gen=self.next_ip_gen()),
            ASTFCapInfo(file="../avl/delay_10_mail_pop_2.pcap", cps=1.2, port=112, ip_gen=self.next_ip_gen()),

            ASTFCapInfo(file="../avl/delay_10_oracle_0.pcap", cps=20.0, ip_gen=self.next_ip_gen()),

            ASTFCapInfo(file="../avl/delay_10_rtp_160k_0.pcap", cps=0.7, ip_gen=self.next_ip_gen()),
            ASTFCapInfo(file="../avl/delay_10_rtp_160k_1.pcap", cps=0.7, ip_gen=self.next_ip_gen()),
            ASTFCapInfo(file="../avl/delay_10_rtp_250k_0_0.pcap", cps=0.5, ip_gen=self.next_ip_gen()),
            ASTFCapInfo(file="../avl/delay_10_rtp_250k_1_0.pcap", cps=0.5, ip_gen=self.next_ip_gen()),

            ASTFCapInfo(file="../avl/delay_10_smtp_0.pcap", cps=1.85, ip_gen=self.next_ip_gen()),
            ASTFCapInfo(file="../avl/delay_10_smtp_1.pcap", cps=1.85,port=26, ip_gen=self.next_ip_gen()),
            ASTFCapInfo(file="../avl/delay_10_smtp_2.pcap", cps=1.85,port=27, ip_gen=self.next_ip_gen()),

            ASTFCapInfo(file="../avl/delay_10_video_call_0.pcap", cps=3, ip_gen=self.next_ip_gen()),

            ASTFCapInfo(file="../avl/delay_10_video_call_rtp_0.pcap", cps=7.4, ip_gen=self.next_ip_gen()),

            ASTFCapInfo(file="../avl/delay_10_citrix_0.pcap", cps=11.0, ip_gen=self.next_ip_gen()),

            ASTFCapInfo(file="../avl/cic-dns-2021-1000_benign1.pcap", cps=498.0, ip_gen=self.next_ip_gen()),

            ASTFCapInfo(file="../avl/delay_10_sip_0.pcap", cps=7.4, ip_gen=self.next_ip_gen()),
            ASTFCapInfo(file="../avl/delay_10_rtsp_0.pcap", cps=1.2, ip_gen=self.next_ip_gen()),

        ],
            #  Defaults affects all files
            default_c_glob_info=c_glob_info, default_s_glob_info=s_glob_info,
        )

        return profile

    def get_profile(self, tunables, **kwargs):
        parser = argparse.ArgumentParser(description='Argparser for {}'.format(os.path.basename(__file__)),
                                         formatter_class=argparse.ArgumentDefaultsHelpFormatter)

        parser.add_argument('--source', type=str, default=None, help='source IP addresses (comma separated CIDR addrs)')
        parser.add_argument('--destination', type=str, default=None, help='destination IP addresses (comma separated CIDR addrs)')

        args = parser.parse_args(tunables)

        return self.create_profile(args.source, args.destination)


def register():
    return Prof1()
