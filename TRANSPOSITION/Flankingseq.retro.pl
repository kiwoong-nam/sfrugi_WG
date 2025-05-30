use strict;

my $ID='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Flankingseq/seqs';
my $OD='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Flankingseq/retro';

my $polyAL=20;
my $TSDL=4;

opendir my $D,$ID;
my @files=readdir($D);
close $D;

foreach my $f (@files)
{
	unless($f=~/F/) {next}
	my $oF="$OD/$f";

	my $res;
	open my $fd,"$ID/$f";
	while(<$fd>)
	{
		$_=~s/\n//g;
		my @s=split("\t",$_);

		my $s3=pop @s;
		my $s5=pop @s;
		my $tid=shift @s;
		my $id=shift @s;
		my $cate=shift @s;
		my $intact=shift @s;
		my $intronN=shift @s;

		my $tsdp;
		my $l;
		while($s3=~/A{$polyAL,}/g)
		{
			my $p=pos($s3);
			$l=length($&);

			$tsdp=$p+$l;
		}

		my $tsdseq;
		L:for(my $i=0;$i<1000;$i++)
		{
			my $seq3TSD=substr($s3,$tsdp,($i+$TSDL));
			$seq3TSD=reverse $seq3TSD;
			$seq3TSD=~tr/ATGC/TACG/;
			if($s5=~/$seq3TSD/){$tsdseq=$&}
			else {last L}
		}

		if($l ne "" and $tsdseq ne "")
		{
			my @TS=split('',$tsdseq);
			my %Ls;
			foreach my $t (@TS) {$Ls{$t}=1}
			my @nts=keys %Ls;
			
			if($#nts > 0) {$res.="$tid\t$id\t$cate\t$intact\t$intronN\t$l\t$tsdseq\n"}
			else {$res.="$tid\t$id\t$cate\t$intact\t$intronN\tNA\tNA\n"}
		}
		else {$res.="$tid\t$id\t$cate\t$intact\t$intronN\tNA\tNA\n"}
	}
	close $fd;

	open my $fd,">$oF";
	print $fd $res;
	close $fd;
	
}

