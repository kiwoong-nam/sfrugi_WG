use strict;

my $gffF="/home/kiwoong/Projects/sfrugi_WG/MALADAPTATION/Annotation/ver7.final.gff";
my $CNVU='/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/UTR/ver7/blasting/nonredundance.CNV.pos';
my $nCNVU='/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/UTR/ver7/blasting/nonredundance.nonCNV.pos';
my $TEF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/TE/repeatmasker/ver7_RepeatModeler/sfC.ver7.fa.out';
my $cnvlistF='/home/kiwoong/Projects/sfrugi_WG/CNV_Gene/CNVTE/list.txt';
my $OD="/home/kiwoong/Projects/sfrugi_WG/TRANSCRIPTION/UTR/readdepth/bed";

##########################

my %cnv;
open my $fd,$cnvlistF;
while(<$fd>)
{
        $_=~s/\n//;     
        my @s=split("\t",$_);
        if($s[1] eq 'nonCNV.GENE') {$cnv{$s[0]}='no'}
        elsif($s[1] eq 'CNV.GENE') {$cnv{$s[0]}='yes'}  
}
close $fd;

my %UCNV;
my %UnonCNV;
my %GFF;
my %TER;

print "read data\n";
getdata();

my $CDS_CNV;
my $CDS_nonCNV;
my $Intergenic;
my $Intronic;
my $TE;
my $UCNV;
my $UnonCNV;

