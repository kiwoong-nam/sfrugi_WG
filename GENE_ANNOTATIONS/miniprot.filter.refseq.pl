use strict;

my $inD='/home/knam/work/sfrugi_WG/GENE_ANNOTATIONS/miniprot/refseq/raw';
my $outD='/home/knam/work/sfrugi_WG/GENE_ANNOTATIONS/miniprot/refseq';

my @Is=(0.95,0.9);
my @Cs=(0.95,0.9);

opendir my $D,$inD;
while(readdir($D))
{
	my $gffI=$_;
	my $in="$inD/$gffI";

	unless($_=~/gff/) {next}

	foreach my $i (@Is)
	{
		foreach my $c (@Cs)
		{
			my $out="$outD/filtered/i".((1-$i)*100)."\_c".((1-$c)*100)."/$gffI";
			print "$out\n";

			my $pars=PA($in,$i,$c);

			open my $fd,">$out";
			print $fd $pars;
			close $fd;
		}
	}
}

sub PA
{
	(my $f,my $iC,my $pC)=(@_);
	
	my $block;
	my $new="#gff-version 3\n";
	my $identity;
	my $positive;
	open my $fd,$f;
	while(<$fd>)
	{
		if($_=~/#/) {next}
		if($_=~/mRNA/)
		{			
			if($f=~/F/)
			{
				if($identity > $iC and $positive > $pC) {$new.=$block}
			}

			$_=~/Identity=(\d\.\d+)/;
			$identity=$1;
			$_=~/Positive=(\d\.\d+)/;
			$positive=$1;

			undef $block;
		}
		$block.=$_;
	}
	close $fd;

	if($identity > $iC and $positive > $pC) {$new.=$block}
	return $new;
}


