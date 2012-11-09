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


# use strict;

### add by cho
sub RV_Proxy_PRACK {
    my($rule,$addrule,$conn,$timeout,$link,$frame)=@_;
    my($result);
    if( $frame eq '' ){
        if ( $SIP_PL_IP eq '6' ) {
            $frame='SIPtoPROXY';
        } elsif ( $SIP_PL_IP eq '4' ) {
            $frame='SIP4toPROXY';
        }
	}
#    if( $rule eq '' ){ $rule='D.CSEQ_LOCAL_NUM_SYNC'; }
    $result = RecvAndEvalDecodeRule($rule,$frame,PRACK,'',$addrule,$conn,$timeout,$link,'autoRegist',$SIP_DNS_ANSWER_MODE);
    MsgPrint('INF',"RV_Proxy_PRACK result[$result]\n");
  
  return $result;
}

###add by cho
sub SD_Proxy_PRACK {
    my($rule,$pktinfo,$addrule,$delrule,$conn,$link,$frame)=@_;
    my($result);
    if( $frame eq '' ){
        if ( $SIP_PL_IP eq '6' ) {
            $frame='SIPfromPROXY';
        } elsif ( $SIP_PL_IP eq '4' ) {
            $frame='SIP4fromPROXY';
        }
	}
    if( $pktinfo eq '' ){ $pktinfo=$SIPPktInfoLast; }
    if( $rule eq '' ){ $rule='E.PRACK.PX1'; }
    $result = EvalEncodeRuleAndSend($rule,$pktinfo,$frame,$addrule,$delrule,$conn,$link);
    MsgPrint('INF',"SD_Proxy_PRACK result[$result]\n");
    return $result;
}

1;