for(my $i=1;$i<30;$i++)
{
	my $chrN="HiC_scaffold_$i";	
	print "treat $chrN\n";
	
	my @TEdata=split("\n",$TER{$chrN});
	my @gffD=split("\n",$GFF{$chrN});
	my @cnvu=split("\n",$UCNV{$i});
	my @ncnvu=split("\n",$UnonCNV{$i});
	
	my %TE;
	foreach my $d (@TEdata)
	{
		my @s=split("\t",$d);
		$TE.="$chrN\t$s[0]\t$s[1]\n";
		for(my $i=$s[0];$i<$s[1];$i++) {$TE{$i}=1}
	}

	foreach my $d (@cnvu)
	{
		my @s=split("\t",$d);
		for(my $i=$s[0];$i<$s[1];$i++)
		{
			my $k=$i+1;
			if($TE{$i} eq '') {$UCNV.="$chrN\t$i\t$k\n"}
		}
	}

	foreach my $d (@ncnvu)
	{
		my @s=split("\t",$d);
		for(my $i=$s[0];$i<$s[1];$i++)
		{
			my $k=$i+1;
			if($TE{$i} eq '') {$UnonCNV.="$chrN\t$i\t$k\n"}
		}
	}

	my @mRNA;
	my @singleCDS;
	foreach my $g (@gffD)
	{
		my @s=split("\t",$g);
			
		if($s[0] eq 'CDS')
		{
			if($cnv{$s[3]} eq 'no'){$CDS_nonCNV.="$chrN\t$s[1]\t$s[2]\n"}
			elsif($cnv{$s[3]} eq 'yes'){$CDS_CNV.="$chrN\t$s[1]\t$s[2]\n"}
			
			push @singleCDS,"$s[1]\t$s[2]";
		}		
		elsif($s[0] eq 'mRNA')
		{
			if($#singleCDS>0)
			{
				my @PS=parseD($chrN,\@singleCDS);
				$Intronic.=getINTERGEN($chrN,\@PS,\%TE);
			}
			undef @singleCDS;
			push @mRNA,"$s[1]\t$s[2]";	
		}
	}
	if($#singleCDS>0)
	{
		my @PS=parseD($chrN,\@singleCDS);
		$Intronic.=getINTERGEN($chrN,\@PS,\%TE);
	}

	my @PSC=parseD($chrN,\@mRNA);
	$Intergenic.=getINTERGEN($chrN,\@PSC,\%TE);

	saveF();
}

###########################

sub saveF
{
	open my $fd,">$OD/Upstream.CNV.bed";
	print $fd $UCNV;
	close $fd;

	open my $fd,">$OD/Upstream.nonCNV.bed";
	print $fd $UnonCNV;
	close $fd;

	open my $fd,">$OD/TE.bed";
	print $fd $TE;
	close $fd;

	open my $fd,">$OD/CDS_CNV.bed";
	print $fd $CDS_CNV;
	close $fd;

	open my $fd,">$OD/CDS_nonCNV.bed";
	print $fd $CDS_nonCNV;
	close $fd;

	open my $fd,">$OD/Intron.bed";
	print $fd $Intronic;
	close $fd;

	open my $fd,">$OD/Intergenic.bed";
	print $fd $Intergenic;
	close $fd;
}

sub parseD
{
	(my $chrN,my $data)=(@_);
	my %gnc;
	foreach my $p (@$data)
	{
		my @ps=split("\t",$p);
		for(my $pp=$ps[0];$pp<$ps[1];$pp++) {$gnc{$pp}=1}
	}

	my @genic=sort {$a <=>$b} keys %gnc;
	undef %gnc;
	
	my @genes;
	my $start=$genic[0];
	for(my $i=0;$i<$#genic;$i++)
	{
		if($genic[$i]+1 == $genic[$i+1]) {next}
		else
		{
			my $end=$genic[$i];
			push @genes,"$start\t$end";
			$start=$genic[$i+1]
		}
	}	
	
	undef @genic;

	return @genes;	
}


sub getINTERGEN
{
	(my $chrN,my $data,my $TEData)=(@_);

	my $res;	
	for(my $i=0;$i<$#$data;$i++)
	{
		my @ds1=split("\t",$$data[$i]);
		my @ds2=split("\t",$$data[$i+1]);
		my $intronS=$ds1[1];
		my $intronE=$ds2[0];
		if($intronS > $intronE)
		{
			my $intronEE=$intronE;
			$intronE=$intronS;
			$intronS=$intronEE;		
		}
		for(my $j=$intronS;$j<$intronE;$j++)
		{
			my $k=$j+1;
			if($$TEData{$j} eq "") { $res.="$chrN\t$j\t$k\n"};
		}

	}
	return $res;
}

sub UEXT
{
	(my $fI,my $T)=(@_);
	
	my $res;
	open my $fd,$fI;
	while(<$fd>)
	{
		if($_=~/chromosome/) {next}
		my @s=split("\t",$_);
		$res.="HiC_scaffold_$s[0]\t$s[1]\t$s[2]\n";
	}
	close $fd;
	
	open my $fd,">$OD/$T.bed";
	print $fd $res;
	close $fd;
}


sub getdata
{
	open my $fd,$CNVU;
	while(<$fd>)
	{
		if($_=~/chromosome/) {next}
		my @s=split("\t",$_);
		$UCNV{$s[0]}.="$s[1]\t$s[2]\n";
	}
	close $fd;

	open my $fd,$nCNVU;
	while(<$fd>)
	{
		if($_=~/chromosome/) {next}
		my @s=split("\t",$_);
		$UnonCNV{$s[0]}.="$s[1]\t$s[2]\n";
	}
	close $fd;


	open my $fd,$gffF;
	while(<$fd>)
	{
		if($_=~/^#/) {next}

		$_=~s/\n//g;
		my @s=split("\t",$_);
		if($s[2] eq 'mRNA' or $s[2] eq 'CDS')
		{
			$_=~/Target=(\w+)/;
			my $id=$1;
			$GFF{$s[0]}.="$s[2]\t$s[3]\t$s[4]\t$id\n";
		} 

	}
	close $fd;

	open my $fd,$TEF;
	while(<$fd>)
	{
		unless($_=~/HiC_scaffold_/) {next}
		$_=~s/^ {1,}//;
		$_=~s/ {1,}$//;
		$_=~s/ {1,}/\t/g;
		my @s=split("\t",$_);

		$TER{$s[4]}.="$s[5]\t$s[6]\n";
	}
	close $fd;
}

