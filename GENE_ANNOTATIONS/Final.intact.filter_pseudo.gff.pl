use strict;

my $inD='/home/knam/work/sfrugi_WG/GENE_ANNOTATIONS/miniprot/refseq/filtered/i5_c5';
my $inD='/home/knam/work/sfrugi_WG/GENE_ANNOTATIONS/Final/all';
my $outD='/home/knam/work/sfrugi_WG/GENE_ANNOTATIONS/Final/intact/filter_pseudo/gff';

opendir my $D,$inD;
my @files=readdir($D);

foreach my $file (@files)
{
	if($file!~/\w/) {next}
	my $outF="$outD/$file";
	
	my %stops;
	my $good;
	open my $fd,"$inD/$file";
	while(<$fd>)
	{
		if($_=~/mRNA/)
		{
			print $_;
			$_=~/ID=(\w+)/;
			my $id=$1;
			if($_=~/Frame/ or $_=~/Stop/)
			{
				$stops{$id}=1;
				next
			}
			else {$good.=$_}
		}
		else
		{
			$_=~/Parent=(\w+)/;
			my $pID=$1;
			if($stops{$pID} eq '') {$good.=$_}
		}
	}
	close $fd;
	
	open my $fd,">$outF";
	print $fd $good;
	close $fd;
	
}

