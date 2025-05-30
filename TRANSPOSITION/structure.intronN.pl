use strict;

my $InD='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/structure/count';
my $outF='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/structure/intronN.txt';

my $B=1000;

opendir my $D,$InD;
my @files=readdir($D);
close $D;

my $res="sample\tCNV\tmn\tl\tu\n";

foreach my $f (@files)
{
	unless($f=~/F/) {next}
	open my $fd,"$InD/$f";
	my @dt=<$fd>;
	close $fd;
		
	my @bg=calctM(@dt);

	my @BCNV;
	my @BnonCNV;

	for(my $b=0;$b<$B;$b++)
	{
		my @bdata;
		for(my $i=0;$i<=$#dt;$i++)
		{
			push @bdata,$dt[int rand ($#dt+1)];
		}
		my @bres=calctM(@bdata);
		push @BCNV,$bres[0];
		push @BnonCNV,$bres[1];
	}
	@BCNV=sort{$a <=> $b} @BCNV;
	@BnonCNV=sort{$a <=> $b} @BnonCNV;

	$res.="$f\tiORF-CNV\t$bg[0]\t$BCNV[975]\t$BCNV[25]\n";
	$res.="$f\tnon-CNV\t$bg[1]\t$BnonCNV[975]\t$BnonCNV[25]\n";

	print "$f\t".join("\t",@bg)."\n";
}

open my $fd,">$outF";
print $fd $res;
close $fd;

sub calctM
{
	(my @data)=(@_);
	
	my $S_CNV;
	my $n_CNV;
	my $S_nonCNV;
	my $n_nonCNV;

	foreach my $l (@data)
	{
		$l=~s/\n//;
		my @s=split("\t",$l);
		if($s[3] eq 'CNV' or $s[3] eq 'CNV.single')
		{
			$n_CNV++;
			$S_CNV+=$s[5];
		}
		else
		{
			$n_nonCNV++;
			$S_nonCNV+=$s[5];
		}
	}

	my $m_CNV=$S_CNV/$n_CNV;
	my $m_nonCNV=$S_nonCNV/$n_nonCNV;
	
	return ($m_CNV,$m_nonCNV)
}

