use strict;

my $id='/home/knam/work/sfrugi_WG/GENE_ANNOTATIONS/seq/assembly';
my $ld='/home/knam/work/sfrugi_WG/GENE_ANNOTATIONS/miniprot/library';
opendir my $D,$id;
while(readdir($D))
{
        if($_=~/(^.*).fa.gz/)
        {
                my $sample=$1;
                `/home/knam/save/programs/miniprot/miniprot -t4 -d $ld/$sample $id/$_`;
        }
}
close $D;
