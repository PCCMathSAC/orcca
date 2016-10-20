#!/usr/bin/perl
# A perl script to insert \gls{ENTRY} automatically into each 
# chapter file (module1.tex, module2.tex, etc) for all glossary entries 
# in mainfile.tex
use strict;
use warnings;
use File::Copy;         # to copy the original file to backup (if overwrite option set)


my %glossaryentries;
# get the list of key words from mainfile.tex
open(CURRENTFILE,"mainfile.tex") or die "Could not open input file";
while(<CURRENTFILE>)
{
     if($_ !~ m/\s*%/                # and the line doesn't start with a comment
              and $_ =~ m/\\newglossaryentry{(.*?)}/  # and it contains \newglossaryentry
       )
       {
           $glossaryentries{$1}=0;
       }
}
close(CURRENTFILE);

my @lines;

my @files=("module1.tex",
               "module2.tex",
               "module3.tex",
               "module4.tex",
               "module5.tex",
               "module6.tex",
               "module7.tex",
               "module8.tex",
               "module9.tex",
               "module10.tex",
             );
@files = @ARGV if(scalar(@ARGV)>0);

foreach my $file (@files)
{
    print "Updating glossary entries in $file\n";
    # IMPORTANT: NEED to reinitialize all entries in %glossaryentries as 0
    # for each file
    foreach my $entry (keys %glossaryentries)
    {
      $glossaryentries{$entry} = 0;
    }
    
    # makes a backup with .tex.bak0, .tex.bak1, .... extension
    my $num = 0;
    $num++ while(-e $file.".bak$num");
    copy($file,$file.".bak$num") or die "$file: Could not write to backup file. Please check permissions, and exisitence of $file. Exiting.\n";

    # clear the array that contains the lines, as
    # we will operate on multiple files
    @lines = '';
    open(CURRENTFILE,$file) or die "Could not open input file";
    while(<CURRENTFILE>)
    {
       # remove all current glossary entries, \gls and \glspl
       $_=~ s/\\(gls){(.*?)}/$2/g;

       # \Gls and \Glspl are a little more intricate
       if( $_=~ m/\\(Gls){(.*?)}/)
       {
            my $tmp = ucfirst($2);
            $_=~ s/\\(Gls){(.*?)}/$tmp/g;
       }

       # loop through the glossary entries- only one occurence
       # of \gls{$entry} is necessary per file
       foreach my $entry (keys %glossaryentries)
       {
         my $ENTRY = ucfirst($entry);
         if( ( $_ =~ m/(?<!\\)$entry/           # lowercase match
               or $_ =~ m/(?<!\\)$ENTRY/ )      # match with UpperCase first
               and !$glossaryentries{$entry}    # and it hasn't already been used in this file
               and $_ !~ m/\s*%/                # and the line doesn't start with a comment
               and $_ !~ m/\\(section|chapter|begin|end|addplot)/ # and it's not in a heading or in an environment \begin or \end
           )
         {
             if($_ =~ m/\b(?<!\\)$entry\b/)         # lowercase match, with word boundary check, not preceed by \
             {
                # just ONE substitution, not global (with the g flag)
                $_ =~ s/\b$entry\b/\\gls{$entry}/;
                $glossaryentries{$entry}++;
              }
              elsif($_ =~ m/\b(?<!\\)$ENTRY\b/)     # match with UpperCase first, with word boundary check, not preceed by \
              {
                $_ =~ s/\b$ENTRY\b/\\Gls{$entry}/;
                $glossaryentries{$entry}++;
              }
         }
       }
       push(@lines,$_);
    }
   close(CURRENTFILE);

   # now dump the new lines into the file
   open(OUTPUTFILE,">",$file);
   print OUTPUTFILE @lines;
   close(OUTPUTFILE);
}

1;
