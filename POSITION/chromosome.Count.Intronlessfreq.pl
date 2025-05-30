use strict;

my $inD='/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome/cochr';
my $intronD='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/structure/count';
my $outF='/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome/Count/Intronlessfreq.txt';

my $B=1000;

opendir my $D,$inD;
my @files=readdir($D);
close $D;

my $res="sample\tintronless.single\tintronless.diff\tintron.single\tintron.diff\tintronless.P\tintron.P\tintronless.P.u\tintronless.P.l\tintron.P.u\tintron.P.l\n";

foreach my $f (@files)
{
	unless($f=~/F/) {next}
	print "$f\n";

	my $listF="$intronD/$f";
	my %CNV;
	open my $fd,$listF;
	while(<$fd>)
	{
		$_=~s/\n//;
		
		my @s=split("\t",$_);
		if($s[3] ne "nonCNV" and $s[2] eq 'intact')
		{
			if($s[5]==0) {$CNV{$s[1]}=0}
			elsif($s[5]>0) {$CNV{$s[1]}=1}
		}
	}
	close $fd;

	my @dt;
	open my $fd,"$inD/$f";
	while(<$fd>)
	{
		$_=~s/\n//;
		my @s=split("\t",$_);
		if($CNV{$s[0]} ne '')
		{
			push @dt,$_;
		}
	}
	close $fd;
		
	my @bg=calct(\@dt,\%CNV);

	my @Bintronless;
	my @Bintron;
	for(my $b=0;$b<$B;$b++)
	{
		my @bdata;
		for(my $i=0;$i<=$#dt;$i++)
		{
			push @bdata,$dt[int rand ($#dt+1)];
		}
		my @bres=calct(\@bdata,\%CNV);
		push @Bintronless,$bres[4];
		push @Bintron,$bres[5];
	}
	@Bintronless=sort{$a <=> $b} @Bintronless;
	@Bintron=sort{$a <=> $b} @Bintron;

	$res.="$f\t".join("\t",@bg)."\t$Bintronless[975]\t$Bintronless[25]\t$Bintron[975]\t$Bintron[25]\n";
	print "$f\t".join("\t",@bg)."\t$Bintronless[975]\t$Bintronless[25]\t$Bintron[975]\t$Bintron[25]\n";
}

open my $fd,">$outF";
print $fd $res;
close $fd;

sub calct
{
	(my $data,my $cnvF)=(@_);
	
	my $intronless_single;
	my $intronless_diff;
	my $intron_single;
	my $intron_diff;

	foreach my $l (@$data)
	{
		my @s=split("\t",$l);
		
		if($$cnvF{$s[0]} == 0)
		{
			if($l=~/single/) {$intronless_single++}
			elsif($l!~/unknown/) {$intronless_diff++}
		}
		elsif($$cnvF{$s[0]} == 1)
		{
			if($l=~/single/) {$intron_single++}
			elsif($l!~/unknown/) {$intron_diff++}
		}
	}
	my $intronlessP=$intronless_single/($intronless_single+$intronless_diff);
	my $intronP=$intron_single/($intron_single+$intron_diff);
	
	return ($intronless_single,$intronless_diff,$intron_single,$intron_diff,$intronlessP,$intronP);
}	
				

