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

# 
$TestVersion = '$Name:  $';

sub LoadIndex {
    my(@index);
    unless(-e 'INDEX'){
	printf("Can't load INDEX\n");
	exit;
    }
    open(INDEX, 'INDEX');
    while (<INDEX>) {
        if( /^\s*#/ ){ next;}
        if( /^(.+):(.+):.*:.*:\s*(.+)$/ ){
	    push(@index,{'seq'=>$1,'def'=>$2,'comm'=>$3});
	}
    }
    close(INDEX);
    return \@index;
}

sub CollectResult {
    my($index)=@_;
    my($no,$logfile,$log);

    foreach $no (0..$#$index){

	$logfile=($no+1).'.html';
	unless(-e $logfile){next}
	$log='';
	open(LOG,$logfile);
	while (<LOG>){$log .= $_;}
	close(LOG);

	if( $log =~ /<TR><TD>Result<\/TD><TD>\s*FATAL\s*<\/TD><\/TR>/igm ){
	    $index->[$no]->{'result'} = 'FATAL';
	}
	elsif( $log =~ /<TR><TD>Result<\/TD><TD>\s*FAIL\s*<\/TD><\/TR>/igm ){
	    $index->[$no]->{'result'} = 'FAIL';
	}
	elsif( $log =~ /<TR><TD>Result<\/TD><TD>\s*INITFAIL\s*<\/TD><\/TR>/igm ){
	    $index->[$no]->{'result'} = 'INITFAIL';
	}
	elsif( $log =~ /<TR><TD>Result<\/TD><TD>\s*IGNORE\s*<\/TD><\/TR>/igm ){
	    $index->[$no]->{'result'} = 'IGNORE';
	}
	elsif( $log =~ /<TR><TD>Result<\/TD><TD>\s*WARN\s*<\/TD><\/TR>/igm ){
	    $index->[$no]->{'result'} = 'WARN';
	}
	elsif( $log =~ /<TR><TD>Result<\/TD><TD>\s*PASS\s*<\/TD><\/TR>/igm ){
	    $index->[$no]->{'result'} = 'PASS';
	}
	else{
	    $index->[$no]->{'result'} = '---';
	}
    }
}

sub MakeResultFile {
    my($index)=@_;
    my($item,$header);
    
    open(RESULT,'>result.html');
    $header = << "RESULT_HEADER";
<HTML>
<HEAD>
<TITLE>IPv6 Conformance Test</TITLE>
<META NAME="GENERATOR" CONTENT="TAHI IPv6 Conformance Test Suite">
</HEAD>
<BODY BGCOLOR="#FFFFFF">
<CENTER>
<H1>IPv6 Conformance Test</H1>
<HR>
<TABLE BORDER=0>
<TR><TD>Test Program Version :</TD><TD>%s</TD></TR>
<TR><TD>Date:</TD><TD>%s</TD></TR>
</TABLE>
<HR>
<HR>
<TABLE BORDER=1>
<TR>
<TH>No.</TH><TH>Title</TH>
<TH>Result</TH><TH>Log</TH><TH>Script</TH><TH>Packet</TH><TH>Dump<BR>(bin)</TH>
</TR>
RESULT_HEADER

    print RESULT sprintf($header,$TestVersion,GetDateString());
    foreach $no (0..$#$index){
	print RESULT 
	    sprintf('<TR><TD>%s</TD><TD>%s</TD><TD ALIGN="CENTER"><FONT COLOR="#FF0000">%s</FONT></TD><TD ALIGN="CENTER"><A HREF="%s.html">X</A></TD><TD ALIGN="CENTER"><A HREF="%s">X</A></TD><TD ALIGN="CENTER"><A HREF="%s">X</A></TD><TD ALIGN="CENTER"><A HREF="%s.html.Link0.dump">Link0</A> </TD></TR>'."\n",
		    $no+1,$index->[$no]->{'comm'},$index->[$no]->{'result'},
		    $no+1,$index->[$no]->{'seq'},$index->[$no]->{'def'},$no+1);
    }

    print RESULT << "RESULT_FOOTER";
</TABLE>
</CENTER>
<HR>
This Report was generated by
<A HREF="http://www.tahi.org/">TAHI</A> IPv6 Conformance Test Suite
</BODY>
</HTML>
RESULT_FOOTER

    close(RESULT);
}
sub GetDateString() {
	my ($sec,$min,$hour,$day,$mon,$year) = localtime;
	my $datestr = sprintf '%04d/%02d/%02d %02d:%02d:%02d',
			$year+1900, $mon+1, $day, $hour, $min, $sec;
	$datestr;
}

my $index=LoadIndex();
CollectResult($index);
MakeResultFile($index);

