use strict;

my $InD='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/structure/count';
my $outD='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION_short/structure';
my $B=1000;

my $outF1='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION_short/structure/propintronless.txt';
my $outF2='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION_short/structure/propintronless_st.txt';

my $res1="Lmn\tLmx\tsample\tcate\tm\tu\tl\n";
my $res2="Lmn\tLmx\tsample\tintronless.CNV\tintron.CNV\tintronless.nonCNV\tintron.nonCNV\n";

opendir my $D,$InD;
my @files=readdir($D);
close $D;

exet(0,1000);
exet(1000,2000);

sub exet
{
	(my $mn,my $mx)=(@_);


	foreach my $f (@files)
	{
		unless($f=~/F/) {next}

		open my $fd,"$InD/$f";
		my @dtr=<$fd>;
		close $fd;
		
		my @dt;
		foreach my $d (@dtr)
		{
			my @s=split("\t",$d);
			if($s[4]>=$mn and $s[4]<$mx) {push @dt,$d}
		}

		my @bg=calct(@dt);

		print "$mx: $f\t$bg[4]\t$bg[5]\n";

		my @BCNV;
		my @BnonCNV;
		for(my $b=0;$b<$B;$b++)
		{
			my @bdata;
			for(my $i=0;$i<=$#dt;$i++)
			{
				push @bdata,$dt[int rand ($#dt+1)];
			}
			my @bres=calct(@bdata);
			push @BCNV,$bres[4];
			push @BnonCNV,$bres[5];
		}
		@BCNV=sort{$a <=> $b} @BCNV;
		@BnonCNV=sort{$a <=> $b} @BnonCNV;

		$res1.="$mn\t$mx\t$f\tiORF-CNV\t$bg[4]\t$BCNV[975]\t$BCNV[25]\n";
		$res1.="$mn\t$mx\t$f\tnon.CNV\t$bg[5]\t$BnonCNV[975]\t$BnonCNV[25]\n";

		pop @bg;
		pop @bg;

		$res2.="$mn\t$mx\t$f\t".join("\t",@bg)."\n";
		
		open my $fd,">$outF1";
		print $fd $res1;
		close $fd;

		open my $fd,">$outF2";
		print $fd $res2;
		close $fd;
	}
}

sub calct
{
	(my @data)=(@_);
	
	my $intronless_CNV;
	my $intronless_nonCNV;
	my $intron_CNV;
	my $intron_nonCNV;

	foreach my $l (@data)
	{
		my @s=split("\t",$l);
		if($s[5] == 0)
		{
			if($s[3] eq 'CNV' or $s[3] eq 'CNV.single') {$intronless_CNV++}
			else {$intronless_nonCNV++}
		}
		elsif($s[5] > 0)
		{
			if($s[3] eq 'CNV' or $s[3] eq 'CNV.single') {$intron_CNV++}
			else {$intron_nonCNV++}
		}
	}

	my $cnvP=$intronless_CNV/($intron_CNV+$intronless_CNV);
	my $noncnvP=$intronless_nonCNV/($intron_nonCNV+$intronless_nonCNV);
	
	return ($intronless_CNV,$intron_CNV,$intronless_nonCNV,$intron_nonCNV,$cnvP,$noncnvP);
}	
				

