1
----------------------------------------------------
# Generate Bulk images Using dot command

my $text;

open (P,"pv.txt");
while (<P>)
{
	chomp;
	my $line = $_;
	$text = $text . createContent($line);  # Image 1
			
	# Create DOT template
	my $template=qq(		
	digraph G 
	{
		ratio=fill;
		ranksep=1;

		graph [rankdir = TB];	
		node [style=filled,color=olivedrab1,shape="circle"]
                edge [color=grey92, style=solid, arrowhead=none];
                
		rankdir=TB;
		nojustify = "true";
		labeljust = "l";
                
		$text

	}			
	); # end string		
	
	# create png filename
	my $outfile=$line;
	$outfile =~ s/#.*$//g;
	
	$outfile = lc $outfile; # Change filename to lowercase
	
	# Generate dot file name
	open(TP,"> jani.dat");
	print TP $template;
	close(TP);
	
	# process DOT file
	@txt_file_array=`twopi jani.dat -Tpng -o$outfile.png`;
	
	#@txt_file_array=`twopi jani.dat -Tps -o$outfile.ps`;
	
	$text = ""; # Nullify string


}
close(P);

#################################################
# Create Image Using Dot
#################################################
sub createContent
{
        my $str=shift; # Get input string

	my @pair_val = split('#', $str);

	my @values = split(',', $pair_val[1]);

        my $_string="";
        
        
        
        my $label_b = qq(<tr><td align="left" bgcolor="aliceblue"><b><i>__STRNG__</i></b></td></tr>
			<tr><td align="left"></td></tr>
			<tr><td align="left"></td></tr>
			<tr><td align="left"></td></tr>);

	my $label_test;
	foreach $word(@values)
	{
		$_string =  $_string . uc($pair_val[0]) . " -> \"$word\"; \n";
		
		$label_temp = $label_b;
		
		$label_temp =~ s/__STRNG__/$pair_val[0] $word/g;
		
		
		$label_test = $label_test . $label_temp . "\n";

	}
	
	
	my $label_final ="label =<<table border=\"0\">" . $label_test . "</table>>;";

	return $_string . $label_final;
}



#rankdir=LR;
#nojustify = "true";
#labeljust = "l";
#label = <<table border="0">
#<tr><td align="left" bgcolor="pink"><b><i>[1] My Test - </i></b></td></tr>
#<tr><td align="left"></td></tr>
#<tr><td align="left"></td></tr>
#<tr><td align="left"></td></tr>
#<tr><td align="left" bgcolor="pink"><b><i>[2] Your Name - </i></b></td></tr>
#<tr><td align="left"></td></tr>
#<tr><td align="left"></td></tr>
#<tr><td align="left"></td></tr>
#</table>>;


----------------------------------------------------

2
----------------------------------------------------


