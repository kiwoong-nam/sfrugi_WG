use strict;

my $inD='/home/knam/work/sfrugi_WG/GENE_ANNOTATIONS/miniprot/refseq/filtered/i5_c5';
my $outD='/home/knam/work/sfrugi_WG/GENE_ANNOTATIONS/Final/all';

opendir my $D,$inD;
my @files=readdir($D);

foreach my $file (@files)
{
	if($file!~/\w/) {next}
	my $outF="$outD/$file";
	
	my @coords;
	open my $fd,"$inD/$file";
	while(<$fd>)
	{
		if($_=~/mRNA/)
		{
			$_=~/ID=(\w+)/;
			my $id=$1;
			my @single=split("\t",$_);
			push @coords,"$single[0]\t$single[3]\t$single[4]\t$id";
		}
	}
	close $fd;

 	@coords = sort {$b cmp $a } @coords;
	
	my $preend=0;
	my $prestart=0;

	my %BAD;
	foreach my $line (@coords)
	{
		my @single=split("\t",$line);
		if($single[1] == $prestart or $single[2] ==$preend) {$BAD{$single[3]}=1}
		$prestart=$single[1];
		$preend=$single[2];
	}

	my $goods;
        open my $fd,"$inD/$file";
	while(<$fd>)
        {
		$_=~/ID=(\w+)/;
		my $id=$1;
		if($BAD{$id} eq "") {$goods.=$_}
	}
        close $fd;

	open my $fd,">$outF";
	print $fd $goods;
	close $fd;
}

