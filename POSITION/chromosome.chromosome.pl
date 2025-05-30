use strict;

my $inD='/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome/dupl';
my $outD='/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome/chromosome';
my $ragD='/home/kiwoong/Projects/sfrugi_WG/POSITION/chromosome/ragtag';

my %MAPS;
opendir my $D,$ragD;
while(readdir($D))
{
	unless($_=~/^(.*)\.ragtag.scaffold.agp/) {next}
	my $sample=$1;

	open my $fd,"$ragD/$_";
	my @info=<$fd>;
	close $fd;

	foreach my $line (@info)
	{
		my @s=split("\t",$line);
		if($s[4] eq "W" and $line=~/HiC/)
		{
			my $k="$sample\t$s[5]";
			$s[0]=~s/HiC_scaffold_//g;
			$s[0]=~s/_RagTag//g;
 
			$MAPS{$k}=$s[0];
		}
	}
	close $fd;

}

opendir my $D,$inD;
while(readdir($D))
{
	unless($_=~/^(.*)\.dupl/) {next}
	my $sample=$1;
	if($sample!~/FC/) {next}
	my $output="$outD/$sample.chrs.dupl";
	
	my $res;
	open my $fd,"$inD/$_";
	my @data=<$fd>;
	close $fd;

	foreach my $line (@data)
	{
		$line=~s/\n//g;
		my @single=split("\t",$line);
		my $id=shift @single;
		my @cts;
		foreach my $s (@single)
		{
			my $key="$sample\t$s";
			if($MAPS{$key} ne "") {push @cts,$MAPS{$key};}
		}
		@cts = sort {$a <=> $b} @cts;
		if($#cts>-1)
		{
			$res.="$id\t".join(",",@cts)."\n";
		}
	}
	close $fd;
	
	open my $fd,">$output";
	print $fd $res;
	close $fd;	
}

