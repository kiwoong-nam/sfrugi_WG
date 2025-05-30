use strict;

my $WD='/home/knam/work/sfrugi_WG/Assembling/Corn/HN00169586.2';

my $Idir="$WD/rawfq";
my $Odir="$WD/stats";

my $output="$Odir/throughput.txt";

opendir my $D,$Idir;
my @files=readdir($D);
close $D;

open my $fd,">$output";
print $fd "ID\tnoseq\tlength\n";
close $fd;

my @F;
foreach my $fi (@files)
{
	unless($fi=~/(\w+)_HiFi.fastq.gz/){next}
	push @F,$fi;
}

execC(@F);

sub execC
{
	(my @Fs)=(@_);
	
#	my @childs;

	foreach my $f (@Fs)
	{
#	        my $pid = fork();
#	        if ($pid) { push(@childs, $pid)} 
#	        elsif ($pid == 0)
#	        {
			$f=~/(\w+)_HiFi.fastq.gz/;
			my $id=$1;
			my $n;
			my $l=0;
			my $r=0;
			open my $fd,"zcat $Idir/$f |";
			while(<$fd>)
			{
				$n++;
				if($n%4==2)
				{
					chomp $_;
					$l+=length ($_);
					$r++;
				}
			}
			close $fd;
			print "$id\t$r\t$l\n";

			open my $fd,">>$output";
			print $fd "$id\t$r\t$l\n";
			close $fd;
#		}
#		else {die "couldnt fork: $!\n";}
	}

#	foreach (@childs) {my $tmp = waitpid($_, 0)}
}
