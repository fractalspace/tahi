#!/usr/bin/perl
#
# Copyright(C) IPv6 Promotion Council (2004,2005). All Rights Reserved.
# 
# This documentation is produced by SIP SWG members of Certification WG in 
# IPv6 Promotion Council.
# The SWG members currently include NIPPON TELEGRAPH AND TELEPHONE CORPORATION (NTT), 
# Yokogawa Electric Corporation and NTT Advanced Technology Corporation (NTT-AT).
# 
# 
# Redistribution and use of this software in source and binary forms, with 
# or without modification, are permitted provided that the following 
# conditions and disclaimer are agreed and accepted by the user:
# 
# 1. Redistributions of source code must retain the above copyright 
# notice, this list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright 
# notice, this list of conditions and the following disclaimer in the 
# documentation and/or other materials provided with the distribution.
# 
# 3. Neither the names of the copyrighters, the name of the project which 
# is related to this software (hereinafter referred to as "project") nor 
# the names of the contributors may be used to endorse or promote products 
# derived from this software without specific prior written permission.
# 
# 4. No merchantable use may be permitted without prior written 
# notification to the copyrighters. However, using this software for the 
# purpose of testing or evaluating any products including merchantable 
# products may be permitted without any notification to the copyrighters.
# 
# 
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHTERS, THE PROJECT AND 
# CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING 
# BUT NOT LIMITED THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
# FOR A PARTICULAR PURPOSE, ARE DISCLAIMED.  IN NO EVENT SHALL THE 
# COPYRIGHTERS, THE PROJECT OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, 
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES 
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) 
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
# CONTRACT,STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF 
# THE POSSIBILITY OF SUCH DAMAGE.


# Set the test version used for the display.

#use strict;

#=================================
# 
#=================================
eval("use Time::HiRes");
if(!$@){$SIM_Support_HiRes='OK';}
%CFGData;
sub SIPLoadConfig {
    my($class,@tags,$tag,$data,$val);

    # 
    open(CONFIG_TXT, "config.txt");
    while (<CONFIG_TXT>) {
	# 
	if( /^\s*#/ ){next;}
	# 
        if( /^\[(.+)\]\s*$/ ){
	    $class=$1;next;
	}
	# 
	if( /^(\S+)\s+(\S*)\s*$/ ){
	    $CFGData{$class}->{$1}=$2;
	}
    }
    close(CONFIG_TXT);
}
SIPLoadConfig();
if($CFGData{'model'}->{'ip'} =~ /^V(.)/){$SIP_PL_IP=$1;}
else{$SIP_PL_IP=6;}
$SIP_PL_TRNS  = $CFGData{'model'}->{'transport'}?$CFGData{'model'}->{'transport'}:'UDP';
$SIP_PL_TARGET= $CFGData{'model'}->{'target'}   ?$CFGData{'model'}->{'target'}:'PX';
$SIP_PLATFORM = 'V' . $SIP_PL_IP . ':' . $SIP_PL_TRNS . ':' . $SIP_PL_TARGET;
# config.txt
if($SIP_PL_TARGET eq 'PX'){
    %NDtoCFGND=('UA11'=>'target.user1','UA12'=>'target.user2','UA13'=>'target.user3','UA14'=>'target.user4',
		'UA21'=>'proxy.user1','PX2'=>'proxy', 'UA31'=>'proxy2.user1','PX3'=>'proxy2',
		'PX1'=>'target','REG'=>'registrar');
}
else{
    %NDtoCFGND=('UA11'=>'target','UA12'=>'proxy.user1','UA13'=>'proxy.user4','UA14'=>'proxy.user4',
		'PX1'=>'proxy','PX2'=>'proxy2','REG'=>'registrar');
}
sub NDCFG {
    my($key,$node)=@_;
    if(!$node){$node='others';}
    else{$node=$NDtoCFGND{$node};}
    return $CFGData{$node}->{$key};
}


#=================================
# 
#=================================
require SIPrex;
require SIPcntl;
require SIPsvc;
require SIPsce;
require SIPrule;
require SIPrule2;
require SIPSock;
use Digest::MD5 qw(md5_hex);

#=================================
# 
#=================================
# config.txt 
printf("Platform model[$SIP_PLATFORM]\n");
if($SIP_PL_IP eq 6 && $SIP_PL_TARGET eq 'UA'){
require SIPtblUA6;
require SIPruleUA;
require SIPruleIG;
require SIPseqUA6;
}
if($SIP_PL_IP eq 6 && $SIP_PL_TARGET eq 'PX'){
require SIPtblPX6;
require SIPrulePX;
require SIPrulePX2;
require SIPrulePX3;
require SIPruleIG;
require SIPruleTTC;
require SIPseqPX6;
}
if($SIP_PL_IP eq 4 && $SIP_PL_TARGET eq 'UA'){
require SIPtblUA4;
require SIPruleUA;
require SIPruleIG;
require SIPseqUA4;
}
if($SIP_PL_IP eq 4 && $SIP_PL_TARGET eq 'PX'){
require SIPtblPX4;
require SIPrulePX;
require SIPrulePX2;
require SIPrulePX3;
require SIPruleIG;
require SIPruleTTC;
require SIPseqPX4;
}

#============================
# for LOGO
#============================
require SIPkoi;
require SIPdns;
#=================================
# TAHI
#=================================
# Import the package.
use V6evalTool;

1
