use strict;

my $ID='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Flankingseq/retro';
my $oD='/home/kiwoong/Projects/sfrugi_WG/TRANSPOSITION/Flankingseq/retro.gene';

opendir my $D,$ID;
my @files=readdir($D);
close $D;

#intronless, CNV
#intronless, nonCNV
#nonCNV

foreach my $f (@files)
{
	unless($f=~/F/) {next}
	my $oF="$oD/$f";
	
	my %RETRO;
	my %INTRONLESS;
	my %CNV;

	open my $fd,"$ID/$f";
	while(<$fd>)
	{
		my @s=split("\t",$_);
		$RETRO{$s[0]}='no';
		$INTRONLESS{$s[0]}='no';
		$CNV{$s[0]}='no';
	}
	close $fd;

	open my $fd,"$ID/$f";
	while(<$fd>)
	{
		my @s=split("\t",$_);
		my $retro='yes';

		if($_!~/NA/) {$RETRO{$s[0]}='yes'}
		if($s[2] eq 'CNV') {$CNV{$s[0]}='yes'}
		if($s[4] ==0) {$INTRONLESS{$s[0]}='yes'}
	}
	close $fd;

	my @genes=keys %RETRO;

	my $res="gene\tretro\tCNV\tintronless\n";
	foreach my $g (@genes)
	{
		$res.="$g\t$RETRO{$g}\t$CNV{$g}\t$INTRONLESS{$g}\n";
	}

	open my $fd,">$oF";
	print $fd $res;
	close $fd;
	
}	


